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
END;
$BODY$;
