-- PROCEDURE: camdecmps.load_temp_daily_test_errors()

DROP PROCEDURE IF EXISTS camdecmps.load_temp_daily_test_errors();

CREATE OR REPLACE PROCEDURE camdecmps.load_temp_daily_test_errors()
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
  RAISE NOTICE 'Loading temp_daily_test_errors...';

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
	SELECT DISTINCT dts.daily_test_sum_id,
		mpl.mon_plan_id,
		mpl.mon_loc_id,
		dts.rpt_period_id,
		dts.component_id,
		cmp.component_identifier,
		cmp.component_type_cd,
		COALESCE(ms.system_identifier, cmp.component_identifier) AS system_component_identifier,
		COALESCE(ms.sys_type_cd, cmp.component_type_cd) AS system_component_type,
		dts.span_scale_cd,
		dts.daily_test_date AS end_date,
		camdecmps.format_time(dts.daily_test_hour, dts.daily_test_min) AS end_time,
		dts.test_type_cd,
		dts.test_result_cd,
		dts.calc_test_result_cd,
		CASE
			WHEN max(COALESCE(sev.severity_level, 0::numeric)) > 0::numeric THEN 'View Errors'::text
			ELSE NULL::text
		END AS error_codes
	FROM camdecmps.monitor_plan_location mpl
	JOIN camdecmps.daily_test_summary dts ON dts.mon_loc_id::text = mpl.mon_loc_id::text
	JOIN camdecmps.emission_evaluation evl ON evl.mon_plan_id::text = mpl.mon_plan_id::text AND evl.rpt_period_id = dts.rpt_period_id
	LEFT JOIN camdecmps.monitor_system ms ON ms.mon_sys_id::text = dts.mon_sys_id::text
	LEFT JOIN camdecmps.component cmp ON cmp.component_id::text = dts.component_id::text
	LEFT JOIN camdecmpsaux.check_log cl ON cl.chk_session_id::text = evl.chk_session_id::text AND cl.test_sum_id::text = dts.daily_test_sum_id::text
	LEFT JOIN camdecmpsmd.severity_code sev ON sev.severity_cd::text = cl.severity_cd::text
	GROUP BY dts.daily_test_sum_id, mpl.mon_plan_id, mpl.mon_loc_id, dts.rpt_period_id, dts.component_id, cmp.component_identifier, cmp.component_type_cd, (COALESCE(ms.system_identifier, cmp.component_identifier)), (COALESCE(ms.sys_type_cd, cmp.component_type_cd)), dts.span_scale_cd, dts.daily_test_date, (camdecmps.format_time(dts.daily_test_hour, dts.daily_test_min)), dts.test_type_cd, dts.test_result_cd, dts.calc_test_result_cd;
END
$BODY$;
