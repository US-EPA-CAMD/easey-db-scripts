-- PROCEDURE: camdecmpswks.copy_monitor_plan_qa_data_to_workspace(text)

DROP PROCEDURE IF EXISTS camdecmpswks.copy_monitor_plan_qa_data_to_workspace(text);

CREATE OR REPLACE PROCEDURE camdecmpswks.copy_monitor_plan_qa_data_to_workspace(
	monplanid text)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
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

	INSERT INTO camdecmpswks.qa_cert_event(
		mon_loc_id, mon_sys_id, component_id, qa_cert_event_cd, qa_cert_event_date, qa_cert_event_hour, required_test_cd, conditional_data_begin_date, conditional_data_begin_hour, last_test_completed_date, last_test_completed_hour, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, userid, add_date, update_date, qa_cert_event_id, submission_id, submission_availability_cd, pending_status_cd, eval_status_cd
	)
	SELECT
		mon_loc_id, mon_sys_id, component_id, qa_cert_event_cd, qa_cert_event_date, qa_cert_event_hour, required_test_cd, conditional_data_begin_date, conditional_data_begin_hour, last_test_completed_date, last_test_completed_hour, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, userid, add_date, update_date, qa_cert_event_id, submission_id, submission_availability_cd, 'UPDATED', 'EVAL'
	FROM camdecmps.qa_cert_event
	WHERE mon_loc_id = ANY(monLocIds);
	
	INSERT INTO camdecmpswks.qa_cert_event_supp_data(
		qa_cert_event_supp_data_id, qa_cert_event_id, qa_cert_event_supp_data_cd, qa_cert_event_supp_date_cd, count_from_datehour, count, count_from_included_ind, mon_loc_id, rpt_period_id, delete_ind, userid, add_date, update_date
	)
	SELECT
		a.qa_cert_event_supp_data_id, a.qa_cert_event_id, a.qa_cert_event_supp_data_cd, a.qa_cert_event_supp_date_cd, a.count_from_datehour, a.count, a.count_from_included_ind, a.mon_loc_id, a.rpt_period_id, a.delete_ind, a.userid, a.add_date, a.update_date
	FROM camdecmps.qa_cert_event_supp_data AS a
	JOIN camdecmps.qa_cert_event USING(qa_cert_event_id)
	WHERE a.mon_loc_id = ANY(monLocIds);

	INSERT INTO camdecmpswks.test_extension_exemption(
		test_extension_exemption_id, mon_loc_id, rpt_period_id, mon_sys_id, component_id, fuel_cd, extens_exempt_cd, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, hours_used, userid, add_date, update_date, span_scale_cd, submission_id, submission_availability_cd, pending_status_cd, eval_status_cd
	)
	SELECT
		test_extension_exemption_id, mon_loc_id, rpt_period_id, mon_sys_id, component_id, fuel_cd, extens_exempt_cd, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, hours_used, userid, add_date, update_date, span_scale_cd, submission_id, submission_availability_cd, 'UPDATED', 'EVAL'
	FROM camdecmps.test_extension_exemption
	WHERE mon_loc_id = ANY(monLocIds);
END;
$BODY$;
