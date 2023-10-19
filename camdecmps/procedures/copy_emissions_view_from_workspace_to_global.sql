-- PROCEDURE: camdecmps.copy_emissions_from_workspace_to_global(character varying, numeric)

DROP PROCEDURE IF EXISTS camdecmps.copy_emissions_views_from_workspace_to_global(character varying, numeric);

CREATE OR REPLACE PROCEDURE camdecmps.copy_emissions_views_from_workspace_to_global(
  monPlanId character varying(45),
  rptPeriodId numeric
)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
  monLocIds text[];
BEGIN 
  SELECT ARRAY(
    SELECT mon_loc_id 
    FROM camdecmpswks.monitor_plan_location 
    WHERE mon_plan_id = monPlanId
  ) INTO monLocIds;

  DELETE FROM camdecmps.emission_view_all
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  INSERT INTO camdecmps.emission_view_all (
      mon_plan_id, mon_loc_id, rpt_period_id, hour_id, date_hour, op_time, unit_load, load_uom,
      hi_formula_cd, rpt_hi_rate, calc_hi_rate, so2_formula_cd, rpt_so2_mass_rate, calc_so2_mass_rate,
      nox_rate_formula_cd, rpt_adj_nox_rate, calc_adj_nox_rate, nox_mass_formula_cd, rpt_nox_mass,
      calc_nox_mass, co2_formula_cd, rpt_co2_mass_rate, calc_co2_mass_rate, error_codes, adj_flow_used,
      rpt_adj_flow, unadj_flow
  )
  SELECT 
      mon_plan_id, mon_loc_id, rpt_period_id, hour_id, date_hour, op_time, unit_load, load_uom,
      hi_formula_cd, rpt_hi_rate, calc_hi_rate, so2_formula_cd, rpt_so2_mass_rate, calc_so2_mass_rate,
      nox_rate_formula_cd, rpt_adj_nox_rate, calc_adj_nox_rate, nox_mass_formula_cd, rpt_nox_mass,
      calc_nox_mass, co2_formula_cd, rpt_co2_mass_rate, calc_co2_mass_rate, error_codes, adj_flow_used,
      rpt_adj_flow, unadj_flow
  FROM camdecmpswks.emission_view_all
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  DELETE FROM camdecmps.emission_view_co2appd
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  INSERT INTO camdecmps.emission_view_co2appd (
    mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, fuel_sys_id, fuel_type, fuel_use_time,
    unit_load, load_uom, calc_hi_rate, fc_factor, formula_cd, rpt_co2_mass_rate, calc_co2_mass_rate,
    summation_formula_cd, rpt_co2_mass_rate_all_fuels, calc_co2_mass_rate_all_fuels, error_codes
  )
  SELECT 
      mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, fuel_sys_id, fuel_type, fuel_use_time,
      unit_load, load_uom, calc_hi_rate, fc_factor, formula_cd, rpt_co2_mass_rate, calc_co2_mass_rate,
      summation_formula_cd, rpt_co2_mass_rate_all_fuels, calc_co2_mass_rate_all_fuels, error_codes
  FROM camdecmpswks.emission_view_co2appd
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  DELETE FROM camdecmps.emission_view_co2calc
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  INSERT INTO camdecmps.emission_view_co2calc (
    mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, co2c_modc, co2c_pma, rpt_pct_o2, pct_o2_used,
    o2_modc, pct_h2o_used, source_h2o_value, fc_factor, fd_factor, formula_cd, rpt_pct_co2, calc_pct_co2,
    error_codes
  )
  SELECT 
      mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, co2c_modc, co2c_pma, rpt_pct_o2, pct_o2_used,
      o2_modc, pct_h2o_used, source_h2o_value, fc_factor, fd_factor, formula_cd, rpt_pct_co2, calc_pct_co2,
      error_codes
  FROM camdecmpswks.emission_view_co2calc
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  DELETE FROM camdecmps.emission_view_co2cems
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  INSERT INTO camdecmps.emission_view_co2cems (
      mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, unit_load, load_uom, component_type, rpt_pct_co2,
      pct_co2_used, co2_modc, co2_pma, unadj_flow, calc_flow_baf, rpt_adj_flow, adj_flow_used, flow_modc, flow_pma,
      pct_h2o_used, source_h2o_value, co2_formula_cd, rpt_co2_mass_rate, calc_co2_mass_rate, error_codes
  )
  SELECT 
      mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, unit_load, load_uom, component_type, rpt_pct_co2,
      pct_co2_used, co2_modc, co2_pma, unadj_flow, calc_flow_baf, rpt_adj_flow, adj_flow_used, flow_modc, flow_pma,
      pct_h2o_used, source_h2o_value, co2_formula_cd, rpt_co2_mass_rate, calc_co2_mass_rate, error_codes
  FROM camdecmpswks.emission_view_co2cems
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  DELETE FROM camdecmps.emission_view_co2dailyfuel
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;
  
  INSERT INTO camdecmps.emission_view_co2dailyfuel (
      mon_plan_id, mon_loc_id, rpt_period_id, date, rpt_total_daily_co2_mass, rpt_unadjusted_co2_mass,
      rpt_adjusted_daily_co2_mass, rpt_sorbent_rltd_co2_mass, error_codes, fuel_cd, daily_fuel_feed,
      carbon_content_used, fuel_carbon_burned, calc_fuel_carbon_burned, total_carbon_burned,
      calc_total_daily_emission
  )
  SELECT 
      mon_plan_id, mon_loc_id, rpt_period_id, date, rpt_total_daily_co2_mass, rpt_unadjusted_co2_mass,
      rpt_adjusted_daily_co2_mass, rpt_sorbent_rltd_co2_mass, error_codes, fuel_cd, daily_fuel_feed,
      carbon_content_used, fuel_carbon_burned, calc_fuel_carbon_burned, total_carbon_burned,
      calc_total_daily_emission
  FROM camdecmpswks.emission_view_co2dailyfuel
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  DELETE FROM camdecmps.emission_view_count
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  INSERT INTO camdecmps.emission_view_count (
      mon_plan_id, mon_loc_id, dataset_cd, rpt_period_id, count
  )
  SELECT 
      mon_plan_id, mon_loc_id, dataset_cd, rpt_period_id, count
  FROM camdecmpswks.emission_view_count
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  DELETE FROM camdecmps.emission_view_dailycal
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  INSERT INTO camdecmps.emission_view_dailycal (
    mon_plan_id, mon_loc_id, rpt_period_id, test_sum_id, component_identifier, component_type_cd,
    span_scale_cd, end_datetime, rpt_test_result_cd, calc_test_result_cd, applicable_span_value,
    upscale_gas_level_cd, upscale_injection_date, upscale_injection_time, upscale_measured_value,
    upscale_ref_value, rpt_upscale_ce_or_mean_diff, rpt_upscale_aps_ind, calc_upscale_ce_or_mean_diff,
    calc_upscale_aps_ind, zero_injection_date, zero_injection_time, zero_measured_value, zero_ref_value,
    rpt_zero_ce_or_mean_diff, rpt_zero_aps_ind, calc_zero_ce_or_mean_diff, calc_zero_aps_ind,
    rpt_online_offline_ind, calc_online_offline_ind, error_codes, upscale_gas_type_cd, cylinder_id,
    expiration_date, vendor_id
  )
  SELECT 
      mon_plan_id, mon_loc_id, rpt_period_id, test_sum_id, component_identifier, component_type_cd,
      span_scale_cd, end_datetime, rpt_test_result_cd, calc_test_result_cd, applicable_span_value,
      upscale_gas_level_cd, upscale_injection_date, upscale_injection_time, upscale_measured_value,
      upscale_ref_value, rpt_upscale_ce_or_mean_diff, rpt_upscale_aps_ind, calc_upscale_ce_or_mean_diff,
      calc_upscale_aps_ind, zero_injection_date, zero_injection_time, zero_measured_value, zero_ref_value,
      rpt_zero_ce_or_mean_diff, rpt_zero_aps_ind, calc_zero_ce_or_mean_diff, calc_zero_aps_ind,
      rpt_online_offline_ind, calc_online_offline_ind, error_codes, upscale_gas_type_cd, cylinder_id,
      expiration_date, vendor_id
  FROM camdecmpswks.emission_view_dailycal
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  DELETE FROM camdecmps.emission_view_hiappd
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  INSERT INTO camdecmps.emission_view_hiappd (
    mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, fuel_sys_id, fuel_type, fuel_use_time,
    unit_load, load_uom, rpt_fuel_flow, calc_fuel_flow, fuel_flow_uom, fuel_flow_sodc, gross_calorific_value,
    gcv_uom, gcv_sampling_type, formula_cd, rpt_hi_rate, calc_hi_rate, error_codes
  )
  SELECT 
      mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, fuel_sys_id, fuel_type, fuel_use_time,
      unit_load, load_uom, rpt_fuel_flow, calc_fuel_flow, fuel_flow_uom, fuel_flow_sodc, gross_calorific_value,
      gcv_uom, gcv_sampling_type, formula_cd, rpt_hi_rate, calc_hi_rate, error_codes
  FROM camdecmpswks.emission_view_hiappd
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  DELETE FROM camdecmps.emission_view_hicems
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  INSERT INTO camdecmps.emission_view_hicems (
      mon_plan_id, mon_loc_id, rpt_period_id, hour_id, date_hour, op_time, unit_load, load_uom, load_range,
      common_stack_load_range, hi_formula_cd, hi_modc, rpt_hi_rate, calc_hi_rate, diluent_param, rpt_pct_diluent,
      pct_diluent_used, diluent_modc, diluent_pma, unadj_flow, calc_flow_baf, rpt_adj_flow, adj_flow_used,
      flow_modc, flow_pma, pct_h2o_used, source_h2o_value, f_factor, error_codes, fuel_cd
  )
  SELECT 
      mon_plan_id, mon_loc_id, rpt_period_id, hour_id, date_hour, op_time, unit_load, load_uom, load_range,
      common_stack_load_range, hi_formula_cd, hi_modc, rpt_hi_rate, calc_hi_rate, diluent_param, rpt_pct_diluent,
      pct_diluent_used, diluent_modc, diluent_pma, unadj_flow, calc_flow_baf, rpt_adj_flow, adj_flow_used,
      flow_modc, flow_pma, pct_h2o_used, source_h2o_value, f_factor, error_codes, fuel_cd
  FROM camdecmpswks.emission_view_hicems
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  DELETE FROM camdecmps.emission_view_hiunitstack
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  INSERT INTO camdecmps.emission_view_hiunitstack (
      mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, unit_load, load_uom, load_range,
      common_stack_load_range, hi_formula_cd, rpt_hi_rate, calc_hi_rate, error_codes
  )
  SELECT 
      mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, unit_load, load_uom, load_range,
      common_stack_load_range, hi_formula_cd, rpt_hi_rate, calc_hi_rate, error_codes
  FROM camdecmpswks.emission_view_hiunitstack
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  DELETE FROM camdecmps.emission_view_lme
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  INSERT INTO camdecmps.emission_view_lme (
    mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, unit_load, load_uom, hour_id, hi_modc,
    rpt_heat_input, calc_heat_input, so2m_fuel_type, so2_emiss_rate, rpt_so2_mass, calc_so2_mass,
    noxm_fuel_type, operating_condition_cd, nox_emiss_rate, rpt_nox_mass, calc_nox_mass, co2m_fuel_type,
    co2_emiss_rate, rpt_co2_mass, calc_co2_mass, error_codes
  )
  SELECT 
      mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, unit_load, load_uom, hour_id, hi_modc,
      rpt_heat_input, calc_heat_input, so2m_fuel_type, so2_emiss_rate, rpt_so2_mass, calc_so2_mass,
      noxm_fuel_type, operating_condition_cd, nox_emiss_rate, rpt_nox_mass, calc_nox_mass, co2m_fuel_type,
      co2_emiss_rate, rpt_co2_mass, calc_co2_mass, error_codes
  FROM camdecmpswks.emission_view_lme
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  DELETE FROM camdecmps.emission_view_massoilcalc
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  INSERT INTO camdecmps.emission_view_massoilcalc (
      mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, fuel_sys_id, oil_type, fuel_use_time,
      rpt_volumetric_oil_flow, calc_volumetric_oil_flow, volumetric_oil_flow_uom, volumetric_oil_flow_sodc,
      oil_density, oil_density_uom, oil_density_sampling_type, rpt_mass_oil_flow, calc_mass_oil_flow, error_codes
  )
  SELECT 
      mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, fuel_sys_id, oil_type, fuel_use_time,
      rpt_volumetric_oil_flow, calc_volumetric_oil_flow, volumetric_oil_flow_uom, volumetric_oil_flow_sodc,
      oil_density, oil_density_uom, oil_density_sampling_type, rpt_mass_oil_flow, calc_mass_oil_flow, error_codes
  FROM camdecmpswks.emission_view_massoilcalc
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  DELETE FROM camdecmps.emission_view_matshcl
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  INSERT INTO camdecmps.emission_view_matshcl (
    mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, mats_load, mats_startup_shutdown, hcl_conc_value,
    hcl_conc_modc_cd, hcl_conc_pma, flow_rate, flow_modc, flow_pma, rpt_pct_diluent, diluent_parameter,
    calc_pct_diluent, diluent_modc, calc_pct_h2o, h2o_source, f_factor, hcl_formula_cd, rpt_hcl_rate, hcl_uom,
    hcl_modc_cd, error_codes, calc_hcl_rate
  )
  SELECT 
      mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, mats_load, mats_startup_shutdown, hcl_conc_value,
      hcl_conc_modc_cd, hcl_conc_pma, flow_rate, flow_modc, flow_pma, rpt_pct_diluent, diluent_parameter,
      calc_pct_diluent, diluent_modc, calc_pct_h2o, h2o_source, f_factor, hcl_formula_cd, rpt_hcl_rate, hcl_uom,
      hcl_modc_cd, error_codes, calc_hcl_rate
  FROM camdecmpswks.emission_view_matshcl
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  DELETE FROM camdecmps.emission_view_matshf
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  INSERT INTO camdecmps.emission_view_matshf (
      mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, mats_load, mats_startup_shutdown, hf_conc_value,
      hf_conc_modc_cd, hf_conc_pma, flow_rate, flow_modc, flow_pma, rpt_pct_diluent, diluent_parameter,
      calc_pct_diluent, diluent_modc, calc_pct_h2o, h2o_source, f_factor, hf_formula_cd, rpt_hf_rate, hf_uom,
      hf_modc_cd, error_codes, calc_hf_rate
  )
  SELECT 
      mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, mats_load, mats_startup_shutdown, hf_conc_value,
      hf_conc_modc_cd, hf_conc_pma, flow_rate, flow_modc, flow_pma, rpt_pct_diluent, diluent_parameter,
      calc_pct_diluent, diluent_modc, calc_pct_h2o, h2o_source, f_factor, hf_formula_cd, rpt_hf_rate, hf_uom,
      hf_modc_cd, error_codes, calc_hf_rate
  FROM camdecmpswks.emission_view_matshf
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  DELETE FROM camdecmps.emission_view_matshg
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  INSERT INTO camdecmps.emission_view_matshg (
      mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, mats_load, mats_startup_shutdown, hg_conc_value,
      hg_conc_system_id, hg_conc_sys_type, hg_conc_modc_cd, hg_conc_pma, sampling_train_comp_id1,
      gas_flowmeter_reading1, ratio_stack_gas_flow_rate1, sampling_train_comp_id2, gas_flowmeter_reading2,
      ratio_stack_gas_flow_rate2, flow_rate, flow_modc, flow_pma, rpt_pct_diluent, diluent_parameter,
      calc_pct_diluent, diluent_modc, calc_pct_h2o, h2o_source, f_factor, hg_formula_cd, rpt_hg_rate, hg_uom,
      hg_modc_cd, error_codes, calc_hg_rate
  )
  SELECT 
      mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, mats_load, mats_startup_shutdown, hg_conc_value,
      hg_conc_system_id, hg_conc_sys_type, hg_conc_modc_cd, hg_conc_pma, sampling_train_comp_id1,
      gas_flowmeter_reading1, ratio_stack_gas_flow_rate1, sampling_train_comp_id2, gas_flowmeter_reading2,
      ratio_stack_gas_flow_rate2, flow_rate, flow_modc, flow_pma, rpt_pct_diluent, diluent_parameter,
      calc_pct_diluent, diluent_modc, calc_pct_h2o, h2o_source, f_factor, hg_formula_cd, rpt_hg_rate, hg_uom,
      hg_modc_cd, error_codes, calc_hg_rate
  FROM camdecmpswks.emission_view_matshg
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  DELETE FROM camdecmps.emission_view_matsso2
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  INSERT INTO camdecmps.emission_view_matsso2 (
      mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, mats_load, mats_startup_shutdown, so2_conc_value,
      so2_conc_modc_cd, so2_conc_pma, flow_rate, flow_modc, flow_pma, rpt_pct_diluent, diluent_parameter,
      calc_pct_diluent, diluent_modc, calc_pct_h2o, h2o_source, f_factor, so2_formula_cd, rpt_so2_rate, so2_uom,
      so2_modc_cd, error_codes, calc_so2_rate
  )
  SELECT 
      mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, mats_load, mats_startup_shutdown, so2_conc_value,
      so2_conc_modc_cd, so2_conc_pma, flow_rate, flow_modc, flow_pma, rpt_pct_diluent, diluent_parameter,
      calc_pct_diluent, diluent_modc, calc_pct_h2o, h2o_source, f_factor, so2_formula_cd, rpt_so2_rate, so2_uom,
      so2_modc_cd, error_codes, calc_so2_rate
  FROM camdecmpswks.emission_view_matsso2
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  DELETE FROM camdecmps.emission_view_matssorbent
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  INSERT INTO camdecmps.emission_view_matssorbent (
    mon_plan_id, mon_loc_id, rpt_period_id, system_identifier, date_hour, end_date_time, paired_trap_agreement,
    absolute_difference_ind, modc_cd, hg_concentration, a_component_id, a_sorbent_trap_serial_number, a_main_trap_hg,
    a_breakthrough_trap_hg, a_spike_trap_hg, a_spike_ref_value, a_total_sample_volume, a_ref_flow_to_sampling_ratio,
    a_hg_concentration, a_percent_breakthrough, a_percent_spike_recovery, a_sampling_ratio_test_result_cd,
    a_post_leak_test_result_cd, a_train_qa_status_cd, a_sample_damage_explanation, b_component_id,
    b_sorbent_trap_serial_number, b_main_trap_hg, b_breakthrough_trap_hg, b_spike_trap_hg, b_spike_ref_value,
    b_total_sample_volume, b_ref_flow_to_sampling_ratio, b_hg_concentration, b_percent_breakthrough, b_percent_spike_recovery,
    b_sampling_ratio_test_result_cd, b_post_leak_test_result_cd, b_train_qa_status_cd, b_sample_damage_explanation,
    error_codes, sorbent_trap_aps_cd, rata_ind
  )
  SELECT 
      mon_plan_id, mon_loc_id, rpt_period_id, system_identifier, date_hour, end_date_time, paired_trap_agreement,
      absolute_difference_ind, modc_cd, hg_concentration, a_component_id, a_sorbent_trap_serial_number, a_main_trap_hg,
      a_breakthrough_trap_hg, a_spike_trap_hg, a_spike_ref_value, a_total_sample_volume, a_ref_flow_to_sampling_ratio,
      a_hg_concentration, a_percent_breakthrough, a_percent_spike_recovery, a_sampling_ratio_test_result_cd,
      a_post_leak_test_result_cd, a_train_qa_status_cd, a_sample_damage_explanation, b_component_id,
      b_sorbent_trap_serial_number, b_main_trap_hg, b_breakthrough_trap_hg, b_spike_trap_hg, b_spike_ref_value,
      b_total_sample_volume, b_ref_flow_to_sampling_ratio, b_hg_concentration, b_percent_breakthrough, b_percent_spike_recovery,
      b_sampling_ratio_test_result_cd, b_post_leak_test_result_cd, b_train_qa_status_cd, b_sample_damage_explanation,
      error_codes, sorbent_trap_aps_cd, rata_ind
  FROM camdecmpswks.emission_view_matssorbent
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  DELETE FROM camdecmps.emission_view_matsweekly
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  INSERT INTO camdecmps.emission_view_matsweekly (
      mon_plan_id, mon_loc_id, rpt_period_id, weekly_test_sum_id, system_component_identifier,
      system_component_type, date_hour, test_type, test_result, span_scale, gas_level, ref_value,
      measured_value, system_integrity_error, error_codes
  )
  SELECT 
      mon_plan_id, mon_loc_id, rpt_period_id, weekly_test_sum_id, system_component_identifier,
      system_component_type, date_hour, test_type, test_result, span_scale, gas_level, ref_value,
      measured_value, system_integrity_error, error_codes
  FROM camdecmpswks.emission_view_matsweekly
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  DELETE FROM camdecmps.emission_view_moisture
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  INSERT INTO camdecmps.emission_view_moisture (
    mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, h2o_modc, h2o_pma, pct_o2_wet, o2_wet_modc,
    pct_o2_dry, o2_dry_modc, h2o_formula_cd, rpt_pct_h2o, calc_pct_h2o, error_codes
  )
  SELECT 
      mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, h2o_modc, h2o_pma, pct_o2_wet, o2_wet_modc,
      pct_o2_dry, o2_dry_modc, h2o_formula_cd, rpt_pct_h2o, calc_pct_h2o, error_codes
  FROM camdecmpswks.emission_view_moisture
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  DELETE FROM camdecmps.emission_view_noxappemixedfuel
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  INSERT INTO camdecmps.emission_view_noxappemixedfuel (
      mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, system_id, unit_load, load_uom, calc_hi_rate,
      operating_condition_cd, segment_number, rpt_nox_emission_rate, calc_nox_emission_rate, nox_mass_rate_formula_cd,
      rpt_nox_mass_rate, calc_nox_mass_rate, error_codes
  )
  SELECT 
      mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, system_id, unit_load, load_uom, calc_hi_rate,
      operating_condition_cd, segment_number, rpt_nox_emission_rate, calc_nox_emission_rate, nox_mass_rate_formula_cd,
      rpt_nox_mass_rate, calc_nox_mass_rate, error_codes
  FROM camdecmpswks.emission_view_noxappemixedfuel
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  DELETE FROM camdecmps.emission_view_noxappesinglefuel
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  INSERT INTO camdecmps.emission_view_noxappesinglefuel (
    mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, fuel_sys_id, fuel_type, fuel_use_time, unit_load,
    load_uom, calc_hi_rate, operating_condition_cd, segment_number, app_e_sys_id, rpt_nox_emission_rate,
    calc_nox_emission_rate, summation_formula_cd, rpt_nox_emission_rate_all_fuels, calc_nox_emission_rate_all_fuels,
    calc_hi_rate_all_fuels, nox_mass_rate_formula_cd, rpt_nox_mass_all_fuels, calc_nox_mass_all_fuels, error_codes
  )
  SELECT 
      mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, fuel_sys_id, fuel_type, fuel_use_time, unit_load,
      load_uom, calc_hi_rate, operating_condition_cd, segment_number, app_e_sys_id, rpt_nox_emission_rate,
      calc_nox_emission_rate, summation_formula_cd, rpt_nox_emission_rate_all_fuels, calc_nox_emission_rate_all_fuels,
      calc_hi_rate_all_fuels, nox_mass_rate_formula_cd, rpt_nox_mass_all_fuels, calc_nox_mass_all_fuels, error_codes
  FROM camdecmpswks.emission_view_noxappesinglefuel
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  DELETE FROM camdecmps.emission_view_noxmasscems
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  INSERT INTO camdecmps.emission_view_noxmasscems (
    mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, unit_load, load_uom, unadj_nox, calc_nox_baf, rpt_adj_nox, adj_nox_used, nox_modc, nox_pma, unadj_flow, calc_flow_baf, rpt_adj_flow, adj_flow_used, flow_modc, flow_pma, pct_h2o_used, source_h2o_value, nox_mass_formula_cd, rpt_nox_mass, calc_nox_mass, error_codes
  )
  SELECT 
      mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, unit_load, load_uom, unadj_nox, calc_nox_baf, rpt_adj_nox, adj_nox_used, nox_modc, nox_pma, unadj_flow, calc_flow_baf, rpt_adj_flow, adj_flow_used, flow_modc, flow_pma, pct_h2o_used, source_h2o_value, nox_mass_formula_cd, rpt_nox_mass, calc_nox_mass, error_codes
  FROM camdecmpswks.emission_view_noxmasscems
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  DELETE FROM camdecmps.emission_view_noxratecems
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  INSERT INTO camdecmps.emission_view_noxratecems (
      mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, unit_load, load_uom, nox_rate_modc, nox_rate_pma, unadj_nox, nox_modc, diluent_param, pct_diluent_used, diluent_modc, pct_h2o_used, source_h2o_value, f_factor, nox_rate_formula_cd, rpt_unadj_nox_rate, calc_unadj_nox_rate, calc_nox_baf, rpt_adj_nox_rate, calc_adj_nox_rate, calc_hi_rate, nox_mass_formula_cd, rpt_nox_mass, calc_nox_mass, error_codes, rpt_diluent
  )
  SELECT 
      mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, unit_load, load_uom, nox_rate_modc, nox_rate_pma, unadj_nox, nox_modc, diluent_param, pct_diluent_used, diluent_modc, pct_h2o_used, source_h2o_value, f_factor, nox_rate_formula_cd, rpt_unadj_nox_rate, calc_unadj_nox_rate, calc_nox_baf, rpt_adj_nox_rate, calc_adj_nox_rate, calc_hi_rate, nox_mass_formula_cd, rpt_nox_mass, calc_nox_mass, error_codes, rpt_diluent
  FROM camdecmpswks.emission_view_noxratecems
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  DELETE FROM camdecmps.emission_view_otherdaily
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  INSERT INTO camdecmps.emission_view_otherdaily (
      mon_plan_id, mon_loc_id, rpt_period_id, test_type_cd, system_component_identifier, system_component_type, span_scale_cd, date_hour, rpt_test_result, error_codes, calc_test_result_cd, test_sum_id
  )
  SELECT 
      mon_plan_id, mon_loc_id, rpt_period_id, test_type_cd, system_component_identifier, system_component_type, span_scale_cd, date_hour, rpt_test_result, error_codes, calc_test_result_cd, test_sum_id
  FROM camdecmpswks.emission_view_otherdaily
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  DELETE FROM camdecmps.emission_view_so2appd
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  INSERT INTO camdecmps.emission_view_so2appd (
    mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, fuel_sys_id, fuel_type, fuel_use_time, unit_load, load_uom, calc_fuel_flow, fuel_flow_uom, fuel_flow_sodc, sulfur_content, sulfur_uom, sulfur_sampling_type, default_so2_emission_rate, calc_hi_rate, formula_cd, rpt_so2_mass_rate, calc_so2_mass_rate, summation_formula_cd, rpt_so2_mass_rate_all_fuels, calc_so2_mass_rate_all_fuels, error_codes
  )
  SELECT 
      mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, fuel_sys_id, fuel_type, fuel_use_time, unit_load, load_uom, calc_fuel_flow, fuel_flow_uom, fuel_flow_sodc, sulfur_content, sulfur_uom, sulfur_sampling_type, default_so2_emission_rate, calc_hi_rate, formula_cd, rpt_so2_mass_rate, calc_so2_mass_rate, summation_formula_cd, rpt_so2_mass_rate_all_fuels, calc_so2_mass_rate_all_fuels, error_codes
  FROM camdecmpswks.emission_view_so2appd
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  DELETE FROM camdecmps.emission_view_so2cems
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  INSERT INTO camdecmps.emission_view_so2cems (
    mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, unit_load, load_uom, unadj_so2, so2_baf, rpt_adj_so2, calc_adj_so2, so2_modc, so2_pma, unadj_flow, flow_baf, rpt_adj_flow, adj_flow_used, flow_modc, flow_pma, pct_h2o_used, source_h2o_value, so2_formula_cd, rpt_so2_mass_rate, calc_so2_mass_rate, calc_hi_rate, default_so2_emission_rate, error_codes
  )
  SELECT 
      mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, unit_load, load_uom, unadj_so2, so2_baf, rpt_adj_so2, calc_adj_so2, so2_modc, so2_pma, unadj_flow, flow_baf, rpt_adj_flow, adj_flow_used, flow_modc, flow_pma, pct_h2o_used, source_h2o_value, so2_formula_cd, rpt_so2_mass_rate, calc_so2_mass_rate, calc_hi_rate, default_so2_emission_rate, error_codes
  FROM camdecmpswks.emission_view_so2cems
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId;

  -- DELETE WORKSPACE EMISSIONS VIEW DATA
  -- THIS WILL BE TAKEN CARE OF BY THE CASCADE DELETE OF EMISSION EVALUATION RECORD

END
$BODY$;
