-- PROCEDURE: camdecmpswks.copy_monitor_plan_qa_data_to_workspace(text)

DROP PROCEDURE IF EXISTS camdecmpswks.copy_monitor_plan_qa_data_to_workspace(text);

CREATE OR REPLACE PROCEDURE camdecmpswks.copy_monitor_plan_qa_data_to_workspace(
	monplanid text)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	qceId			text;
	teeId			text;
	qceIds			text[];
	teeIds			text[];
	monLocIds 		text[];
BEGIN

	SELECT ARRAY(
		SELECT mon_loc_id
		FROM camdecmps.monitor_plan_location
		WHERE mon_plan_id = monPlanId
	) INTO monLocIds;

	INSERT INTO camdecmpswks.qa_supp_data(
		qa_supp_data_id, mon_loc_id, mon_sys_id, component_id, test_type_cd, test_sum_id, test_reason_cd, test_num, span_scale, begin_date, begin_hour, begin_min, end_date, end_hour, end_min, rpt_period_id, test_result_cd, gp_ind, reinstallation_date, reinstallation_hour, test_expire_date, test_expire_hour, userid, add_date, update_date, op_level_cd, updated_status_flg, submission_id, submission_availability_cd, pending_status_cd, operating_condition_cd, fuel_cd
	)
	SELECT
		qa_supp_data_id, mon_loc_id, mon_sys_id, component_id, test_type_cd, test_sum_id, test_reason_cd, test_num, span_scale, begin_date, begin_hour, begin_min, end_date, end_hour, end_min, rpt_period_id, test_result_cd, gp_ind, reinstallation_date, reinstallation_hour, test_expire_date, test_expire_hour, userid, add_date, update_date, op_level_cd, 'N', submission_id, submission_availability_cd, 'UPDATED', operating_condition_cd, fuel_cd
	FROM camdecmps.qa_supp_data
	WHERE mon_loc_id = ANY(monLocIds);

	INSERT INTO camdecmpswks.qa_supp_attribute(
		qa_supp_attribute_id, qa_supp_data_id, attribute_name, attribute_value, userid, add_date, update_date
	)
	SELECT
		a.qa_supp_attribute_id, a.qa_supp_data_id, a.attribute_name, a.attribute_value, a.userid, a.add_date, a.update_date
	FROM camdecmps.qa_supp_attribute AS a
	JOIN camdecmps.qa_supp_data USING(qa_supp_data_id)
	WHERE mon_loc_id = ANY(monLocIds);

	-- QCE
	SELECT ARRAY(
		SELECT qa_cert_event_id
		FROM camdecmps.qa_cert_event
		WHERE mon_loc_id = ANY(monLocIds)
	) INTO qceIds;

	FOREACH qceId IN ARRAY qceIds
    LOOP
		INSERT INTO camdecmpswks.qa_cert_event
		SELECT
			mon_loc_id, mon_sys_id, component_id, qa_cert_event_cd, qa_cert_event_date, qa_cert_event_hour, required_test_cd, conditional_data_begin_date, conditional_data_begin_hour, last_test_completed_date, last_test_completed_hour, last_updated, updated_status_flg, needs_eval_flg, qce.chk_session_id, qce.userid, qce.add_date, qce.update_date, qce.qa_cert_event_id, qce.submission_id, qce.submission_availability_cd, 'UPDATED', coalesce(sc.eval_status_cd, 'EVAL')
		FROM camdecmps.qa_cert_event qce
		left join camdecmpsaux.check_session cs on cs.chk_session_id = qce.chk_session_id 
		left join camdecmpsmd.severity_code sc on sc.severity_cd = cs.severity_cd
		WHERE qce.qa_cert_event_id = qceId;

		-- Check Session
		INSERT INTO camdecmpswks.check_session (
			chk_session_id, mon_plan_id, test_sum_id, qa_cert_event_id, 
			test_extension_exemption_id, rpt_period_id, session_begin_date, 
			session_end_date, session_comment, severity_cd, category_cd, 
			process_cd, userid
		)
		SELECT
			cs.chk_session_id, cs.mon_plan_id, cs.test_sum_id, cs.qa_cert_event_id, 
			cs.test_extension_exemption_id, cs.rpt_period_id, cs.session_begin_date, 
			cs.session_end_date, cs.session_comment, cs.severity_cd, cs.category_cd, 
			cs.process_cd, cs.userid
		FROM camdecmps.qa_cert_event qce
		JOIN camdecmpsaux.check_session cs on qce.chk_session_id = cs.chk_session_id
		WHERE qce.qa_cert_event_id = qceId
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

		-- Check Log
		INSERT INTO camdecmpswks.check_log (
			chk_log_id, chk_session_id, begin_date, rule_check_id, result_message, 
			chk_log_comment, check_catalog_result_id, mon_loc_id, source_table, 
			row_id, test_sum_id, op_begin_date, op_begin_hour, op_end_date, op_end_hour, 
			check_date, check_hour, check_result, severity_cd, suppressed_severity_cd, 
			check_cd, error_suppress_id
		)
		SELECT
			cl.chk_log_id, cl.chk_session_id, cl.begin_date, cl.rule_check_id, cl.result_message, cl.chk_log_comment, cl.check_catalog_result_id, cl.mon_loc_id, cl.source_table, cl.row_id, cl.test_sum_id, cl.op_begin_date, cl.op_begin_hour, cl.op_end_date, cl.op_end_hour, cl.check_date, cl.check_hour, cl.check_result, cl.severity_cd, cl.suppressed_severity_cd, cl.check_cd, cl.error_suppress_id
		FROM camdecmps.qa_cert_event qce
		JOIN camdecmpsaux.check_session cs on qce.chk_session_id = cs.chk_session_id
		JOIN camdecmpsaux.check_log cl on cs.chk_session_id = cl.chk_session_id
		WHERE qce.qa_cert_event_id = qceId
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


    END LOOP;

	INSERT INTO camdecmpswks.qa_cert_event_supp_data(
		qa_cert_event_supp_data_id, qa_cert_event_id, qa_cert_event_supp_data_cd, qa_cert_event_supp_date_cd, count_from_datehour, count, count_from_included_ind, mon_loc_id, rpt_period_id, delete_ind, userid, add_date, update_date
	)
	SELECT
		a.qa_cert_event_supp_data_id, a.qa_cert_event_id, a.qa_cert_event_supp_data_cd, a.qa_cert_event_supp_date_cd, a.count_from_datehour, a.count, a.count_from_included_ind, a.mon_loc_id, a.rpt_period_id, a.delete_ind, a.userid, a.add_date, a.update_date
	FROM camdecmps.qa_cert_event_supp_data AS a
	JOIN camdecmps.qa_cert_event USING(qa_cert_event_id)
	WHERE a.mon_loc_id = ANY(monLocIds);

	-- TEST EXTENSION EXEMPTION

	-- Load the check_session + check_logs
	SELECT ARRAY(
		SELECT test_extension_exemption_id
		FROM camdecmps.test_extension_exemption
		WHERE mon_loc_id = ANY(monLocIds)
	) INTO teeIds;
	
	FOREACH teeId IN ARRAY teeIds
    LOOP

		INSERT INTO camdecmpswks.test_extension_exemption(
		test_extension_exemption_id, mon_loc_id, rpt_period_id, mon_sys_id, component_id, fuel_cd, extens_exempt_cd, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, hours_used, userid, add_date, update_date, span_scale_cd, submission_id, submission_availability_cd, pending_status_cd, eval_status_cd
		)
		SELECT
			tee.test_extension_exemption_id, tee.mon_loc_id, tee.rpt_period_id, tee.mon_sys_id, tee.component_id, tee.fuel_cd, tee.extens_exempt_cd, tee.last_updated, tee.updated_status_flg, tee.needs_eval_flg, tee.chk_session_id, tee.hours_used, tee.userid, tee.add_date, tee.update_date, tee.span_scale_cd, tee.submission_id, tee.submission_availability_cd, 'UPDATED', coalesce(sc.eval_status_cd, 'EVAL')
		FROM camdecmps.test_extension_exemption tee
		left join camdecmpsaux.check_session cs on cs.chk_session_id = tee.chk_session_id
		left join camdecmpsmd.severity_code sc on sc.severity_cd = cs.severity_cd
		WHERE tee.test_extension_exemption_id = teeId;

		-- Check Session
		INSERT INTO camdecmpswks.check_session (
			chk_session_id, mon_plan_id, test_sum_id, qa_cert_event_id, 
			test_extension_exemption_id, rpt_period_id, session_begin_date, 
			session_end_date, session_comment, severity_cd, category_cd, 
			process_cd, userid
		)
		SELECT
			cs.chk_session_id, cs.mon_plan_id, cs.test_sum_id, cs.qa_cert_event_id, 
			cs.test_extension_exemption_id, cs.rpt_period_id, cs.session_begin_date, 
			cs.session_end_date, cs.session_comment, cs.severity_cd, cs.category_cd, 
			cs.process_cd, cs.userid
		FROM camdecmps.test_extension_exemption tee
		JOIN camdecmpsaux.check_session cs on tee.chk_session_id = cs.chk_session_id
		WHERE tee.test_extension_exemption_id = teeId
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

		-- Check Log
		INSERT INTO camdecmpswks.check_log (
			chk_log_id, chk_session_id, begin_date, rule_check_id, result_message, 
			chk_log_comment, check_catalog_result_id, mon_loc_id, source_table, 
			row_id, test_sum_id, op_begin_date, op_begin_hour, op_end_date, op_end_hour, 
			check_date, check_hour, check_result, severity_cd, suppressed_severity_cd, 
			check_cd, error_suppress_id
		)
		SELECT
			cl.chk_log_id, cl.chk_session_id, cl.begin_date, cl.rule_check_id, cl.result_message, cl.chk_log_comment, cl.check_catalog_result_id, cl.mon_loc_id, cl.source_table, cl.row_id, cl.test_sum_id, cl.op_begin_date, cl.op_begin_hour, cl.op_end_date, cl.op_end_hour, cl.check_date, cl.check_hour, cl.check_result, cl.severity_cd, cl.suppressed_severity_cd, cl.check_cd, cl.error_suppress_id
		FROM camdecmps.test_extension_exemption tee
		JOIN camdecmpsaux.check_session cs on tee.chk_session_id = cs.chk_session_id
		JOIN camdecmpsaux.check_log cl on cs.chk_session_id = cl.chk_session_id
		WHERE tee.test_extension_exemption_id = teeId
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

    END LOOP;
END;
$BODY$;
