-- PROCEDURE: camdecmpswks.load_temp_weekly_test_errors(character varying, numeric)

DROP PROCEDURE IF EXISTS camdecmpswks.load_temp_weekly_test_errors(character varying, numeric);

CREATE OR REPLACE PROCEDURE camdecmpswks.load_temp_weekly_test_errors(
	vmonplanid character varying,
	vrptperiodid numeric)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	INSERT INTO temp_weekly_test_errors
		(
			WEEKLY_TEST_SUM_ID, 
			MON_PLAN_ID, 
			MON_LOC_ID, 
			RPT_PERIOD_ID, 
			MON_SYS_ID,
			COMPONENT_ID, 
			COMPONENT_IDENTIFIER,
			COMPONENT_TYPE_CD,
			SYSTEM_COMPONENT_IDENTIFIER,
			SYSTEM_COMPONENT_TYPE,
			SPAN_SCALE_CD, 
			TEST_DATE, 
			TEST_TIME, 
			TEST_TYPE_CD, 
			TEST_RESULT_CD, 
			CALC_TEST_RESULT_CD,
			ERROR_CODES
		)
		(SELECT	DISTINCT 
				wts.WEEKLY_TEST_SUM_ID, 
				mpl.MON_PLAN_ID,
				mpl.MON_LOC_ID,
				wts.RPT_PERIOD_ID, 
				wts.MON_SYS_ID,
				wts.COMPONENT_ID,
				cmp.COMPONENT_IDENTIFIER, 
				cmp.COMPONENT_TYPE_CD,
				Coalesce(ms.SYSTEM_IDENTIFIER,cmp.COMPONENT_IDENTIFIER) as SYSTEM_COMPONENT_IDENTIFIER,
				Coalesce(ms.SYS_TYPE_CD, cmp.COMPONENT_TYPE_CD) as SYSTEM_COMPONENT_TYPE,
				wts.SPAN_SCALE_CD, 
				wts.TEST_DATE, 
				camdecmpswks.format_time(TEST_HOUR, TEST_MIN) as TEST_TIME,
				wts.TEST_TYPE_CD, 
				wts.TEST_RESULT_CD, 
				wts.CALC_TEST_RESULT_CD, 
				CASE WHEN max(Coalesce(sev.SEVERITY_LEVEL, 0)) > 0 THEN 'View Errors' ELSE NULL END AS ERROR_CODES
				FROM camdecmpswks.WEEKLY_TEST_SUMMARY wts
					JOIN camdecmpswks.MONITOR_PLAN_LOCATION mpl ON wts.MON_LOC_ID = mpl.MON_LOC_ID
					JOIN camdecmpswks.EMISSION_EVALUATION evl ON evl.MON_PLAN_ID = mpl.MON_PLAN_ID AND evl.RPT_PERIOD_ID = vrptperiodid								
					LEFT JOIN camdecmpswks.MONITOR_SYSTEM AS ms ON ms.MON_SYS_ID = wts.MON_SYS_ID
					LEFT JOIN camdecmpswks.COMPONENT AS cmp ON cmp.COMPONENT_ID = wts.COMPONENT_ID
					LEFT JOIN camdecmpswks.CHECK_LOG log ON log.CHK_SESSION_ID = evl.CHK_SESSION_ID 	AND log.TEST_SUM_ID = wts.WEEKLY_TEST_SUM_ID
					LEFT JOIN camdecmpsmd.SEVERITY_CODE sev ON sev.SEVERITY_CD = log.SEVERITY_CD
				WHERE mpl.MON_PLAN_ID = vmonplanid
							  AND wts.RPT_PERIOD_ID = vrptperiodid
			GROUP BY
							wts.WEEKLY_TEST_SUM_ID, 
				mpl.MON_PLAN_ID,
				mpl.MON_LOC_ID,
				wts.RPT_PERIOD_ID, 
				wts.MON_SYS_ID,
				wts.COMPONENT_ID,
				cmp.COMPONENT_IDENTIFIER, 
				cmp.COMPONENT_TYPE_CD,
				Coalesce(ms.SYSTEM_IDENTIFIER,cmp.COMPONENT_IDENTIFIER),
				Coalesce(ms.SYS_TYPE_CD, cmp.COMPONENT_TYPE_CD),
				wts.SPAN_SCALE_CD, 
				wts.TEST_DATE, 
				camdecmpswks.format_time(TEST_HOUR, TEST_MIN),
				wts.TEST_TYPE_CD, 
				wts.TEST_RESULT_CD, 
				wts.CALC_TEST_RESULT_CD);
END
$BODY$;
