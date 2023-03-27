-- PROCEDURE: camdecmpswks.load_temp_daily_test_errors(character varying, numeric)

DROP PROCEDURE IF EXISTS camdecmpswks.load_temp_daily_test_errors(character varying, numeric);

CREATE OR REPLACE PROCEDURE camdecmpswks.load_temp_daily_test_errors(
	vmonplanid character varying,
	vrptperiodid numeric)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	INSERT INTO temp_daily_test_errors(
		DAILY_TEST_SUM_ID,
		MON_PLAN_ID, 
		MON_LOC_ID, 
		RPT_PERIOD_ID, 
		COMPONENT_ID, 
		COMPONENT_IDENTIFIER,
		COMPONENT_TYPE_CD,
		SYSTEM_COMPONENT_IDENTIFIER,
		SYSTEM_COMPONENT_TYPE,
		SPAN_SCALE_CD, 
		END_DATE, 
		END_TIME, 
		TEST_TYPE_CD, 
		TEST_RESULT_CD, 
		CALC_TEST_RESULT_CD,
		ERROR_CODES
	)
	SELECT	DISTINCT 
		dts.DAILY_TEST_SUM_ID, 
		mpl.MON_PLAN_ID, 
		mpl.MON_LOC_ID, 
		dts.RPT_PERIOD_ID, 
		dts.COMPONENT_ID,
		cmp.COMPONENT_IDENTIFIER,
		cmp.COMPONENT_TYPE_CD,
		Coalesce(ms.SYSTEM_IDENTIFIER, cmp.COMPONENT_IDENTIFIER) AS SYSTEM_COMPONENT_IDENTIFIER,
		Coalesce(ms.SYS_TYPE_CD, cmp.COMPONENT_TYPE_CD) AS SYSTEM_COMPONENT_TYPE,
		dts.SPAN_SCALE_CD, 
		dts.DAILY_TEST_DATE AS END_DATE, 
		camdecmpswks.format_time( dts.DAILY_TEST_HOUR, dts.DAILY_TEST_MIN ) AS END_TIME,
		dts.TEST_TYPE_CD, 
		dts.TEST_RESULT_CD, 
		dts.CALC_TEST_RESULT_CD, 
		CASE
			WHEN MAX(Coalesce(sev.SEVERITY_LEVEL, 0)) > 0 THEN 'View Errors'
			ELSE NULL
		END AS ERROR_CODES
	FROM (
		SELECT mpl.MON_PLAN_ID, mpl.MON_LOC_ID
		FROM camdecmpswks.MONITOR_PLAN_LOCATION AS mpl
		WHERE mpl.MON_PLAN_ID = vMonPlanId
	) AS mpl
	INNER JOIN camdecmpswks.DAILY_TEST_SUMMARY dts
		ON dts.MON_LOC_ID = mpl.MON_LOC_ID
		AND dts.RPT_PERIOD_ID = vRptPeriodId
	LEFT OUTER JOIN camdecmpswks.EMISSION_EVALUATION evl
		ON evl.MON_PLAN_ID = mpl.MON_PLAN_ID
		AND evl.RPT_PERIOD_ID = vRptPeriodId
	LEFT OUTER JOIN camdecmpswks.MONITOR_SYSTEM AS ms
		ON ms.MON_SYS_ID = dts.MON_SYS_ID
	LEFT OUTER JOIN camdecmpswks.COMPONENT AS cmp
		ON cmp.COMPONENT_ID = dts.COMPONENT_ID
	LEFT OUTER JOIN camdecmpswks.CHECK_LOG AS cl
		ON cl.CHK_SESSION_ID = evl.CHK_SESSION_ID
		AND cl.TEST_SUM_ID = dts.DAILY_TEST_SUM_ID
	LEFT OUTER JOIN camdecmpsmd.SEVERITY_CODE AS sev
		ON sev.SEVERITY_CD = cl.SEVERITY_CD
	GROUP BY	dts.DAILY_TEST_SUM_ID, 
				mpl.MON_PLAN_ID, 
				mpl.MON_LOC_ID, 
				dts.RPT_PERIOD_ID, 
				dts.COMPONENT_ID,
				cmp.COMPONENT_IDENTIFIER, 
				cmp.COMPONENT_TYPE_CD,
				Coalesce(ms.SYSTEM_IDENTIFIER, cmp.COMPONENT_IDENTIFIER),
				Coalesce(ms.SYS_TYPE_CD, cmp.COMPONENT_TYPE_CD),
				dts.SPAN_SCALE_CD, 
				dts.DAILY_TEST_DATE, 
				camdecmpswks.format_time( dts.DAILY_TEST_HOUR, dts.DAILY_TEST_MIN ),
				dts.TEST_TYPE_CD, 
				dts.TEST_RESULT_CD, 
				dts.CALC_TEST_RESULT_CD;
END
$BODY$;
