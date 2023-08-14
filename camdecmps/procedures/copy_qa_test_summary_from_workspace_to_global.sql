-- PROCEDURE: camdecmps.copy_qa_test_summary_from_workspace_to_global(character varying)

-- DROP PROCEDURE IF EXISTS camdecmps.copy_qa_test_summary_from_workspace_to_global(character varying);

CREATE OR REPLACE PROCEDURE camdecmps.copy_qa_test_summary_from_workspace_to_global(
	testsumid character varying)
LANGUAGE 'plpgsql'
AS $BODY$
	
BEGIN
	---------------------------------- DELETE OLD DATA ---------------------------------------------------
    DELETE FROM camdecmps.qa_supp_data
	WHERE test_sum_id = testSumId;

    
    DELETE FROM camdecmps.test_summary
	WHERE test_sum_id = testSumId;

    ---------------------------------- Supplemental Data -------------------------------------------------
    INSERT INTO camdecmps.qa_supp_data(
		qa_supp_data_id, mon_loc_id, mon_sys_id, component_id, test_type_cd, test_sum_id, test_reason_cd, test_num, span_scale, begin_date, begin_hour, begin_min, end_date, end_hour, end_min, rpt_period_id, test_result_cd, gp_ind, reinstallation_date, reinstallation_hour, test_expire_date, test_expire_hour, userid, add_date, update_date, op_level_cd, submission_id, submission_availability_cd, operating_condition_cd, fuel_cd
	)
	SELECT
		qa_supp_data_id, mon_loc_id, mon_sys_id, component_id, test_type_cd, test_sum_id, test_reason_cd, test_num, span_scale, begin_date, begin_hour, begin_min, end_date, end_hour, end_min, rpt_period_id, test_result_cd, gp_ind, reinstallation_date, reinstallation_hour, test_expire_date, test_expire_hour, userid, add_date, update_date, op_level_cd, submission_id, 'UPDATED', operating_condition_cd, fuel_cd
	FROM camdecmpswks.qa_supp_data
	WHERE test_sum_id = testSumId;

	INSERT INTO camdecmps.qa_supp_attribute(
		qa_supp_attribute_id, qa_supp_data_id, attribute_name, attribute_value, userid, add_date, update_date
	)
	SELECT
		a.qa_supp_attribute_id, a.qa_supp_data_id, a.attribute_name, a.attribute_value, a.userid, a.add_date, a.update_date
	FROM camdecmpswks.qa_supp_attribute AS a
	JOIN camdecmpswks.qa_supp_data USING(qa_supp_data_id)
	WHERE test_sum_id = testSumId;

	---------------------------------- Test Summary --------------------------------------------
	INSERT INTO camdecmps.test_summary(
	test_sum_id, mon_loc_id, mon_sys_id, component_id, test_num, gp_ind, calc_gp_ind, test_type_cd, test_reason_cd, test_result_cd, calc_test_result_cd, rpt_period_id, test_description, begin_date, begin_hour, begin_min, end_date, end_hour, end_min, calc_span_value, test_comment, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, userid, add_date, update_date, span_scale_cd, injection_protocol_cd)
	SELECT
		test_sum_id, mon_loc_id, mon_sys_id, component_id, test_num, gp_ind, calc_gp_ind, test_type_cd, test_reason_cd, test_result_cd, calc_test_result_cd, rpt_period_id, test_description, begin_date, begin_hour, begin_min, end_date, end_hour, end_min, calc_span_value, test_comment, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, userid, add_date, update_date, span_scale_cd, injection_protocol_cd
	FROM camdecmpswks.test_summary
	WHERE test_sum_id = testSumId;

	---------------------------------- Fuel Flowmeter Accuracy Data --------------------------------------------
	INSERT INTO camdecmps.fuel_flowmeter_accuracy(
	fuel_flow_acc_id, test_sum_id, acc_test_method_cd, reinstall_date, reinstall_hour, low_fuel_accuracy, mid_fuel_accuracy, high_fuel_accuracy, userid, add_date, update_date)
	SELECT
		fuel_flow_acc_id, test_sum_id, acc_test_method_cd, reinstall_date, reinstall_hour, low_fuel_accuracy, mid_fuel_accuracy, high_fuel_accuracy, userid, add_date, update_date
	FROM camdecmpswks.fuel_flowmeter_accuracy
	WHERE test_sum_id = testSumId;

	---------------------------------- Transmitter Transducer Accuracy Data --------------------------------------------
	INSERT INTO camdecmps.trans_accuracy(
	trans_ac_id, test_sum_id, low_level_accuracy, mid_level_accuracy, high_level_accuracy, userid, add_date, update_date, low_level_accuracy_spec_cd, mid_level_accuracy_spec_cd, high_level_accuracy_spec_cd)
	SELECT
		trans_ac_id, test_sum_id, low_level_accuracy, mid_level_accuracy, high_level_accuracy, userid, add_date, update_date, low_level_accuracy_spec_cd, mid_level_accuracy_spec_cd, high_level_accuracy_spec_cd
	FROM camdecmpswks.trans_accuracy
	WHERE test_sum_id = testSumId;

    ---------------------------------- Fuel Flow To Load Baseline Data --------------------------------------------
	INSERT INTO camdecmps.fuel_flow_to_load_baseline(
	fuel_flow_baseline_id, test_sum_id, accuracy_test_number, pei_test_number, avg_fuel_flow_rate, avg_load, baseline_fuel_flow_load_ratio, avg_hrly_hi_rate, baseline_ghr, nhe_cofiring, nhe_ramping, nhe_low_range, userid, add_date, update_date, fuel_flow_load_uom_cd, ghr_uom_cd)
	SELECT
		fuel_flow_baseline_id, test_sum_id, accuracy_test_number, pei_test_number, avg_fuel_flow_rate, avg_load, baseline_fuel_flow_load_ratio, avg_hrly_hi_rate, baseline_ghr, nhe_cofiring, nhe_ramping, nhe_low_range, userid, add_date, update_date, fuel_flow_load_uom_cd, ghr_uom_cd
	FROM camdecmpswks.fuel_flow_to_load_baseline
	WHERE test_sum_id = testSumId;

    ---------------------------------- Fuel Flow To Load Check --------------------------------------------
	INSERT INTO camdecmps.fuel_flow_to_load_check(
	fuel_flow_load_id, test_sum_id, test_basis_cd, avg_diff, num_hrs, nhe_cofiring, nhe_ramping, nhe_low_range, userid, add_date, update_date)
	SELECT
		fuel_flow_load_id, test_sum_id, test_basis_cd, avg_diff, num_hrs, nhe_cofiring, nhe_ramping, nhe_low_range, userid, add_date, update_date
	FROM camdecmpswks.fuel_flow_to_load_check
	WHERE test_sum_id = testSumId;

    ---------------------------------- AppendixE Correlation Test Summary Data --------------------------------------------
    INSERT INTO camdecmps.ae_correlation_test_sum(
	ae_corr_test_sum_id, test_sum_id, mean_ref_value, calc_mean_ref_value, f_factor, avg_hrly_hi_rate, calc_avg_hrly_hi_rate, op_level_num, userid, add_date, update_date)
	SELECT
		ae_corr_test_sum_id, test_sum_id, mean_ref_value, calc_mean_ref_value, f_factor, avg_hrly_hi_rate, calc_avg_hrly_hi_rate, op_level_num, userid, add_date, update_date
	FROM camdecmpswks.ae_correlation_test_sum
	WHERE test_sum_id = testSumId;

    INSERT INTO camdecmps.ae_correlation_test_run(
	ae_corr_test_run_id, ae_corr_test_sum_id, begin_date, begin_hour, begin_min, end_date, end_hour, end_min, run_num, ref_value, response_time, total_hi, calc_total_hi, hourly_hi_rate, calc_hourly_hi_rate, userid, add_date, update_date)
	SELECT
		tr.ae_corr_test_run_id, tr.ae_corr_test_sum_id, tr.begin_date, tr.begin_hour, tr.begin_min, tr.end_date, tr.end_hour, tr.end_min, tr.run_num, tr.ref_value, tr.response_time, tr.total_hi, tr.calc_total_hi, tr.hourly_hi_rate, tr.calc_hourly_hi_rate, tr.userid, tr.add_date, tr.update_date
	FROM camdecmpswks.ae_correlation_test_run tr
    JOIN camdecmpswks.ae_correlation_test_sum ts using(ae_corr_test_sum_id)
	WHERE ts.test_sum_id = testSumId;

    INSERT INTO camdecmps.ae_hi_gas(
	ae_hi_gas_id, ae_corr_test_run_id, gas_volume, gas_gcv, gas_hi, calc_gas_hi, userid, add_date, update_date, mon_sys_id)
	SELECT
		ah.ae_hi_gas_id, ah.ae_corr_test_run_id, ah.gas_volume, ah.gas_gcv, ah.gas_hi, ah.calc_gas_hi, ah.userid, ah.add_date, ah.update_date, ah.mon_sys_id
	FROM camdecmpswks.ae_hi_gas ah
    JOIN camdecmpswks.ae_correlation_test_run ac ON ah.ae_corr_test_run_id = ac.ae_corr_test_run_id
    JOIN camdecmpswks.ae_correlation_test_sum ts ON ac.ae_corr_test_sum_id = ts.ae_corr_test_sum_id
	WHERE ts.test_sum_id = testSumId;

    INSERT INTO camdecmps.ae_hi_oil(
	ae_hi_oil_id, ae_corr_test_run_id, oil_mass, oil_hi, calc_oil_hi, oil_gcv, oil_volume, oil_density, userid, add_date, update_date, oil_gcv_uom_cd, oil_volume_uom_cd, oil_density_uom_cd, mon_sys_id, calc_oil_mass)
	SELECT
		ah.ae_hi_oil_id, ah.ae_corr_test_run_id, ah.oil_mass, ah.oil_hi, ah.calc_oil_hi, ah.oil_gcv, ah.oil_volume, ah.oil_density, ah.userid, ah.add_date, ah.update_date, ah.oil_gcv_uom_cd, ah.oil_volume_uom_cd, ah.oil_density_uom_cd, ah.mon_sys_id, ah.calc_oil_mass
	FROM camdecmpswks.ae_hi_oil ah
    JOIN camdecmpswks.ae_correlation_test_run ac ON ah.ae_corr_test_run_id = ac.ae_corr_test_run_id
    JOIN camdecmpswks.ae_correlation_test_sum ts ON ac.ae_corr_test_sum_id = ts.ae_corr_test_sum_id
	WHERE ts.test_sum_id = testSumId;

    ---------------------------------- Unit Default Test Data --------------------------------------------
    INSERT INTO camdecmps.unit_default_test(
	unit_default_test_sum_id, test_sum_id, fuel_cd, operating_condition_cd, nox_default_rate, calc_nox_default_rate, group_id, num_units_in_group, num_tests_for_group, userid, add_date, update_date)
	SELECT
		unit_default_test_sum_id, test_sum_id, fuel_cd, operating_condition_cd, nox_default_rate, calc_nox_default_rate, group_id, num_units_in_group, num_tests_for_group, userid, add_date, update_date
	FROM camdecmpswks.unit_default_test
	WHERE test_sum_id = testSumId;

    INSERT INTO camdecmps.unit_default_test_run(
	unit_default_test_run_id, unit_default_test_sum_id, op_level_num, run_num, begin_date, begin_hour, begin_min, end_date, end_hour, end_min, response_time, ref_value, userid, add_date, update_date, run_used_ind)
	SELECT
		ur.unit_default_test_run_id, ur.unit_default_test_sum_id, ur.op_level_num, ur.run_num, ur.begin_date, ur.begin_hour, ur.begin_min, ur.end_date, ur.end_hour, ur.end_min, ur.response_time, ur.ref_value, ur.userid, ur.add_date, ur.update_date, ur.run_used_ind
	FROM camdecmpswks.unit_default_test_run ur
    JOIN camdecmpswks.unit_default_test ud using(unit_default_test_sum_id)
	WHERE ud.test_sum_id = testSumId;

    ---------------------------------- RATA ---------------------------------------------------------------
    INSERT INTO camdecmps.rata(
	rata_id, test_sum_id, rata_frequency_cd, calc_rata_frequency_cd, relative_accuracy, calc_relative_accuracy, overall_bias_adj_factor, calc_overall_bias_adj_factor, num_load_level, calc_num_load_level, userid, add_date, update_date)
	SELECT
		rata_id, test_sum_id, rata_frequency_cd, calc_rata_frequency_cd, relative_accuracy, calc_relative_accuracy, overall_bias_adj_factor, calc_overall_bias_adj_factor, num_load_level, calc_num_load_level, userid, add_date, update_date
	FROM camdecmpswks.rata
	WHERE test_sum_id = testSumId;

    INSERT INTO camdecmps.rata_summary(
	rata_sum_id, rata_id, relative_accuracy, calc_relative_accuracy, bias_adj_factor, calc_bias_adj_factor, mean_cem_value, calc_mean_cem_value, mean_rata_ref_value, calc_mean_rata_ref_value, op_level_cd, mean_diff, calc_mean_diff, default_waf, avg_gross_unit_load, calc_avg_gross_unit_load, aps_ind, calc_aps_ind, stnd_dev_diff, calc_stnd_dev_diff, confidence_coef, calc_confidence_coef, co2_o2_ref_method_cd, ref_method_cd, t_value, calc_t_value, stack_diameter, stack_area, calc_stack_area, calc_waf, calc_calc_waf, num_traverse_point, userid, add_date, update_date, aps_cd)
	SELECT
		rs.rata_sum_id, rs.rata_id, rs.relative_accuracy, rs.calc_relative_accuracy, rs.bias_adj_factor, rs.calc_bias_adj_factor, rs.mean_cem_value, rs.calc_mean_cem_value, rs.mean_rata_ref_value, rs.calc_mean_rata_ref_value, rs.op_level_cd, rs.mean_diff, rs.calc_mean_diff, rs.default_waf, rs.avg_gross_unit_load, rs.calc_avg_gross_unit_load, rs.aps_ind, rs.calc_aps_ind, rs.stnd_dev_diff, rs.calc_stnd_dev_diff, rs.confidence_coef, rs.calc_confidence_coef, rs.co2_o2_ref_method_cd, rs.ref_method_cd, rs.t_value, rs.calc_t_value, rs.stack_diameter, rs.stack_area, rs.calc_stack_area, rs.calc_waf, rs.calc_calc_waf, rs.num_traverse_point, rs.userid, rs.add_date, rs.update_date, rs.aps_cd
	FROM camdecmpswks.rata_summary rs
    JOIN camdecmpswks.rata r using(rata_id)
	WHERE r.test_sum_id = testSumId;

    INSERT INTO camdecmps.rata_run(
	rata_run_id, rata_sum_id, gross_unit_load, run_num, cem_value, rata_ref_value, calc_rata_ref_value, run_status_cd, begin_date, begin_hour, begin_min, end_date, end_hour, end_min, userid, add_date, update_date)
	SELECT
		rr.rata_run_id, rr.rata_sum_id, rr.gross_unit_load, rr.run_num, rr.cem_value, rr.rata_ref_value, rr.calc_rata_ref_value, rr.run_status_cd, rr.begin_date, rr.begin_hour, rr.begin_min, rr.end_date, rr.end_hour, rr.end_min, rr.userid, rr.add_date, rr.update_date
	FROM camdecmpswks.rata_run rr
    JOIN camdecmps.rata_summary rs ON rr.rata_sum_id = rs.rata_sum_id
    JOIN camdecmpswks.rata r ON r.rata_id = rs.rata_id
	WHERE r.test_sum_id = testSumId;

    INSERT INTO camdecmps.flow_rata_run(
	flow_rata_run_id, rata_run_id, num_traverse_point, barometric_pressure, static_stack_pressure, percent_co2, percent_o2, percent_moisture, dry_molecular_weight, calc_dry_molecular_weight, wet_molecular_weight, calc_wet_molecular_weight, avg_vel_wo_wall, calc_avg_vel_wo_wall, avg_vel_w_wall, calc_avg_vel_w_wall, calc_waf, calc_calc_waf, avg_stack_flow_rate, userid, update_date, add_date)
	SELECT
		fr.flow_rata_run_id, fr.rata_run_id, fr.num_traverse_point, fr.barometric_pressure, fr.static_stack_pressure, fr.percent_co2, fr.percent_o2, fr.percent_moisture, fr.dry_molecular_weight, fr.calc_dry_molecular_weight, fr.wet_molecular_weight, fr.calc_wet_molecular_weight, fr.avg_vel_wo_wall, fr.calc_avg_vel_wo_wall, fr.avg_vel_w_wall, fr.calc_avg_vel_w_wall, fr.calc_waf, fr.calc_calc_waf, fr.avg_stack_flow_rate, fr.userid, fr.update_date, fr.add_date
	FROM camdecmpswks.flow_rata_run fr
    JOIN camdecmpswks.rata_run rr on fr.rata_run_id = rr.rata_run_id
    JOIN camdecmps.rata_summary rs ON rr.rata_sum_id = rs.rata_sum_id
    JOIN camdecmpswks.rata r ON r.rata_id = rs.rata_id
	WHERE r.test_sum_id = testSumId;

    INSERT INTO camdecmps.rata_traverse(
	rata_traverse_id, flow_rata_run_id, probeid, probe_type_cd, method_traverse_point_id, vel_cal_coef, last_probe_date, avg_vel_diff_pressure, avg_sq_vel_diff_pressure, t_stack_temp, num_wall_effects_points, yaw_angle, pitch_angle, calc_vel, calc_calc_vel, rep_vel, pressure_meas_cd, userid, add_date, update_date, point_used_ind)
	SELECT
		rt.rata_traverse_id, rt.flow_rata_run_id, rt.probeid, rt.probe_type_cd, rt.method_traverse_point_id, rt.vel_cal_coef, rt.last_probe_date, rt.avg_vel_diff_pressure, rt.avg_sq_vel_diff_pressure, rt.t_stack_temp, rt.num_wall_effects_points, rt.yaw_angle, rt.pitch_angle, rt.calc_vel, rt.calc_calc_vel, rt.rep_vel, rt.pressure_meas_cd, rt.userid, rt.add_date, rt.update_date, rt.point_used_ind
	FROM camdecmpswks.rata_traverse rt
    JOIN camdecmpswks.flow_rata_run fr ON fr.flow_rata_run_id = rt.flow_rata_run_id
    JOIN camdecmpswks.rata_run rr on fr.rata_run_id = rr.rata_run_id
    JOIN camdecmps.rata_summary rs ON rr.rata_sum_id = rs.rata_sum_id
    JOIN camdecmpswks.rata r ON r.rata_id = rs.rata_id
	WHERE r.test_sum_id = testSumId;

    ---------------------------------- Linearity Summary -------------------------------------------------
    INSERT INTO camdecmps.linearity_summary(
	lin_sum_id, test_sum_id, mean_ref_value, calc_mean_ref_value, mean_measured_value, calc_mean_measured_value, percent_error, calc_percent_error, aps_ind, calc_aps_ind, gas_level_cd, userid, add_date, update_date)
	SELECT
		lin_sum_id, test_sum_id, mean_ref_value, calc_mean_ref_value, mean_measured_value, calc_mean_measured_value, percent_error, calc_percent_error, aps_ind, calc_aps_ind, gas_level_cd, userid, add_date, update_date
	FROM camdecmpswks.linearity_summary
	WHERE test_sum_id = testSumId;

    INSERT INTO camdecmps.linearity_injection(
	lin_inj_id, lin_sum_id, injection_date, injection_hour, injection_min, measured_value, ref_value, userid, add_date, update_date)
	SELECT
		li.lin_inj_id, li.lin_sum_id, li.injection_date, li.injection_hour, li.injection_min, li.measured_value, li.ref_value, li.userid, li.add_date, li.update_date
	FROM camdecmpswks.linearity_injection li
    JOIN camdecmpswks.linearity_summary ls using(lin_sum_id)
	WHERE ls.test_sum_id = testSumId;

    ---------------------------------- Hg Linearity and 3-Level Summary Data -------------------------------------------------
    INSERT INTO camdecmps.hg_test_summary(
	hg_test_sum_id, test_sum_id, gas_level_cd, mean_measured_value, mean_ref_value, percent_error, aps_ind, calc_mean_measured_value, calc_mean_ref_value, calc_percent_error, calc_aps_ind, userid, add_date, update_date)
	SELECT
		hg_test_sum_id, test_sum_id, gas_level_cd, mean_measured_value, mean_ref_value, percent_error, aps_ind, calc_mean_measured_value, calc_mean_ref_value, calc_percent_error, calc_aps_ind, userid, add_date, update_date
	FROM camdecmpswks.hg_test_summary
	WHERE test_sum_id = testSumId;

    INSERT INTO camdecmps.hg_test_injection(
	hg_test_inj_id, hg_test_sum_id, injection_date, injection_hour, injection_min, measured_value, ref_value, userid, add_date, update_date)
	SELECT
		li.hg_test_inj_id, li.hg_test_sum_id, li.injection_date, li.injection_hour, li.injection_min, li.measured_value, li.ref_value, li.userid, li.add_date, li.update_date
	FROM camdecmpswks.hg_test_injection li
    JOIN camdecmpswks.hg_test_summary ts using(hg_test_sum_id)
	WHERE ts.test_sum_id = testSumId;

    ---------------------------------- Cycle Time SummaryData -------------------------------------------------
    INSERT INTO camdecmps.cycle_time_summary(
	cycle_time_sum_id, test_sum_id, total_time, calc_total_time, userid, add_date, update_date)
	SELECT
		cycle_time_sum_id, test_sum_id, total_time, calc_total_time, userid, add_date, update_date
	FROM camdecmpswks.cycle_time_summary
	WHERE test_sum_id = testSumId;

    INSERT INTO camdecmps.cycle_time_injection(
	cycle_time_inj_id, cycle_time_sum_id, begin_monitor_value, end_monitor_value, begin_date, begin_hour, begin_min, end_date, end_hour, end_min, gas_level_cd, cal_gas_value, userid, add_date, update_date, injection_cycle_time, calc_injection_cycle_time)
	SELECT
		cti.cycle_time_inj_id, cti.cycle_time_sum_id, cti.begin_monitor_value, cti.end_monitor_value, cti.begin_date, cti.begin_hour, cti.begin_min, cti.end_date, cti.end_hour, cti.end_min, cti.gas_level_cd, cti.cal_gas_value, cti.userid, cti.add_date, cti.update_date, cti.injection_cycle_time, cti.calc_injection_cycle_time
	FROM camdecmpswks.cycle_time_injection cti
    JOIN camdecmpswks.cycle_time_summary cts using(cycle_time_sum_id)
	WHERE cts.test_sum_id = testSumId;

    ---------------------------------- Online Offline Calibration Data -------------------------------------------------
    INSERT INTO camdecmps.on_off_cal(
	on_off_cal_id, test_sum_id, online_zero_injection_date, online_zero_injection_hour, online_zero_aps_ind, calc_online_zero_aps_ind, online_zero_cal_error, calc_online_zero_cal_error, online_zero_measured_value, online_zero_ref_value, online_upscale_aps_ind, calc_online_upscale_aps_ind, online_upscale_cal_error, calc_online_upscale_cal_error, online_upscale_injection_date, online_upscale_injection_hour, online_upscale_measured_value, online_upscale_ref_value, offline_zero_aps_ind, calc_offline_zero_aps_ind, offline_zero_cal_error, calc_offline_zero_cal_error, offline_zero_injection_date, offline_zero_injection_hour, offline_zero_measured_value, offline_zero_ref_value, offline_upscale_aps_ind, calc_offline_upscale_aps_ind, offline_upscale_cal_error, calc_offline_upscale_cal_error, offline_upscale_injection_date, offline_upscale_injection_hour, offline_upscale_measured_value, offline_upscale_ref_value, upscale_gas_level_cd, userid, add_date, update_date)
	SELECT
		on_off_cal_id, test_sum_id, online_zero_injection_date, online_zero_injection_hour, online_zero_aps_ind, calc_online_zero_aps_ind, online_zero_cal_error, calc_online_zero_cal_error, online_zero_measured_value, online_zero_ref_value, online_upscale_aps_ind, calc_online_upscale_aps_ind, online_upscale_cal_error, calc_online_upscale_cal_error, online_upscale_injection_date, online_upscale_injection_hour, online_upscale_measured_value, online_upscale_ref_value, offline_zero_aps_ind, calc_offline_zero_aps_ind, offline_zero_cal_error, calc_offline_zero_cal_error, offline_zero_injection_date, offline_zero_injection_hour, offline_zero_measured_value, offline_zero_ref_value, offline_upscale_aps_ind, calc_offline_upscale_aps_ind, offline_upscale_cal_error, calc_offline_upscale_cal_error, offline_upscale_injection_date, offline_upscale_injection_hour, offline_upscale_measured_value, offline_upscale_ref_value, upscale_gas_level_cd, userid, add_date, update_date
	FROM camdecmpswks.on_off_cal
	WHERE test_sum_id = testSumId;

    ---------------------------------- Flow To Load Check Data -------------------------------------------------
    INSERT INTO camdecmps.flow_to_load_check(
	flow_load_check_id, test_sum_id, test_basis_cd, avg_abs_pct_diff, num_hrs, nhe_fuel, nhe_ramping, nhe_bypass, nhe_pre_rata, nhe_test, nhe_main_bypass, bias_adjusted_ind, userid, add_date, update_date, op_level_cd)
	SELECT
		flow_load_check_id, test_sum_id, test_basis_cd, avg_abs_pct_diff, num_hrs, nhe_fuel, nhe_ramping, nhe_bypass, nhe_pre_rata, nhe_test, nhe_main_bypass, bias_adjusted_ind, userid, add_date, update_date, op_level_cd
	FROM camdecmpswks.flow_to_load_check
	WHERE test_sum_id = testSumId;

    ---------------------------------- Flow To Load Reference Data -------------------------------------------------
    INSERT INTO camdecmps.flow_to_load_reference(
	flow_load_ref_id, test_sum_id, op_level_cd, avg_ref_method_flow, calc_avg_ref_method_flow, rata_test_num, avg_gross_unit_load, calc_avg_gross_unit_load, ref_flow_load_ratio, calc_ref_flow_load_ratio, avg_hrly_hi_rate, ref_ghr, calc_ref_ghr, userid, add_date, update_date, calc_sep_ref_ind)
	SELECT
		flow_load_ref_id, test_sum_id, op_level_cd, avg_ref_method_flow, calc_avg_ref_method_flow, rata_test_num, avg_gross_unit_load, calc_avg_gross_unit_load, ref_flow_load_ratio, calc_ref_flow_load_ratio, avg_hrly_hi_rate, ref_ghr, calc_ref_ghr, userid, add_date, update_date, calc_sep_ref_ind
	FROM camdecmpswks.flow_to_load_reference
	WHERE test_sum_id = testSumId;

    ---------------------------------- Test Qualification Data -------------------------------------------------
    INSERT INTO camdecmps.test_qualification(
	test_qualification_id, test_sum_id, test_claim_cd, hi_load_pct, mid_load_pct, low_load_pct, begin_date, end_date, userid, add_date, update_date)
	SELECT
		test_qualification_id, test_sum_id, test_claim_cd, hi_load_pct, mid_load_pct, low_load_pct, begin_date, end_date, userid, add_date, update_date
	FROM camdecmpswks.test_qualification
	WHERE test_sum_id = testSumId;

    ---------------------------------- Calibration Injection Data -------------------------------------------------
    INSERT INTO camdecmps.calibration_injection(
	cal_inj_id, test_sum_id, online_offline_ind, zero_ref_value, zero_cal_error, calc_zero_cal_error, zero_aps_ind, calc_zero_aps_ind, zero_injection_date, zero_injection_hour, zero_injection_min, upscale_ref_value, zero_measured_value, upscale_gas_level_cd, upscale_measured_value, upscale_cal_error, calc_upscale_cal_error, upscale_aps_ind, calc_upscale_aps_ind, upscale_injection_date, upscale_injection_hour, upscale_injection_min, userid, add_date, update_date)
	SELECT
		cal_inj_id, test_sum_id, online_offline_ind, zero_ref_value, zero_cal_error, calc_zero_cal_error, zero_aps_ind, calc_zero_aps_ind, zero_injection_date, zero_injection_hour, zero_injection_min, upscale_ref_value, zero_measured_value, upscale_gas_level_cd, upscale_measured_value, upscale_cal_error, calc_upscale_cal_error, upscale_aps_ind, calc_upscale_aps_ind, upscale_injection_date, upscale_injection_hour, upscale_injection_min, userid, add_date, update_date
	FROM camdecmpswks.calibration_injection
	WHERE test_sum_id = testSumId;
END;
$BODY$;
