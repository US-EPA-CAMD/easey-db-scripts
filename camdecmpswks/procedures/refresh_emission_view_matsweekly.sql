-- PROCEDURE: camdecmpswks.refresh_emission_view_matsweekly(character varying, numeric)

-- DROP PROCEDURE camdecmpswks.refresh_emission_view_matsweekly(character varying, numeric);

CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_matsweekly(
	vmonplanid character varying,
	vrptperiodid numeric)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	DELETE FROM camdecmpswks.EMISSION_VIEW_MATS_WEEKLY
		WHERE MON_PLAN_ID = vmonplanid AND RPT_PERIOD_ID = vrptperiodid;

	INSERT INTO camdecmpswks.EMISSION_VIEW_MATS_WEEKLY
           (MON_PLAN_ID
           ,MON_LOC_ID
           ,RPT_PERIOD_ID
	,WEEKLY_TEST_SUM_ID
	,SYSTEM_COMPONENT_IDENTIFIER
	,SYSTEM_COMPONENT_TYPE
	,DATE_HOUR
	,TEST_TYPE
	,TEST_RESULT
	,SPAN_SCALE
	,GAS_LEVEL
	,REF_VALUE
	,MEASURED_VALUE
	,SYSTEM_INTEGRITY_ERROR
	,ERROR_CODES)
SELECT 	
	ts.MON_PLAN_ID
	,ts.MON_LOC_ID
	,ts.RPT_PERIOD_ID
	,wts.WEEKLY_TEST_SUM_ID
	,SYSTEM_COMPONENT_IDENTIFIER
	,SYSTEM_COMPONENT_TYPE
	,ts.TEST_DATE || ' ' || ts.TEST_TIME 
	,wts.TEST_TYPE_CD
	,wts.TEST_RESULT_CD
	,wts.SPAN_SCALE_CD
	,wsi.GAS_LEVEL_CD
	,wsi.REF_VALUE
	,wsi.MEASURED_VALUE
	,wsi.SYSTEM_INTEGRITY_ERROR
	,ts.ERROR_CODES
		FROM temp_weekly_test_errors ts
		LEFT OUTER JOIN	camdecmpswks.WEEKLY_TEST_SUMMARY wts  on wts.WEEKLY_TEST_SUM_ID = ts.WEEKLY_TEST_SUM_ID
		LEFT OUTER JOIN camdecmpswks.WEEKLY_SYSTEM_INTEGRITY wsi ON wts.WEEKLY_TEST_SUM_ID=wsi.WEEKLY_TEST_SUM_ID
		LEFT OUTER JOIN camdecmpswks.MONITOR_SPAN MS  on wts.MON_LOC_ID = MS.MON_LOC_ID 
												AND ts.COMPONENT_TYPE_CD = MS.COMPONENT_TYPE_CD 
												AND Coalesce(wts.SPAN_SCALE_CD,'') = Coalesce(MS.SPAN_SCALE_CD,'')	-- both could be null, and null=null is not true!
												AND (camdecmpswks.emissions_monitor_span_active(MS.BEGIN_DATE, MS.BEGIN_HOUR, MS.END_DATE, MS.END_HOUR, TS.TEST_DATE, LEFT(ts.TEST_TIME, 2)) = 1);
END
$BODY$;
