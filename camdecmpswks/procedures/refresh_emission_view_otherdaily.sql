-- PROCEDURE: camdecmpswks.refresh_emission_view_otherdaily(character varying, numeric)

DROP PROCEDURE IF EXISTS camdecmpswks.refresh_emission_view_otherdaily(character varying, numeric);

CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_otherdaily(
	vmonplanid character varying,
	vrptperiodid numeric)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	CALL camdecmpswks.load_temp_daily_test_errors(vMonPlanId, vRptPeriodId);

	DELETE FROM camdecmpswks.EMISSION_VIEW_OTHERDAILY 
		WHERE MON_PLAN_ID = vmonplanid AND RPT_PERIOD_ID = vrptperiodid;

	INSERT INTO camdecmpswks.EMISSION_VIEW_OTHERDAILY
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

  CALL camdecmpswks.refresh_emission_view_count(vmonplanid, vrptperiodid, 'OTHERDAILY');
END
$BODY$;
