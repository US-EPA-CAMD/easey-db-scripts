-- PROCEDURE: camdecmpswks.load_qa_workspace()

-- DROP PROCEDURE camdecmpswks.load_qa_workspace();

CREATE OR REPLACE PROCEDURE camdecmpswks.load_qa_workspace(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	INSERT INTO camdecmpswks.qa_supp_data(
		qa_supp_data_id, mon_loc_id, mon_sys_id, component_id, test_type_cd, test_sum_id, test_reason_cd, test_num, span_scale, begin_date, begin_hour, begin_min, end_date, end_hour, end_min, rpt_period_id, test_result_cd, gp_ind, reinstallation_date, reinstallation_hour, test_expire_date, test_expire_hour, userid, add_date, update_date, op_level_cd, updated_status_flg, submission_id, submission_availability_cd, pending_status_cd, operating_condition_cd, fuel_cd
	)
	SELECT
		qa_supp_data_id, mon_loc_id, mon_sys_id, component_id, test_type_cd, test_sum_id, test_reason_cd, test_num, span_scale, begin_date, begin_hour, begin_min, end_date, end_hour, end_min, rpt_period_id, test_result_cd, gp_ind, reinstallation_date, reinstallation_hour, test_expire_date, test_expire_hour, userid, add_date, update_date, op_level_cd, 'N', submission_id, submission_availability_cd, 'UPDATED', operating_condition_cd, fuel_cd
	FROM camdecmps.qa_supp_data;

	INSERT INTO camdecmpswks.qa_supp_attribute(
		qa_supp_attribute_id, qa_supp_data_id, attribute_name, attribute_value, userid, add_date, update_date
	)
	SELECT
		qa_supp_attribute_id, qa_supp_data_id, attribute_name, attribute_value, userid, add_date, update_date
	FROM camdecmps.qa_supp_attribute;

	INSERT INTO camdecmpswks.qa_cert_event(
		mon_loc_id, mon_sys_id, component_id, qa_cert_event_cd, qa_cert_event_date, qa_cert_event_hour, required_test_cd, conditional_data_begin_date, conditional_data_begin_hour, last_test_completed_date, last_test_completed_hour, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, userid, add_date, update_date, qa_cert_event_id, submission_id, submission_availability_cd, pending_status_cd, eval_status_cd
	)
	SELECT
		mon_loc_id, mon_sys_id, component_id, qa_cert_event_cd, qa_cert_event_date, qa_cert_event_hour, required_test_cd, conditional_data_begin_date, conditional_data_begin_hour, last_test_completed_date, last_test_completed_hour, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, userid, add_date, update_date, qa_cert_event_id, submission_id, submission_availability_cd, 'UPDATED', 'EVAL'
	FROM camdecmps.qa_cert_event;
	
	INSERT INTO camdecmpswks.qa_cert_event_supp_data(
		qa_cert_event_supp_data_id, qa_cert_event_id, qa_cert_event_supp_data_cd, qa_cert_event_supp_date_cd, count_from_datehour, count, count_from_included_ind, mon_loc_id, rpt_period_id, delete_ind, userid, add_date, update_date
	)
	SELECT
		qa_cert_event_supp_data_id, qa_cert_event_id, qa_cert_event_supp_data_cd, qa_cert_event_supp_date_cd, count_from_datehour, count, count_from_included_ind, mon_loc_id, rpt_period_id, delete_ind, userid, add_date, update_date
	FROM camdecmps.qa_cert_event_supp_data;

	INSERT INTO camdecmpswks.test_extension_exemption(
		test_extension_exemption_id, mon_loc_id, rpt_period_id, mon_sys_id, component_id, fuel_cd, extens_exempt_cd, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, hours_used, userid, add_date, update_date, span_scale_cd, submission_id, submission_availability_cd, pending_status_cd, eval_status_cd
	)
	SELECT
		test_extension_exemption_id, mon_loc_id, rpt_period_id, mon_sys_id, component_id, fuel_cd, extens_exempt_cd, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, hours_used, userid, add_date, update_date, span_scale_cd, submission_id, submission_availability_cd, 'UPDATED', 'EVAL'
	FROM camdecmps.test_extension_exemption;
END;
$BODY$;
