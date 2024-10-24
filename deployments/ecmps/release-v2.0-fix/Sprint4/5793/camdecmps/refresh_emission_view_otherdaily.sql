CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_otherdaily(IN vmonplanid character varying, IN vrptperiodid numeric)
 LANGUAGE plpgsql
AS $procedure$
BEGIN
	CALL camdecmps.load_temp_daily_test_errors(vMonPlanId, vRptPeriodId);

	DELETE FROM camdecmps.EMISSION_VIEW_OTHERDAILY 
	WHERE MON_PLAN_ID = vmonplanid AND RPT_PERIOD_ID = vrptperiodid;

	INSERT INTO camdecmps.EMISSION_VIEW_OTHERDAILY
           (MON_PLAN_ID
           ,MON_LOC_ID
           ,RPT_PERIOD_ID
           ,TEST_TYPE_CD
           ,SYSTEM_COMPONENT_IDENTIFIER
		   ,SYSTEM_COMPONENT_TYPE
           ,SPAN_SCALE_CD
           ,DATE_HOUR
           ,RPT_TEST_RESULT
           ,CALC_TEST_RESULT_CD
           ,TEST_SUM_ID
           ,ERROR_CODES)
		
		SELECT DISTINCT
				DTS.MON_PLAN_ID, 
				DTS.MON_LOC_ID, 
				DTS.RPT_PERIOD_ID,
				DTS.TEST_TYPE_CD,
				DTS.SYSTEM_COMPONENT_IDENTIFIER,
				DTS.SYSTEM_COMPONENT_TYPE,
				DTS.SPAN_SCALE_CD,
				DTS.END_DATE || ' ' || DTS.END_TIME,
				DTS.TEST_RESULT_CD AS RPT_TEST_RESULT,
				DTS.CALC_TEST_RESULT_CD,
				DTS.DAILY_TEST_SUM_ID,
				DTS.ERROR_CODES
		FROM temp_daily_test_errors DTS
		WHERE DTS.TEST_TYPE_CD <> 'DAYCAL';

  CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'OTHERDAILY');
END
$procedure$
