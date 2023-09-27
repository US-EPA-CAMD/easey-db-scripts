-- PROCEDURE: camdecmps.copy_qa_tee_data_from_workspace_to_global(character varying)

DROP PROCEDURE IF EXISTS camdecmps.copy_qa_tee_data_from_workspace_to_global(character varying);

CREATE OR REPLACE PROCEDURE camdecmps.copy_qa_tee_data_from_workspace_to_global(
	teeid character varying)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	INSERT INTO camdecmps.test_extension_exemption (
			test_extension_exemption_id, mon_loc_id, rpt_period_id, mon_sys_id, component_id, fuel_cd, extens_exempt_cd, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, hours_used, userid, add_date, update_date, span_scale_cd, submission_id, submission_availability_cd
	)
	SELECT
			test_extension_exemption_id, mon_loc_id, rpt_period_id, mon_sys_id, component_id, fuel_cd, extens_exempt_cd, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, hours_used, userid, add_date, update_date, span_scale_cd, submission_id, 'UPDATED'
	FROM camdecmpswks.test_extension_exemption
	WHERE test_extension_exemption_id = teeId
	ON CONFLICT (test_extension_exemption_id) DO UPDATE SET
			mon_loc_id = EXCLUDED.mon_loc_id,
			rpt_period_id = EXCLUDED.rpt_period_id,
			mon_sys_id = EXCLUDED.mon_sys_id,
			component_id = EXCLUDED.component_id,
			fuel_cd = EXCLUDED.fuel_cd,
			extens_exempt_cd = EXCLUDED.extens_exempt_cd,
			last_updated = EXCLUDED.last_updated,
			updated_status_flg = EXCLUDED.updated_status_flg,
			needs_eval_flg = EXCLUDED.needs_eval_flg,
			chk_session_id = EXCLUDED.chk_session_id,
			hours_used = EXCLUDED.hours_used,
			userid = EXCLUDED.userid,
			add_date = EXCLUDED.add_date,
			update_date = EXCLUDED.update_date,
			span_scale_cd = EXCLUDED.span_scale_cd,
			submission_id = EXCLUDED.submission_id,
			submission_availability_cd = EXCLUDED.submission_availability_cd;

	
	-- Check Session
	INSERT INTO camdecmpsaux.check_session (
    chk_session_id, mon_plan_id, test_sum_id, qa_cert_event_id, test_extension_exemption_id, rpt_period_id, session_begin_date, session_end_date, session_comment, severity_cd, category_cd, process_cd, userid
	)
	SELECT
			cs.chk_session_id, cs.mon_plan_id, cs.test_sum_id, cs.qa_cert_event_id, cs.test_extension_exemption_id, cs.rpt_period_id, cs.session_begin_date, cs.session_end_date, cs.session_comment, cs.severity_cd, cs.category_cd, cs.process_cd, cs.userid
	FROM camdecmpswks.test_extension_exemption tee
	JOIN camdecmpswks.check_session cs ON tee.chk_session_id = cs.chk_session_id
	WHERE tee.test_extension_exemption_id = teeid
	ON CONFLICT (chk_session_id) DO UPDATE SET
			mon_plan_id = EXCLUDED.mon_plan_id,
			test_sum_id = EXCLUDED.test_sum_id,
			qa_cert_event_id = EXCLUDED.qa_cert_event_id,
			test_extension_exemption_id = EXCLUDED.test_extension_exemption_id,
			rpt_period_id = EXCLUDED.rpt_period_id,
			session_begin_date = EXCLUDED.session_begin_date,
			session_end_date = EXCLUDED.session_end_date,
			session_comment = EXCLUDED.session_comment,
			severity_cd = EXCLUDED.severity_cd,
			category_cd = EXCLUDED.category_cd,
			process_cd = EXCLUDED.process_cd,
			userid = EXCLUDED.userid;

	
	INSERT INTO camdecmpsaux.check_log (
    chk_log_id, chk_session_id, begin_date, rule_check_id, result_message, chk_log_comment, check_catalog_result_id, mon_loc_id, source_table, row_id, test_sum_id, op_begin_date, op_begin_hour, op_end_date, op_end_hour, check_date, check_hour, check_result, severity_cd, suppressed_severity_cd, check_cd, error_suppress_id
	)
	SELECT
			cl.chk_log_id, cl.chk_session_id, cl.begin_date, cl.rule_check_id, cl.result_message, cl.chk_log_comment, cl.check_catalog_result_id, cl.mon_loc_id, cl.source_table, cl.row_id, cl.test_sum_id, cl.op_begin_date, cl.op_begin_hour, cl.op_end_date, cl.op_end_hour, cl.check_date, cl.check_hour, cl.check_result, cl.severity_cd, cl.suppressed_severity_cd, cl.check_cd, cl.error_suppress_id
	FROM camdecmpswks.test_extension_exemption tee
	JOIN camdecmpswks.check_session cs ON tee.chk_session_id = cs.chk_session_id
	JOIN camdecmpswks.check_log cl ON cs.chk_session_id = cl.chk_session_id
	WHERE tee.test_extension_exemption_id = teeid
	ON CONFLICT (chk_log_id) DO UPDATE SET
			chk_session_id = EXCLUDED.chk_session_id,
			begin_date = EXCLUDED.begin_date,
			rule_check_id = EXCLUDED.rule_check_id,
			result_message = EXCLUDED.result_message,
			chk_log_comment = EXCLUDED.chk_log_comment,
			check_catalog_result_id = EXCLUDED.check_catalog_result_id,
			mon_loc_id = EXCLUDED.mon_loc_id,
			source_table = EXCLUDED.source_table,
			row_id = EXCLUDED.row_id,
			test_sum_id = EXCLUDED.test_sum_id,
			op_begin_date = EXCLUDED.op_begin_date,
			op_begin_hour = EXCLUDED.op_begin_hour,
			op_end_date = EXCLUDED.op_end_date,
			op_end_hour = EXCLUDED.op_end_hour,
			check_date = EXCLUDED.check_date,
			check_hour = EXCLUDED.check_hour,
			check_result = EXCLUDED.check_result,
			severity_cd = EXCLUDED.severity_cd,
			suppressed_severity_cd = EXCLUDED.suppressed_severity_cd,
			check_cd = EXCLUDED.check_cd,
			error_suppress_id = EXCLUDED.error_suppress_id;
END;
$BODY$;
