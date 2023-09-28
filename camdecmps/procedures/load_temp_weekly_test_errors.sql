-- PROCEDURE: camdecmps.load_temp_weekly_test_errors()

DROP PROCEDURE IF EXISTS camdecmps.load_temp_weekly_test_errors();

CREATE OR REPLACE PROCEDURE camdecmps.load_temp_weekly_test_errors()
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
  RAISE NOTICE 'Loading temp_weekly_test_errors...';

	INSERT INTO temp_weekly_test_errors(
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
		(SELECT DISTINCT wts.weekly_test_sum_id,
		mpl.mon_plan_id,
		mpl.mon_loc_id,
		wts.rpt_period_id,
		wts.mon_sys_id,
		wts.component_id,
		cmp.component_identifier,
		cmp.component_type_cd,
		COALESCE(ms.system_identifier, cmp.component_identifier) AS system_component_identifier,
		COALESCE(ms.sys_type_cd, cmp.component_type_cd) AS system_component_type,
		wts.span_scale_cd,
		wts.test_date,
		camdecmps.format_time(wts.test_hour, wts.test_min) AS test_time,
		wts.test_type_cd,
		wts.test_result_cd,
		wts.calc_test_result_cd,
		CASE
			WHEN max(COALESCE(sev.severity_level, 0::numeric)) > 0::numeric THEN 'View Errors'::text
			ELSE NULL::text
		END AS error_codes
	FROM camdecmps.monitor_plan_location mpl
	JOIN camdecmps.weekly_test_summary wts ON wts.mon_loc_id::text = mpl.mon_loc_id::text
	JOIN camdecmps.emission_evaluation evl ON evl.mon_plan_id::text = mpl.mon_plan_id::text AND evl.rpt_period_id = wts.rpt_period_id
	LEFT JOIN camdecmps.monitor_system ms ON ms.mon_sys_id::text = wts.mon_sys_id::text
	LEFT JOIN camdecmps.component cmp ON cmp.component_id::text = wts.component_id::text
	LEFT JOIN camdecmpsaux.check_log log ON log.chk_session_id::text = evl.chk_session_id::text AND log.test_sum_id::text = wts.weekly_test_sum_id::text
	LEFT JOIN camdecmpsmd.severity_code sev ON sev.severity_cd::text = log.severity_cd::text
	GROUP BY wts.weekly_test_sum_id, mpl.mon_plan_id, mpl.mon_loc_id, wts.rpt_period_id, wts.mon_sys_id, wts.component_id, cmp.component_identifier, cmp.component_type_cd, (COALESCE(ms.system_identifier, cmp.component_identifier)), (COALESCE(ms.sys_type_cd, cmp.component_type_cd)), wts.span_scale_cd, wts.test_date, (camdecmps.format_time(wts.test_hour, wts.test_min)), wts.test_type_cd, wts.test_result_cd, wts.calc_test_result_cd);
END
$BODY$;
