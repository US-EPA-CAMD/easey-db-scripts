-- PROCEDURE: camdecmpswks.copy_monitor_plan_emissions_data_to_workspace(text)

DROP PROCEDURE IF EXISTS camdecmpswks.copy_monitor_plan_emissions_data_to_workspace(text);

CREATE OR REPLACE PROCEDURE camdecmpswks.copy_monitor_plan_emissions_data_to_workspace(
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

	INSERT INTO camdecmpswks.component_op_supp_data(
		comp_op_supp_data_id, component_id, rpt_period_id, op_supp_data_type_cd, days, hours, mon_loc_id, delete_ind, userid, add_date, update_date
	)
	SELECT
		comp_op_supp_data_id, component_id, rpt_period_id, op_supp_data_type_cd, days, hours, mon_loc_id, delete_ind, userid, add_date, update_date
	FROM camdecmps.component_op_supp_data
	WHERE mon_loc_id = ANY(monLocIds);

	INSERT INTO camdecmpswks.daily_test_supp_data(
		daily_test_supp_data_id, component_id, rpt_period_id, test_type_cd, span_scale_cd, key_online_ind, key_valid_ind, op_hour_cnt, last_covered_nonop_datehour, first_op_after_nonop_datehour, daily_test_datehourmin, test_result_cd, online_offline_ind, sort_daily_test_datehourmin, daily_test_sum_id, calc_test_result_cd, mon_loc_id, delete_ind, userid, add_date, update_date
	)
	SELECT
		daily_test_supp_data_id, component_id, rpt_period_id, test_type_cd, span_scale_cd, key_online_ind, key_valid_ind, op_hour_cnt, last_covered_nonop_datehour, first_op_after_nonop_datehour, daily_test_datehourmin, test_result_cd, online_offline_ind, sort_daily_test_datehourmin, daily_test_sum_id, calc_test_result_cd, mon_loc_id, delete_ind, userid, add_date, update_date
	FROM camdecmps.daily_test_supp_data
	WHERE mon_loc_id = ANY(monLocIds);

	INSERT INTO camdecmpswks.daily_test_system_supp_data(
		daily_test_system_supp_data_id, daily_test_supp_data_id, mon_sys_id, op_hour_cnt, last_covered_nonop_datehour, first_op_after_nonop_datehour, mon_loc_id, rpt_period_id, userid, add_date, update_date
	)
	SELECT
		daily_test_system_supp_data_id, daily_test_supp_data_id, mon_sys_id, op_hour_cnt, last_covered_nonop_datehour, first_op_after_nonop_datehour, mon_loc_id, rpt_period_id, userid, add_date, update_date
	FROM camdecmps.daily_test_system_supp_data
	WHERE mon_loc_id = ANY(monLocIds);

	INSERT INTO camdecmpswks.last_qa_value_supp_data(
		last_qa_value_supp_data_id, mon_loc_id, rpt_period_id, parameter_cd, moisture_basis, hourly_type_cd, mon_sys_id, component_id, op_datehour, unadjusted_hrly_value, adjusted_hrly_value, delete_ind, userid, add_date, update_date
	)
	SELECT
		last_qa_value_supp_data_id, mon_loc_id, rpt_period_id, parameter_cd, moisture_basis, hourly_type_cd, mon_sys_id, component_id, op_datehour, unadjusted_hrly_value, adjusted_hrly_value, delete_ind, userid, add_date, update_date
	FROM camdecmps.last_qa_value_supp_data
	WHERE mon_loc_id = ANY(monLocIds);

	INSERT INTO camdecmpswks.operating_supp_data(
		op_supp_data_id, mon_loc_id, fuel_cd, op_type_cd, rpt_period_id, op_value, userid, add_date, update_date
	)
	SELECT
		op_supp_data_id, mon_loc_id, fuel_cd, op_type_cd, rpt_period_id, op_value, userid, add_date, update_date
	FROM camdecmps.operating_supp_data
	WHERE mon_loc_id = ANY(monLocIds);

	INSERT INTO camdecmpswks.sampling_train_supp_data(
		trap_train_id, trap_id, component_id, train_qa_status_cd, ref_flow_to_sampling_ratio, hg_concentration, sfsr_total_count, sfsr_deviated_count, gfm_total_count, gfm_not_available_count, mon_loc_id, rpt_period_id, userid, add_date, update_date, sampling_ratio_test_result_cd
	)
	SELECT
		trap_train_id, trap_id, component_id, train_qa_status_cd, ref_flow_to_sampling_ratio, hg_concentration, sfsr_total_count, sfsr_deviated_count, gfm_total_count, gfm_not_available_count, mon_loc_id, rpt_period_id, userid, add_date, update_date, sampling_ratio_test_result_cd
	FROM camdecmps.sampling_train_supp_data
	WHERE mon_loc_id = ANY(monLocIds);

	INSERT INTO camdecmpswks.sorbent_trap_supp_data(
		trap_id, mon_sys_id, begin_date, begin_hour, end_date, end_hour, modc_cd, hg_concentration, mon_loc_id, rpt_period_id, userid, add_date, update_date, delete_ind, sorbent_trap_aps_cd, rata_ind
	)
	SELECT
		trap_id, mon_sys_id, begin_date, begin_hour, end_date, end_hour, modc_cd, hg_concentration, mon_loc_id, rpt_period_id, userid, add_date, update_date, delete_ind, sorbent_trap_aps_cd, rata_ind
	FROM camdecmps.sorbent_trap_supp_data
	WHERE mon_loc_id = ANY(monLocIds);

	INSERT INTO camdecmpswks.system_op_supp_data(
		sys_op_supp_data_id, mon_sys_id, rpt_period_id, op_supp_data_type_cd, days, hours, mon_loc_id, delete_ind, userid, add_date, update_date
	)
	SELECT
		sys_op_supp_data_id, mon_sys_id, rpt_period_id, op_supp_data_type_cd, days, hours, mon_loc_id, delete_ind, userid, add_date, update_date
	FROM camdecmps.system_op_supp_data
	WHERE mon_loc_id = ANY(monLocIds);
END;
$BODY$;
