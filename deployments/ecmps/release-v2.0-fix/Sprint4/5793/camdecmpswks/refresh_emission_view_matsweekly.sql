CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_matsweekly(IN vmonplanid character varying, IN vrptperiodid numeric)
 LANGUAGE plpgsql
AS $procedure$
BEGIN
  RAISE NOTICE 'Loading temp_weekly_test_errors...';
	CALL camdecmpswks.load_temp_weekly_test_errors(vMonPlanId, vRptPeriodId);

  RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmpswks.EMISSION_VIEW_MATSWEEKLY
	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;

  RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmpswks.EMISSION_VIEW_MATSWEEKLY(
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
	LEFT JOIN	camdecmpswks.WEEKLY_TEST_SUMMARY wts 
		ON ts.WEEKLY_TEST_SUM_ID = wts.WEEKLY_TEST_SUM_ID
		AND ts.MON_LOC_ID = wts.MON_LOC_ID
		AND ts.RPT_PERIOD_ID = wts.RPT_PERIOD_ID
	LEFT JOIN camdecmpswks.WEEKLY_SYSTEM_INTEGRITY wsi 
		ON wts.WEEKLY_TEST_SUM_ID = wsi.WEEKLY_TEST_SUM_ID
		AND wts.MON_LOC_ID = wsi.MON_LOC_ID
		AND wts.RPT_PERIOD_ID = wsi.RPT_PERIOD_ID
	LEFT JOIN camdecmpswks.MONITOR_SPAN MS  
		ON wts.MON_LOC_ID = MS.MON_LOC_ID 
		AND ts.COMPONENT_TYPE_CD = MS.COMPONENT_TYPE_CD 
		AND Coalesce(wts.SPAN_SCALE_CD,'') = Coalesce(MS.SPAN_SCALE_CD,'')
		AND camdecmpswks.emissions_monitor_span_active(MS.BEGIN_DATE, MS.BEGIN_HOUR, MS.END_DATE, MS.END_HOUR, TS.TEST_DATE, LEFT(ts.TEST_TIME, 2)) = 1;

  RAISE NOTICE 'Refreshing view counts...';
  CALL camdecmpswks.refresh_emission_view_count(vmonplanid, vrptperiodid, 'MATSWEEKLY');
END
$procedure$
