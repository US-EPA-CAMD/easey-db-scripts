-- PROCEDURE: camdecmps.refresh_emission_view_matsweekly(character varying, numeric)

DROP PROCEDURE IF EXISTS camdecmps.refresh_emission_view_matsweekly(character varying, numeric);

CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_matsweekly(
	vmonplanid character varying,
	vrptperiodid numeric
)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	CALL camdecmps.load_temp_weekly_test_errors(vMonPlanId, vRptPeriodId);

	DELETE FROM camdecmps.EMISSION_VIEW_MATSWEEKLY
	WHERE MON_PLAN_ID = vmonplanid AND RPT_PERIOD_ID = vrptperiodid;

	INSERT INTO camdecmps.EMISSION_VIEW_MATSWEEKLY(
		MON_PLAN_ID,
		MON_LOC_ID,
		RPT_PERIOD_ID,
		WEEKLY_TEST_SUM_ID,
		SYSTEM_COMPONENT_IDENTIFIER,
		SYSTEM_COMPONENT_TYPE,
		DATE_HOUR,
		TEST_TYPE,
		TEST_RESULT,
		SPAN_SCALE,
		GAS_LEVEL,
		REF_VALUE,
		MEASURED_VALUE,
		SYSTEM_INTEGRITY_ERROR,
		ERROR_CODES
	)
	SELECT
		ts.MON_PLAN_ID,
		ts.MON_LOC_ID,
		ts.RPT_PERIOD_ID,
		wts.WEEKLY_TEST_SUM_ID,
		SYSTEM_COMPONENT_IDENTIFIER,
		SYSTEM_COMPONENT_TYPE,
		ts.TEST_DATE || ' ' || ts.TEST_TIME, 
		wts.TEST_TYPE_CD,
		wts.TEST_RESULT_CD,
		wts.SPAN_SCALE_CD,
		wsi.GAS_LEVEL_CD,
		wsi.REF_VALUE,
		wsi.MEASURED_VALUE,
		wsi.SYSTEM_INTEGRITY_ERROR,
		ts.ERROR_CODES
	FROM temp_weekly_test_errors ts
	LEFT OUTER JOIN	camdecmps.WEEKLY_TEST_SUMMARY wts 
		ON ts.WEEKLY_TEST_SUM_ID = wts.WEEKLY_TEST_SUM_ID
		AND ts.MON_LOC_ID = wts.MON_LOC_ID
		AND ts.RPT_PERIOD_ID = wts.RPT_PERIOD_ID
	LEFT OUTER JOIN camdecmps.WEEKLY_SYSTEM_INTEGRITY wsi 
		ON wts.WEEKLY_TEST_SUM_ID = wsi.WEEKLY_TEST_SUM_ID
		AND wts.MON_LOC_ID = wsi.MON_LOC_ID
		AND wts.RPT_PERIOD_ID = wsi.RPT_PERIOD_ID
	LEFT OUTER JOIN camdecmps.MONITOR_SPAN MS  
		ON wts.MON_LOC_ID = MS.MON_LOC_ID 
		AND ts.COMPONENT_TYPE_CD = MS.COMPONENT_TYPE_CD 
		AND Coalesce(wts.SPAN_SCALE_CD,'') = Coalesce(MS.SPAN_SCALE_CD,'')
		AND camdecmps.emissions_monitor_span_active(MS.BEGIN_DATE, MS.BEGIN_HOUR, MS.END_DATE, MS.END_HOUR, TS.TEST_DATE, LEFT(ts.TEST_TIME, 2)) = 1;

  CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'MATSWEEKLY');
END
$BODY$;

/*
----------------------------------------------------------------------------------------
FOR TESTING PURPOSES ONLY
----------------------------------------------------------------------------------------
DROP TABLE temp_weekly_test_errors;
CALL camdecmps.load_temp_weekly_test_errors('MDC-94FE334B615548CDB3F22AED7D333EEF', 120);

select a.mon_plan_id, *
from camdecmps.monitor_plan_location a
JOIN camdecmps.WEEKLY_TEST_SUMMARY wts 
	ON a.MON_LOC_ID = wts.MON_LOC_ID
	AND wts.RPT_PERIOD_ID = 120	
order by a.mon_loc_id
*/