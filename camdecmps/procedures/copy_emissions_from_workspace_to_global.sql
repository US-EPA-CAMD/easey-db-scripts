-- PROCEDURE: camdecmps.copy_emissions_from_workspace_to_global(character varying, numeric)

DROP PROCEDURE IF EXISTS camdecmps.copy_emissions_from_workspace_to_global(character varying, numeric);

CREATE OR REPLACE PROCEDURE camdecmps.copy_emissions_from_workspace_to_global(
  monPlanId character varying(45), rptPeriodId numeric
) LANGUAGE 'plpgsql' AS $BODY$ DECLARE monLocIds text[];
BEGIN 
SELECT 
  ARRAY(
    SELECT 
      mon_loc_id 
    FROM 
      camdecmpswks.monitor_plan_location 
    WHERE 
      mon_plan_id = monPlanId
  ) INTO monLocIds;
---------------------------------------------------------------------------------------------------------------
INSERT INTO camdecmps.emission_evaluation (
  mon_plan_id, rpt_period_id, last_updated, 
  updated_status_flg, needs_eval_flg, 
  chk_session_id, submission_id, submission_availability_cd
) 
SELECT 
  mon_plan_id, 
  rpt_period_id, 
  last_updated, 
  updated_status_flg, 
  needs_eval_flg, 
  chk_session_id, 
  submission_id, 
  'UPDATED' 
FROM 
  camdecmpswks.emission_evaluation 
WHERE 
  mon_plan_id = monPlanId 
  AND rpt_period_id = rptPeriodId ON CONFLICT (mon_plan_id, rpt_period_id) DO 
UPDATE 
SET 
  last_updated = EXCLUDED.last_updated, 
  updated_status_flg = EXCLUDED.updated_status_flg, 
  needs_eval_flg = EXCLUDED.needs_eval_flg, 
  chk_session_id = EXCLUDED.chk_session_id, 
  submission_id = EXCLUDED.submission_id, 
  submission_availability_cd = EXCLUDED.submission_availability_cd;
-- Check Session
INSERT INTO camdecmpsaux.check_session (
  chk_session_id, mon_plan_id, test_sum_id, 
  qa_cert_event_id, test_extension_exemption_id, 
  rpt_period_id, session_begin_date, 
  session_end_date, session_comment, 
  severity_cd, category_cd, process_cd, 
  userid
) 
SELECT 
  cs.chk_session_id, 
  cs.mon_plan_id, 
  cs.test_sum_id, 
  cs.qa_cert_event_id, 
  cs.test_extension_exemption_id, 
  cs.rpt_period_id, 
  cs.session_begin_date, 
  cs.session_end_date, 
  cs.session_comment, 
  cs.severity_cd, 
  cs.category_cd, 
  cs.process_cd, 
  cs.userid 
FROM 
  camdecmpswks.emission_evaluation ee 
  JOIN camdecmpswks.check_session cs ON ee.chk_session_id = cs.chk_session_id 
WHERE 
  ee.mon_plan_id = monPlanId 
  AND ee.rpt_period_id = rptPeriodId ON CONFLICT (chk_session_id) DO 
UPDATE 
SET 
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
  chk_log_id, chk_session_id, begin_date, 
  rule_check_id, result_message, chk_log_comment, 
  check_catalog_result_id, mon_loc_id, 
  source_table, row_id, test_sum_id, 
  op_begin_date, op_begin_hour, op_end_date, 
  op_end_hour, check_date, check_hour, 
  check_result, severity_cd, suppressed_severity_cd, 
  check_cd, error_suppress_id
) 
SELECT 
  cl.chk_log_id, 
  cl.chk_session_id, 
  cl.begin_date, 
  cl.rule_check_id, 
  cl.result_message, 
  cl.chk_log_comment, 
  cl.check_catalog_result_id, 
  cl.mon_loc_id, 
  cl.source_table, 
  cl.row_id, 
  cl.test_sum_id, 
  cl.op_begin_date, 
  cl.op_begin_hour, 
  cl.op_end_date, 
  cl.op_end_hour, 
  cl.check_date, 
  cl.check_hour, 
  cl.check_result, 
  cl.severity_cd, 
  cl.suppressed_severity_cd, 
  cl.check_cd, 
  cl.error_suppress_id 
FROM 
  camdecmpswks.emission_evaluation ee 
  JOIN camdecmpswks.check_session cs ON ee.chk_session_id = cs.chk_session_id 
  JOIN camdecmpswks.check_log cl ON cs.chk_session_id = cl.chk_session_id 
WHERE 
  ee.mon_plan_id = monPlanId 
  AND ee.rpt_period_id = rptPeriodId ON CONFLICT (chk_log_id) DO 
UPDATE 
SET 
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
-- Upsert into camdecmps.summary_value
INSERT INTO camdecmps.summary_value (
  sum_value_id, rpt_period_id, mon_loc_id, 
  parameter_cd, current_rpt_period_total, 
  calc_current_rpt_period_total, 
  os_total, calc_os_total, year_total, 
  calc_year_total, userid, add_date, 
  update_date
) 
SELECT 
  sum_value_id, 
  rpt_period_id, 
  mon_loc_id, 
  parameter_cd, 
  current_rpt_period_total, 
  calc_current_rpt_period_total, 
  os_total, 
  calc_os_total, 
  year_total, 
  calc_year_total, 
  userid, 
  add_date, 
  update_date 
FROM 
  camdecmpswks.summary_value 
WHERE 
  mon_loc_id = ANY(monLocIds) 
  AND rpt_period_id = rptPeriodId ON CONFLICT (mon_loc_id, rpt_period_id, parameter_cd) DO 
UPDATE 
SET 
  rpt_period_id = EXCLUDED.rpt_period_id, 
  mon_loc_id = EXCLUDED.mon_loc_id, 
  parameter_cd = EXCLUDED.parameter_cd, 
  current_rpt_period_total = EXCLUDED.current_rpt_period_total, 
  calc_current_rpt_period_total = EXCLUDED.calc_current_rpt_period_total, 
  os_total = EXCLUDED.os_total, 
  calc_os_total = EXCLUDED.calc_os_total, 
  year_total = EXCLUDED.year_total, 
  calc_year_total = EXCLUDED.calc_year_total, 
  userid = EXCLUDED.userid, 
  add_date = EXCLUDED.add_date, 
  update_date = EXCLUDED.update_date;
-- Upsert into camdecmps.long_term_fuel_flow
INSERT INTO camdecmps.long_term_fuel_flow (
  ltff_id, rpt_period_id, mon_loc_id, 
  mon_sys_id, fuel_flow_period_cd, 
  long_term_fuel_flow_value, ltff_uom_cd, 
  gross_calorific_value, gcv_uom_cd, 
  total_heat_input, calc_total_heat_input, 
  userid, add_date, update_date
) 
SELECT 
  ltff_id, 
  rpt_period_id, 
  mon_loc_id, 
  mon_sys_id, 
  fuel_flow_period_cd, 
  long_term_fuel_flow_value, 
  ltff_uom_cd, 
  gross_calorific_value, 
  gcv_uom_cd, 
  total_heat_input, 
  calc_total_heat_input, 
  userid, 
  add_date, 
  update_date 
FROM 
  camdecmpswks.long_term_fuel_flow 
WHERE 
  mon_loc_id = ANY(monLocIds) 
  AND rpt_period_id = rptPeriodId ON CONFLICT (ltff_id) DO 
UPDATE 
SET 
  rpt_period_id = EXCLUDED.rpt_period_id, 
  mon_loc_id = EXCLUDED.mon_loc_id, 
  mon_sys_id = EXCLUDED.mon_sys_id, 
  fuel_flow_period_cd = EXCLUDED.fuel_flow_period_cd, 
  long_term_fuel_flow_value = EXCLUDED.long_term_fuel_flow_value, 
  ltff_uom_cd = EXCLUDED.ltff_uom_cd, 
  gross_calorific_value = EXCLUDED.gross_calorific_value, 
  gcv_uom_cd = EXCLUDED.gcv_uom_cd, 
  total_heat_input = EXCLUDED.total_heat_input, 
  calc_total_heat_input = EXCLUDED.calc_total_heat_input, 
  userid = EXCLUDED.userid, 
  add_date = EXCLUDED.add_date, 
  update_date = EXCLUDED.update_date;
-- Upsert into camdecmps.daily_test_summary
INSERT INTO camdecmps.daily_test_summary (
  daily_test_sum_id, rpt_period_id, 
  mon_loc_id, component_id, daily_test_date, 
  daily_test_hour, daily_test_min, 
  test_type_cd, test_result_cd, calc_test_result_cd, 
  userid, add_date, update_date, span_scale_cd, 
  mon_sys_id
) 
SELECT 
  daily_test_sum_id, 
  rpt_period_id, 
  mon_loc_id, 
  component_id, 
  daily_test_date, 
  daily_test_hour, 
  daily_test_min, 
  test_type_cd, 
  test_result_cd, 
  calc_test_result_cd, 
  userid, 
  add_date, 
  update_date, 
  span_scale_cd, 
  mon_sys_id 
FROM 
  camdecmpswks.daily_test_summary dts 
WHERE 
  mon_loc_id = ANY(monLocIds) 
  AND rpt_period_id = rptPeriodId ON CONFLICT (daily_test_sum_id) DO 
UPDATE 
SET 
  rpt_period_id = EXCLUDED.rpt_period_id, 
  mon_loc_id = EXCLUDED.mon_loc_id, 
  component_id = EXCLUDED.component_id, 
  daily_test_date = EXCLUDED.daily_test_date, 
  daily_test_hour = EXCLUDED.daily_test_hour, 
  daily_test_min = EXCLUDED.daily_test_min, 
  test_type_cd = EXCLUDED.test_type_cd, 
  test_result_cd = EXCLUDED.test_result_cd, 
  calc_test_result_cd = EXCLUDED.calc_test_result_cd, 
  userid = EXCLUDED.userid, 
  add_date = EXCLUDED.add_date, 
  update_date = EXCLUDED.update_date, 
  span_scale_cd = EXCLUDED.span_scale_cd, 
  mon_sys_id = EXCLUDED.mon_sys_id;
-- Upsert into camdecmps.daily_calibration
INSERT INTO camdecmps.daily_calibration (
  cal_inj_id, daily_test_sum_id, online_offline_ind, 
  calc_online_offline_ind, upscale_gas_level_cd, 
  zero_injection_date, zero_injection_hour, 
  zero_injection_min, upscale_injection_date, 
  upscale_injection_hour, upscale_injection_min, 
  zero_measured_value, upscale_measured_value, 
  zero_aps_ind, calc_zero_aps_ind, 
  upscale_aps_ind, calc_upscale_aps_ind, 
  zero_cal_error, calc_zero_cal_error, 
  upscale_cal_error, calc_upscale_cal_error, 
  zero_ref_value, upscale_ref_value, 
  userid, add_date, update_date, rpt_period_id, 
  upscale_gas_type_cd, vendor_id, 
  cylinder_identifier, expiration_date, 
  injection_protocol_cd
) 
SELECT 
  cal_inj_id, 
  dc.daily_test_sum_id, 
  online_offline_ind, 
  calc_online_offline_ind, 
  upscale_gas_level_cd, 
  zero_injection_date, 
  zero_injection_hour, 
  zero_injection_min, 
  upscale_injection_date, 
  upscale_injection_hour, 
  upscale_injection_min, 
  zero_measured_value, 
  upscale_measured_value, 
  zero_aps_ind, 
  calc_zero_aps_ind, 
  upscale_aps_ind, 
  calc_upscale_aps_ind, 
  zero_cal_error, 
  calc_zero_cal_error, 
  upscale_cal_error, 
  calc_upscale_cal_error, 
  zero_ref_value, 
  upscale_ref_value, 
  dc.userid, 
  dc.add_date, 
  dc.update_date, 
  dc.rpt_period_id, 
  upscale_gas_type_cd, 
  vendor_id, 
  cylinder_identifier, 
  expiration_date, 
  injection_protocol_cd 
FROM 
  camdecmpswks.daily_calibration dc 
  JOIN camdecmpswks.daily_test_summary dts ON dc.daily_test_sum_id = dts.daily_test_sum_id 
WHERE 
  dts.mon_loc_id = ANY(monLocIds) 
  AND dc.rpt_period_id = rptPeriodId ON CONFLICT (cal_inj_id) DO 
UPDATE 
SET 
  daily_test_sum_id = EXCLUDED.daily_test_sum_id, 
  online_offline_ind = EXCLUDED.online_offline_ind, 
  calc_online_offline_ind = EXCLUDED.calc_online_offline_ind, 
  upscale_gas_level_cd = EXCLUDED.upscale_gas_level_cd, 
  zero_injection_date = EXCLUDED.zero_injection_date, 
  zero_injection_hour = EXCLUDED.zero_injection_hour, 
  zero_injection_min = EXCLUDED.zero_injection_min, 
  upscale_injection_date = EXCLUDED.upscale_injection_date, 
  upscale_injection_hour = EXCLUDED.upscale_injection_hour, 
  upscale_injection_min = EXCLUDED.upscale_injection_min, 
  zero_measured_value = EXCLUDED.zero_measured_value, 
  upscale_measured_value = EXCLUDED.upscale_measured_value, 
  zero_aps_ind = EXCLUDED.zero_aps_ind, 
  calc_zero_aps_ind = EXCLUDED.calc_zero_aps_ind, 
  upscale_aps_ind = EXCLUDED.upscale_aps_ind, 
  calc_upscale_aps_ind = EXCLUDED.calc_upscale_aps_ind, 
  zero_cal_error = EXCLUDED.zero_cal_error, 
  calc_zero_cal_error = EXCLUDED.calc_zero_cal_error, 
  upscale_cal_error = EXCLUDED.upscale_cal_error, 
  calc_upscale_cal_error = EXCLUDED.calc_upscale_cal_error, 
  zero_ref_value = EXCLUDED.zero_ref_value, 
  upscale_ref_value = EXCLUDED.upscale_ref_value, 
  userid = EXCLUDED.userid, 
  add_date = EXCLUDED.add_date, 
  update_date = EXCLUDED.update_date, 
  rpt_period_id = EXCLUDED.rpt_period_id, 
  upscale_gas_type_cd = EXCLUDED.upscale_gas_type_cd, 
  vendor_id = EXCLUDED.vendor_id, 
  cylinder_identifier = EXCLUDED.cylinder_identifier, 
  expiration_date = EXCLUDED.expiration_date, 
  injection_protocol_cd = EXCLUDED.injection_protocol_cd;
-- Upsert into camdecmps.weekly_test_summary
INSERT INTO camdecmps.weekly_test_summary (
  weekly_test_sum_id, rpt_period_id, 
  mon_loc_id, mon_sys_id, component_id, 
  test_date, test_hour, test_min, test_type_cd, 
  test_result_cd, span_scale_cd, calc_test_result_cd, 
  userid, add_date, update_date
) 
SELECT 
  weekly_test_sum_id, 
  rpt_period_id, 
  mon_loc_id, 
  mon_sys_id, 
  component_id, 
  test_date, 
  test_hour, 
  test_min, 
  test_type_cd, 
  test_result_cd, 
  span_scale_cd, 
  calc_test_result_cd, 
  userid, 
  add_date, 
  update_date 
FROM 
  camdecmpswks.weekly_test_summary 
WHERE 
  mon_loc_id = ANY(monLocIds) 
  AND rpt_period_id = rptPeriodId ON CONFLICT (weekly_test_sum_id) DO 
UPDATE 
SET 
  rpt_period_id = EXCLUDED.rpt_period_id, 
  mon_loc_id = EXCLUDED.mon_loc_id, 
  mon_sys_id = EXCLUDED.mon_sys_id, 
  component_id = EXCLUDED.component_id, 
  test_date = EXCLUDED.test_date, 
  test_hour = EXCLUDED.test_hour, 
  test_min = EXCLUDED.test_min, 
  test_type_cd = EXCLUDED.test_type_cd, 
  test_result_cd = EXCLUDED.test_result_cd, 
  span_scale_cd = EXCLUDED.span_scale_cd, 
  calc_test_result_cd = EXCLUDED.calc_test_result_cd, 
  userid = EXCLUDED.userid, 
  add_date = EXCLUDED.add_date, 
  update_date = EXCLUDED.update_date;
-- Upsert into camdecmps.weekly_system_integrity
INSERT INTO camdecmps.weekly_system_integrity (
  weekly_sys_integrity_id, weekly_test_sum_id, 
  gas_level_cd, ref_value, measured_value, 
  system_integrity_error, aps_ind, 
  calc_system_integrity_error, calc_aps_ind, 
  userid, add_date, update_date, rpt_period_id, 
  mon_loc_id
) 
SELECT 
  weekly_sys_integrity_id, 
  wsi.weekly_test_sum_id, 
  gas_level_cd, 
  ref_value, 
  measured_value, 
  system_integrity_error, 
  aps_ind, 
  calc_system_integrity_error, 
  calc_aps_ind, 
  wsi.userid, 
  wsi.add_date, 
  wsi.update_date, 
  wsi.rpt_period_id, 
  wsi.mon_loc_id 
FROM 
  camdecmpswks.weekly_system_integrity wsi 
WHERE 
  wsi.mon_loc_id = ANY(monLocIds) 
  AND wsi.rpt_period_id = rptPeriodId ON CONFLICT (weekly_sys_integrity_id) DO 
UPDATE 
SET 
  weekly_test_sum_id = EXCLUDED.weekly_test_sum_id, 
  gas_level_cd = EXCLUDED.gas_level_cd, 
  ref_value = EXCLUDED.ref_value, 
  measured_value = EXCLUDED.measured_value, 
  system_integrity_error = EXCLUDED.system_integrity_error, 
  aps_ind = EXCLUDED.aps_ind, 
  calc_system_integrity_error = EXCLUDED.calc_system_integrity_error, 
  calc_aps_ind = EXCLUDED.calc_aps_ind, 
  userid = EXCLUDED.userid, 
  add_date = EXCLUDED.add_date, 
  update_date = EXCLUDED.update_date, 
  rpt_period_id = EXCLUDED.rpt_period_id, 
  mon_loc_id = EXCLUDED.mon_loc_id;
-- Upsert into camdecmps.weekly_test_summary
INSERT INTO camdecmps.weekly_test_summary (
  weekly_test_sum_id, rpt_period_id, 
  mon_loc_id, mon_sys_id, component_id, 
  test_date, test_hour, test_min, test_type_cd, 
  test_result_cd, span_scale_cd, calc_test_result_cd, 
  userid, add_date, update_date
) 
SELECT 
  weekly_test_sum_id, 
  rpt_period_id, 
  mon_loc_id, 
  mon_sys_id, 
  component_id, 
  test_date, 
  test_hour, 
  test_min, 
  test_type_cd, 
  test_result_cd, 
  span_scale_cd, 
  calc_test_result_cd, 
  userid, 
  add_date, 
  update_date 
FROM 
  camdecmpswks.weekly_test_summary 
WHERE 
  mon_loc_id = ANY(monLocIds) 
  AND rpt_period_id = rptPeriodId ON CONFLICT (weekly_test_sum_id) DO 
UPDATE 
SET 
  rpt_period_id = EXCLUDED.rpt_period_id, 
  mon_loc_id = EXCLUDED.mon_loc_id, 
  mon_sys_id = EXCLUDED.mon_sys_id, 
  component_id = EXCLUDED.component_id, 
  test_date = EXCLUDED.test_date, 
  test_hour = EXCLUDED.test_hour, 
  test_min = EXCLUDED.test_min, 
  test_type_cd = EXCLUDED.test_type_cd, 
  test_result_cd = EXCLUDED.test_result_cd, 
  span_scale_cd = EXCLUDED.span_scale_cd, 
  calc_test_result_cd = EXCLUDED.calc_test_result_cd, 
  userid = EXCLUDED.userid, 
  add_date = EXCLUDED.add_date, 
  update_date = EXCLUDED.update_date;
-- Upsert into camdecmps.weekly_system_integrity
INSERT INTO camdecmps.weekly_system_integrity (
  weekly_sys_integrity_id, weekly_test_sum_id, 
  gas_level_cd, ref_value, measured_value, 
  system_integrity_error, aps_ind, 
  calc_system_integrity_error, calc_aps_ind, 
  userid, add_date, update_date, rpt_period_id, 
  mon_loc_id
) 
SELECT 
  weekly_sys_integrity_id, 
  wsi.weekly_test_sum_id, 
  gas_level_cd, 
  ref_value, 
  measured_value, 
  system_integrity_error, 
  aps_ind, 
  calc_system_integrity_error, 
  calc_aps_ind, 
  wsi.userid, 
  wsi.add_date, 
  wsi.update_date, 
  wsi.rpt_period_id, 
  wsi.mon_loc_id 
FROM 
  camdecmpswks.weekly_system_integrity wsi 
WHERE 
  wsi.mon_loc_id = ANY(monLocIds) 
  AND wsi.rpt_period_id = rptPeriodId ON CONFLICT (weekly_sys_integrity_id) DO 
UPDATE 
SET 
  weekly_test_sum_id = EXCLUDED.weekly_test_sum_id, 
  gas_level_cd = EXCLUDED.gas_level_cd, 
  ref_value = EXCLUDED.ref_value, 
  measured_value = EXCLUDED.measured_value, 
  system_integrity_error = EXCLUDED.system_integrity_error, 
  aps_ind = EXCLUDED.aps_ind, 
  calc_system_integrity_error = EXCLUDED.calc_system_integrity_error, 
  calc_aps_ind = EXCLUDED.calc_aps_ind, 
  userid = EXCLUDED.userid, 
  add_date = EXCLUDED.add_date, 
  update_date = EXCLUDED.update_date, 
  rpt_period_id = EXCLUDED.rpt_period_id, 
  mon_loc_id = EXCLUDED.mon_loc_id;
-- Upsert into camdecmps.hrly_op_data
INSERT INTO camdecmps.hrly_op_data (
  hour_id, rpt_period_id, mon_loc_id, 
  begin_date, begin_hour, op_time, 
  hr_load, load_range, common_stack_load_range, 
  fc_factor, fd_factor, fw_factor, 
  fuel_cd, multi_fuel_flg, userid, 
  add_date, update_date, load_uom_cd, 
  operating_condition_cd, fuel_cd_list, 
  mhhi_indicator, mats_load, mats_startup_shutdown_flg
) 
SELECT 
  hour_id, 
  rpt_period_id, 
  mon_loc_id, 
  begin_date, 
  begin_hour, 
  op_time, 
  hr_load, 
  load_range, 
  common_stack_load_range, 
  fc_factor, 
  fd_factor, 
  fw_factor, 
  fuel_cd, 
  multi_fuel_flg, 
  userid, 
  add_date, 
  update_date, 
  load_uom_cd, 
  operating_condition_cd, 
  fuel_cd_list, 
  mhhi_indicator, 
  mats_load, 
  mats_startup_shutdown_flg 
FROM 
  camdecmpswks.hrly_op_data 
WHERE 
  mon_loc_id = ANY(monLocIds) 
  AND rpt_period_id = rptPeriodId ON CONFLICT (hour_id) DO 
UPDATE 
SET 
  rpt_period_id = EXCLUDED.rpt_period_id, 
  mon_loc_id = EXCLUDED.mon_loc_id, 
  begin_date = EXCLUDED.begin_date, 
  begin_hour = EXCLUDED.begin_hour, 
  op_time = EXCLUDED.op_time, 
  hr_load = EXCLUDED.hr_load, 
  load_range = EXCLUDED.load_range, 
  common_stack_load_range = EXCLUDED.common_stack_load_range, 
  fc_factor = EXCLUDED.fc_factor, 
  fd_factor = EXCLUDED.fd_factor, 
  fw_factor = EXCLUDED.fw_factor, 
  fuel_cd = EXCLUDED.fuel_cd, 
  multi_fuel_flg = EXCLUDED.multi_fuel_flg, 
  userid = EXCLUDED.userid, 
  add_date = EXCLUDED.add_date, 
  update_date = EXCLUDED.update_date, 
  load_uom_cd = EXCLUDED.load_uom_cd, 
  operating_condition_cd = EXCLUDED.operating_condition_cd, 
  fuel_cd_list = EXCLUDED.fuel_cd_list, 
  mhhi_indicator = EXCLUDED.mhhi_indicator, 
  mats_load = EXCLUDED.mats_load, 
  mats_startup_shutdown_flg = EXCLUDED.mats_startup_shutdown_flg;
-- Upsert into camdecmps.monitor_hrly_value
INSERT INTO camdecmps.monitor_hrly_value (
  monitor_hrly_val_id, hour_id, mon_sys_id, 
  component_id, parameter_cd, applicable_bias_adj_factor, 
  unadjusted_hrly_value, adjusted_hrly_value, 
  calc_adjusted_hrly_value, modc_cd, 
  pct_available, moisture_basis, userid, 
  add_date, update_date, calc_line_status, 
  calc_rata_status, calc_daycal_status, 
  rpt_period_id, mon_loc_id, calc_leak_status, 
  calc_dayint_status, calc_f2l_status
) 
SELECT 
  monitor_hrly_val_id, 
  mhv.hour_id, 
  mon_sys_id, 
  component_id, 
  parameter_cd, 
  applicable_bias_adj_factor, 
  unadjusted_hrly_value, 
  adjusted_hrly_value, 
  calc_adjusted_hrly_value, 
  modc_cd, 
  pct_available, 
  moisture_basis, 
  mhv.userid, 
  mhv.add_date, 
  mhv.update_date, 
  calc_line_status, 
  calc_rata_status, 
  calc_daycal_status, 
  mhv.rpt_period_id, 
  mhv.mon_loc_id, 
  calc_leak_status, 
  calc_dayint_status, 
  calc_f2l_status 
FROM 
  camdecmpswks.monitor_hrly_value mhv 
WHERE 
  mhv.mon_loc_id = ANY(monLocIds) 
  AND mhv.rpt_period_id = rptPeriodId ON CONFLICT (monitor_hrly_val_id) DO 
UPDATE 
SET 
  hour_id = EXCLUDED.hour_id, 
  mon_sys_id = EXCLUDED.mon_sys_id, 
  component_id = EXCLUDED.component_id, 
  parameter_cd = EXCLUDED.parameter_cd, 
  applicable_bias_adj_factor = EXCLUDED.applicable_bias_adj_factor, 
  unadjusted_hrly_value = EXCLUDED.unadjusted_hrly_value, 
  adjusted_hrly_value = EXCLUDED.adjusted_hrly_value, 
  calc_adjusted_hrly_value = EXCLUDED.calc_adjusted_hrly_value, 
  modc_cd = EXCLUDED.modc_cd, 
  pct_available = EXCLUDED.pct_available, 
  moisture_basis = EXCLUDED.moisture_basis, 
  userid = EXCLUDED.userid, 
  add_date = EXCLUDED.add_date, 
  update_date = EXCLUDED.update_date, 
  calc_line_status = EXCLUDED.calc_line_status, 
  calc_rata_status = EXCLUDED.calc_rata_status, 
  calc_daycal_status = EXCLUDED.calc_daycal_status, 
  rpt_period_id = EXCLUDED.rpt_period_id, 
  mon_loc_id = EXCLUDED.mon_loc_id, 
  calc_leak_status = EXCLUDED.calc_leak_status, 
  calc_dayint_status = EXCLUDED.calc_dayint_status, 
  calc_f2l_status = EXCLUDED.calc_f2l_status;
-- Upsert into camdecmps.mats_monitor_hrly_value
INSERT INTO camdecmps.mats_monitor_hrly_value (
  mats_mhv_id, hour_id, mon_loc_id, 
  rpt_period_id, parameter_cd, mon_sys_id, 
  component_id, unadjusted_hrly_value, 
  modc_cd, pct_available, calc_unadjusted_hrly_value, 
  calc_daily_cal_status, calc_hg_line_status, 
  calc_hgi1_status, calc_rata_status, 
  userid, add_date, update_date
) 
SELECT 
  mats_mhv_id, 
  mmhv.hour_id, 
  mmhv.mon_loc_id, 
  mmhv.rpt_period_id, 
  parameter_cd, 
  mon_sys_id, 
  component_id, 
  unadjusted_hrly_value, 
  modc_cd, 
  pct_available, 
  calc_unadjusted_hrly_value, 
  calc_daily_cal_status, 
  calc_hg_line_status, 
  calc_hgi1_status, 
  calc_rata_status, 
  mmhv.userid, 
  mmhv.add_date, 
  mmhv.update_date 
FROM 
  camdecmpswks.mats_monitor_hrly_value mmhv 
WHERE 
  mmhv.mon_loc_id = ANY(monLocIds) 
  AND mmhv.rpt_period_id = rptPeriodId ON CONFLICT (mats_mhv_id) DO 
UPDATE 
SET 
  hour_id = EXCLUDED.hour_id, 
  mon_loc_id = EXCLUDED.mon_loc_id, 
  rpt_period_id = EXCLUDED.rpt_period_id, 
  parameter_cd = EXCLUDED.parameter_cd, 
  mon_sys_id = EXCLUDED.mon_sys_id, 
  component_id = EXCLUDED.component_id, 
  unadjusted_hrly_value = EXCLUDED.unadjusted_hrly_value, 
  modc_cd = EXCLUDED.modc_cd, 
  pct_available = EXCLUDED.pct_available, 
  calc_unadjusted_hrly_value = EXCLUDED.calc_unadjusted_hrly_value, 
  calc_daily_cal_status = EXCLUDED.calc_daily_cal_status, 
  calc_hg_line_status = EXCLUDED.calc_hg_line_status, 
  calc_hgi1_status = EXCLUDED.calc_hgi1_status, 
  calc_rata_status = EXCLUDED.calc_rata_status, 
  userid = EXCLUDED.userid, 
  add_date = EXCLUDED.add_date, 
  update_date = EXCLUDED.update_date;
-- Upsert into camdecmps.derived_hrly_value
INSERT INTO camdecmps.derived_hrly_value (
  derv_id, hour_id, mon_sys_id, mon_form_id, 
  parameter_cd, unadjusted_hrly_value, 
  applicable_bias_adj_factor, calc_unadjusted_hrly_value, 
  adjusted_hrly_value, calc_adjusted_hrly_value, 
  modc_cd, operating_condition_cd, 
  pct_available, diluent_cap_ind, 
  segment_num, fuel_cd, userid, add_date, 
  update_date, calc_pct_diluent, calc_pct_moisture, 
  calc_rata_status, calc_appe_status, 
  rpt_period_id, mon_loc_id, calc_fuel_flow_total, 
  calc_hour_measure_cd
) 
SELECT 
  derv_id, 
  dhv.hour_id, 
  mon_sys_id, 
  mon_form_id, 
  parameter_cd, 
  unadjusted_hrly_value, 
  applicable_bias_adj_factor, 
  calc_unadjusted_hrly_value, 
  adjusted_hrly_value, 
  calc_adjusted_hrly_value, 
  modc_cd, 
  dhv.operating_condition_cd, 
  pct_available, 
  diluent_cap_ind, 
  segment_num, 
  dhv.fuel_cd, 
  dhv.userid, 
  dhv.add_date, 
  dhv.update_date, 
  calc_pct_diluent, 
  calc_pct_moisture, 
  calc_rata_status, 
  calc_appe_status, 
  dhv.rpt_period_id, 
  dhv.mon_loc_id, 
  calc_fuel_flow_total, 
  calc_hour_measure_cd 
FROM 
  camdecmpswks.derived_hrly_value dhv 
WHERE 
  dhv.mon_loc_id = ANY(monLocIds) 
  AND dhv.rpt_period_id = rptPeriodId ON CONFLICT (derv_id) DO 
UPDATE 
SET 
  hour_id = EXCLUDED.hour_id, 
  mon_sys_id = EXCLUDED.mon_sys_id, 
  mon_form_id = EXCLUDED.mon_form_id, 
  parameter_cd = EXCLUDED.parameter_cd, 
  unadjusted_hrly_value = EXCLUDED.unadjusted_hrly_value, 
  applicable_bias_adj_factor = EXCLUDED.applicable_bias_adj_factor, 
  calc_unadjusted_hrly_value = EXCLUDED.calc_unadjusted_hrly_value, 
  adjusted_hrly_value = EXCLUDED.adjusted_hrly_value, 
  calc_adjusted_hrly_value = EXCLUDED.calc_adjusted_hrly_value, 
  modc_cd = EXCLUDED.modc_cd, 
  operating_condition_cd = EXCLUDED.operating_condition_cd, 
  pct_available = EXCLUDED.pct_available, 
  diluent_cap_ind = EXCLUDED.diluent_cap_ind, 
  segment_num = EXCLUDED.segment_num, 
  fuel_cd = EXCLUDED.fuel_cd, 
  userid = EXCLUDED.userid, 
  add_date = EXCLUDED.add_date, 
  update_date = EXCLUDED.update_date, 
  calc_pct_diluent = EXCLUDED.calc_pct_diluent, 
  calc_pct_moisture = EXCLUDED.calc_pct_moisture, 
  calc_rata_status = EXCLUDED.calc_rata_status, 
  calc_appe_status = EXCLUDED.calc_appe_status, 
  rpt_period_id = EXCLUDED.rpt_period_id, 
  mon_loc_id = EXCLUDED.mon_loc_id, 
  calc_fuel_flow_total = EXCLUDED.calc_fuel_flow_total, 
  calc_hour_measure_cd = EXCLUDED.calc_hour_measure_cd;
-- Upsert into camdecmps.mats_derived_hrly_value
INSERT INTO camdecmps.mats_derived_hrly_value (
  mats_dhv_id, hour_id, parameter_cd, 
  unadjusted_hrly_value, modc_cd, 
  mon_form_id, calc_unadjusted_hrly_value, 
  calc_pct_diluent, calc_pct_moisture, 
  mon_loc_id, rpt_period_id, userid, 
  add_date, update_date
) 
SELECT 
  mats_dhv_id, 
  mdhv.hour_id, 
  parameter_cd, 
  unadjusted_hrly_value, 
  modc_cd, 
  mon_form_id, 
  calc_unadjusted_hrly_value, 
  calc_pct_diluent, 
  calc_pct_moisture, 
  mdhv.mon_loc_id, 
  mdhv.rpt_period_id, 
  mdhv.userid, 
  mdhv.add_date, 
  mdhv.update_date 
FROM 
  camdecmpswks.mats_derived_hrly_value mdhv 
WHERE 
  mdhv.mon_loc_id = ANY(monLocIds) 
  AND mdhv.rpt_period_id = rptPeriodId ON CONFLICT (mats_dhv_id) DO 
UPDATE 
SET 
  hour_id = EXCLUDED.hour_id, 
  parameter_cd = EXCLUDED.parameter_cd, 
  unadjusted_hrly_value = EXCLUDED.unadjusted_hrly_value, 
  modc_cd = EXCLUDED.modc_cd, 
  mon_form_id = EXCLUDED.mon_form_id, 
  calc_unadjusted_hrly_value = EXCLUDED.calc_unadjusted_hrly_value, 
  calc_pct_diluent = EXCLUDED.calc_pct_diluent, 
  calc_pct_moisture = EXCLUDED.calc_pct_moisture, 
  mon_loc_id = EXCLUDED.mon_loc_id, 
  rpt_period_id = EXCLUDED.rpt_period_id, 
  userid = EXCLUDED.userid, 
  add_date = EXCLUDED.add_date, 
  update_date = EXCLUDED.update_date;
-- Upsert into camdecmps.hrly_fuel_flow
INSERT INTO camdecmps.hrly_fuel_flow (
  hrly_fuel_flow_id, hour_id, mon_sys_id, 
  fuel_cd, fuel_usage_time, volumetric_flow_rate, 
  sod_volumetric_cd, mass_flow_rate, 
  calc_mass_flow_rate, sod_mass_cd, 
  userid, add_date, update_date, volumetric_uom_cd, 
  calc_volumetric_flow_rate, calc_appd_status, 
  rpt_period_id, mon_loc_id
) 
SELECT 
  hrly_fuel_flow_id, 
  hff.hour_id, 
  mon_sys_id, 
  hff.fuel_cd, 
  fuel_usage_time, 
  volumetric_flow_rate, 
  sod_volumetric_cd, 
  mass_flow_rate, 
  calc_mass_flow_rate, 
  sod_mass_cd, 
  hff.userid, 
  hff.add_date, 
  hff.update_date, 
  volumetric_uom_cd, 
  calc_volumetric_flow_rate, 
  calc_appd_status, 
  hff.rpt_period_id, 
  hff.mon_loc_id 
FROM 
  camdecmpswks.hrly_fuel_flow hff 
WHERE 
  hff.mon_loc_id = ANY(monLocIds) 
  AND hff.rpt_period_id = rptPeriodId ON CONFLICT (hrly_fuel_flow_id) DO 
UPDATE 
SET 
  hour_id = EXCLUDED.hour_id, 
  mon_sys_id = EXCLUDED.mon_sys_id, 
  fuel_cd = EXCLUDED.fuel_cd, 
  fuel_usage_time = EXCLUDED.fuel_usage_time, 
  volumetric_flow_rate = EXCLUDED.volumetric_flow_rate, 
  sod_volumetric_cd = EXCLUDED.sod_volumetric_cd, 
  mass_flow_rate = EXCLUDED.mass_flow_rate, 
  calc_mass_flow_rate = EXCLUDED.calc_mass_flow_rate, 
  sod_mass_cd = EXCLUDED.sod_mass_cd, 
  userid = EXCLUDED.userid, 
  add_date = EXCLUDED.add_date, 
  update_date = EXCLUDED.update_date, 
  volumetric_uom_cd = EXCLUDED.volumetric_uom_cd, 
  calc_volumetric_flow_rate = EXCLUDED.calc_volumetric_flow_rate, 
  calc_appd_status = EXCLUDED.calc_appd_status, 
  rpt_period_id = EXCLUDED.rpt_period_id, 
  mon_loc_id = EXCLUDED.mon_loc_id;
-- Upsert into camdecmps.hrly_gas_flow_meter
INSERT INTO camdecmps.hrly_gas_flow_meter (
  hrly_gas_flow_meter_id, hour_id, 
  mon_loc_id, rpt_period_id, component_id, 
  begin_end_hour_flg, gfm_reading, 
  avg_sampling_rate, sampling_rate_uom, 
  flow_to_sampling_ratio, calc_flow_to_sampling_ratio, 
  calc_flow_to_sampling_mult, userid, 
  add_date, update_date
) 
SELECT 
  hrly_gas_flow_meter_id, 
  hgfm.hour_id, 
  hgfm.mon_loc_id, 
  hgfm.rpt_period_id, 
  component_id, 
  begin_end_hour_flg, 
  gfm_reading, 
  avg_sampling_rate, 
  sampling_rate_uom, 
  flow_to_sampling_ratio, 
  calc_flow_to_sampling_ratio, 
  calc_flow_to_sampling_mult, 
  hgfm.userid, 
  hgfm.add_date, 
  hgfm.update_date 
FROM 
  camdecmpswks.hrly_gas_flow_meter hgfm 
WHERE 
  hgfm.mon_loc_id = ANY(monLocIds) 
  AND hgfm.rpt_period_id = rptPeriodId ON CONFLICT (hrly_gas_flow_meter_id) DO 
UPDATE 
SET 
  hour_id = EXCLUDED.hour_id, 
  mon_loc_id = EXCLUDED.mon_loc_id, 
  rpt_period_id = EXCLUDED.rpt_period_id, 
  component_id = EXCLUDED.component_id, 
  begin_end_hour_flg = EXCLUDED.begin_end_hour_flg, 
  gfm_reading = EXCLUDED.gfm_reading, 
  avg_sampling_rate = EXCLUDED.avg_sampling_rate, 
  sampling_rate_uom = EXCLUDED.sampling_rate_uom, 
  flow_to_sampling_ratio = EXCLUDED.flow_to_sampling_ratio, 
  calc_flow_to_sampling_ratio = EXCLUDED.calc_flow_to_sampling_ratio, 
  calc_flow_to_sampling_mult = EXCLUDED.calc_flow_to_sampling_mult, 
  userid = EXCLUDED.userid, 
  add_date = EXCLUDED.add_date, 
  update_date = EXCLUDED.update_date;
-- Upsert into camdecmps.hrly_param_fuel_flow
INSERT INTO camdecmps.hrly_param_fuel_flow (
  hrly_param_ff_id, hrly_fuel_flow_id, 
  mon_sys_id, mon_form_id, parameter_cd, 
  param_val_fuel, calc_param_val_fuel, 
  sample_type_cd, operating_condition_cd, 
  segment_num, userid, add_date, update_date, 
  parameter_uom_cd, calc_appe_status, 
  rpt_period_id, mon_loc_id
) 
SELECT 
  hrly_param_ff_id, 
  hpff.hrly_fuel_flow_id, 
  hpff.mon_sys_id, 
  mon_form_id, 
  parameter_cd, 
  param_val_fuel, 
  calc_param_val_fuel, 
  sample_type_cd, 
  hpff.operating_condition_cd, 
  segment_num, 
  hpff.userid, 
  hpff.add_date, 
  hpff.update_date, 
  parameter_uom_cd, 
  calc_appe_status, 
  hpff.rpt_period_id, 
  hpff.mon_loc_id 
FROM 
  camdecmpswks.hrly_param_fuel_flow hpff 
WHERE 
  hpff.mon_loc_id = ANY(monLocIds) 
  AND hpff.rpt_period_id = rptPeriodId ON CONFLICT (hrly_param_ff_id) DO 
UPDATE 
SET 
  hrly_fuel_flow_id = EXCLUDED.hrly_fuel_flow_id, 
  mon_sys_id = EXCLUDED.mon_sys_id, 
  mon_form_id = EXCLUDED.mon_form_id, 
  parameter_cd = EXCLUDED.parameter_cd, 
  param_val_fuel = EXCLUDED.param_val_fuel, 
  calc_param_val_fuel = EXCLUDED.calc_param_val_fuel, 
  sample_type_cd = EXCLUDED.sample_type_cd, 
  operating_condition_cd = EXCLUDED.operating_condition_cd, 
  segment_num = EXCLUDED.segment_num, 
  userid = EXCLUDED.userid, 
  add_date = EXCLUDED.add_date, 
  update_date = EXCLUDED.update_date, 
  parameter_uom_cd = EXCLUDED.parameter_uom_cd, 
  calc_appe_status = EXCLUDED.calc_appe_status, 
  rpt_period_id = EXCLUDED.rpt_period_id, 
  mon_loc_id = EXCLUDED.mon_loc_id;
-- Upsert into camdecmps.sorbent_trap
INSERT INTO camdecmps.sorbent_trap (
  trap_id, mon_loc_id, rpt_period_id, 
  begin_date, begin_hour, end_date, 
  end_hour, mon_sys_id, paired_trap_agreement, 
  absolute_difference_ind, modc_cd, 
  hg_concentration, calc_paired_trap_agreement, 
  calc_modc_cd, calc_hg_concentration, 
  userid, add_date, update_date, sorbent_trap_aps_cd, 
  rata_ind
) 
SELECT 
  trap_id, 
  mon_loc_id, 
  rpt_period_id, 
  begin_date, 
  begin_hour, 
  end_date, 
  end_hour, 
  mon_sys_id, 
  paired_trap_agreement, 
  absolute_difference_ind, 
  modc_cd, 
  hg_concentration, 
  calc_paired_trap_agreement, 
  calc_modc_cd, 
  calc_hg_concentration, 
  userid, 
  add_date, 
  update_date, 
  sorbent_trap_aps_cd, 
  rata_ind 
FROM 
  camdecmpswks.sorbent_trap 
WHERE 
  mon_loc_id = ANY(monLocIds) 
  AND rpt_period_id = rptPeriodId ON CONFLICT (trap_id) DO 
UPDATE 
SET 
  mon_loc_id = EXCLUDED.mon_loc_id, 
  begin_date = EXCLUDED.begin_date, 
  begin_hour = EXCLUDED.begin_hour, 
  end_date = EXCLUDED.end_date, 
  end_hour = EXCLUDED.end_hour, 
  mon_sys_id = EXCLUDED.mon_sys_id, 
  paired_trap_agreement = EXCLUDED.paired_trap_agreement, 
  absolute_difference_ind = EXCLUDED.absolute_difference_ind, 
  modc_cd = EXCLUDED.modc_cd, 
  hg_concentration = EXCLUDED.hg_concentration, 
  calc_paired_trap_agreement = EXCLUDED.calc_paired_trap_agreement, 
  calc_modc_cd = EXCLUDED.calc_modc_cd, 
  calc_hg_concentration = EXCLUDED.calc_hg_concentration, 
  userid = EXCLUDED.userid, 
  add_date = EXCLUDED.add_date, 
  update_date = EXCLUDED.update_date, 
  sorbent_trap_aps_cd = EXCLUDED.sorbent_trap_aps_cd, 
  rata_ind = EXCLUDED.rata_ind;
-- Upsert into camdecmps.sampling_train
INSERT INTO camdecmps.sampling_train (
  trap_train_id, trap_id, mon_loc_id, 
  rpt_period_id, component_id, sorbent_trap_serial_number, 
  main_trap_hg, breakthrough_trap_hg, 
  spike_trap_hg, spike_ref_value, 
  total_sample_volume, ref_flow_to_sampling_ratio, 
  hg_concentration, percent_breakthrough, 
  percent_spike_recovery, sampling_ratio_test_result_cd, 
  post_leak_test_result_cd, train_qa_status_cd, 
  sample_damage_explanation, calc_hg_concentration, 
  calc_percent_breakthrough, calc_percent_spike_recovery, 
  userid, add_date, update_date
) 
SELECT 
  trap_train_id, 
  smpt.trap_id, 
  smpt.mon_loc_id, 
  smpt.rpt_period_id, 
  component_id, 
  sorbent_trap_serial_number, 
  main_trap_hg, 
  breakthrough_trap_hg, 
  spike_trap_hg, 
  spike_ref_value, 
  total_sample_volume, 
  ref_flow_to_sampling_ratio, 
  smpt.hg_concentration, 
  percent_breakthrough, 
  percent_spike_recovery, 
  sampling_ratio_test_result_cd, 
  post_leak_test_result_cd, 
  train_qa_status_cd, 
  sample_damage_explanation, 
  smpt.calc_hg_concentration, 
  calc_percent_breakthrough, 
  calc_percent_spike_recovery, 
  smpt.userid, 
  smpt.add_date, 
  smpt.update_date 
FROM 
  camdecmpswks.sampling_train smpt 
WHERE 
  smpt.mon_loc_id = ANY(monLocIds) 
  AND smpt.rpt_period_id = rptPeriodId ON CONFLICT (trap_train_id) DO 
UPDATE 
SET 
  trap_id = EXCLUDED.trap_id, 
  mon_loc_id = EXCLUDED.mon_loc_id, 
  rpt_period_id = EXCLUDED.rpt_period_id, 
  component_id = EXCLUDED.component_id, 
  sorbent_trap_serial_number = EXCLUDED.sorbent_trap_serial_number, 
  main_trap_hg = EXCLUDED.main_trap_hg, 
  breakthrough_trap_hg = EXCLUDED.breakthrough_trap_hg, 
  spike_trap_hg = EXCLUDED.spike_trap_hg, 
  spike_ref_value = EXCLUDED.spike_ref_value, 
  total_sample_volume = EXCLUDED.total_sample_volume, 
  ref_flow_to_sampling_ratio = EXCLUDED.ref_flow_to_sampling_ratio, 
  hg_concentration = EXCLUDED.hg_concentration, 
  percent_breakthrough = EXCLUDED.percent_breakthrough, 
  percent_spike_recovery = EXCLUDED.percent_spike_recovery, 
  sampling_ratio_test_result_cd = EXCLUDED.sampling_ratio_test_result_cd, 
  post_leak_test_result_cd = EXCLUDED.post_leak_test_result_cd, 
  train_qa_status_cd = EXCLUDED.train_qa_status_cd, 
  sample_damage_explanation = EXCLUDED.sample_damage_explanation, 
  calc_hg_concentration = EXCLUDED.calc_hg_concentration, 
  calc_percent_breakthrough = EXCLUDED.calc_percent_breakthrough, 
  calc_percent_spike_recovery = EXCLUDED.calc_percent_spike_recovery, 
  userid = EXCLUDED.userid, 
  add_date = EXCLUDED.add_date, 
  update_date = EXCLUDED.update_date;
-- Upsert into camdecmps.nsps4t_summary
INSERT INTO camdecmps.nsps4t_summary (
  nsps4t_sum_id, emission_standard_cd, 
  modus_value, modus_uom_cd, electrical_load_cd, 
  no_period_ended_ind, no_period_ended_comment, 
  mon_loc_id, rpt_period_id, userid, 
  add_date, update_date
) 
SELECT 
  nsps4t_sum_id, 
  emission_standard_cd, 
  modus_value, 
  modus_uom_cd, 
  electrical_load_cd, 
  no_period_ended_ind, 
  no_period_ended_comment, 
  mon_loc_id, 
  rpt_period_id, 
  userid, 
  add_date, 
  update_date 
FROM 
  camdecmpswks.nsps4t_summary 
WHERE 
  mon_loc_id = ANY(monLocIds) 
  AND rpt_period_id = rptPeriodId ON CONFLICT (nsps4t_sum_id) DO 
UPDATE 
SET 
  emission_standard_cd = EXCLUDED.emission_standard_cd, 
  modus_value = EXCLUDED.modus_value, 
  modus_uom_cd = EXCLUDED.modus_uom_cd, 
  electrical_load_cd = EXCLUDED.electrical_load_cd, 
  no_period_ended_ind = EXCLUDED.no_period_ended_ind, 
  no_period_ended_comment = EXCLUDED.no_period_ended_comment, 
  mon_loc_id = EXCLUDED.mon_loc_id, 
  rpt_period_id = EXCLUDED.rpt_period_id, 
  userid = EXCLUDED.userid, 
  add_date = EXCLUDED.add_date, 
  update_date = EXCLUDED.update_date;
-- Upsert into camdecmps.nsps4t_annual
INSERT INTO camdecmps.nsps4t_annual (
  nsps4t_ann_id, nsps4t_sum_id, annual_energy_sold, 
  annual_energy_sold_type_cd, annual_potential_output, 
  mon_loc_id, rpt_period_id, userid, 
  add_date, update_date
) 
SELECT 
  nsps4t_ann_id, 
  q4ta.nsps4t_sum_id, 
  annual_energy_sold, 
  annual_energy_sold_type_cd, 
  annual_potential_output, 
  q4ta.mon_loc_id, 
  q4ta.rpt_period_id, 
  q4ta.userid, 
  q4ta.add_date, 
  q4ta.update_date 
FROM 
  camdecmpswks.nsps4t_annual q4ta 
WHERE 
  q4ta.mon_loc_id = ANY(monLocIds) 
  AND q4ta.rpt_period_id = rptPeriodId ON CONFLICT (nsps4t_ann_id) DO 
UPDATE 
SET 
  nsps4t_sum_id = EXCLUDED.nsps4t_sum_id, 
  annual_energy_sold = EXCLUDED.annual_energy_sold, 
  annual_energy_sold_type_cd = EXCLUDED.annual_energy_sold_type_cd, 
  annual_potential_output = EXCLUDED.annual_potential_output, 
  mon_loc_id = EXCLUDED.mon_loc_id, 
  rpt_period_id = EXCLUDED.rpt_period_id, 
  userid = EXCLUDED.userid, 
  add_date = EXCLUDED.add_date, 
  update_date = EXCLUDED.update_date;
-- Upsert into camdecmps.nsps4t_compliance_period
INSERT INTO camdecmps.nsps4t_compliance_period (
  nsps4t_cmp_id, nsps4t_sum_id, begin_year, 
  begin_month, end_year, end_month, 
  avg_co2_emission_rate, co2_emission_rate_uom_cd, 
  pct_valid_op_hours, co2_violation_ind, 
  co2_violation_comment, mon_loc_id, 
  rpt_period_id, userid, add_date, 
  update_date
) 
SELECT 
  nsps4t_cmp_id, 
  q4tcp.nsps4t_sum_id, 
  begin_year, 
  begin_month, 
  end_year, 
  end_month, 
  avg_co2_emission_rate, 
  co2_emission_rate_uom_cd, 
  pct_valid_op_hours, 
  co2_violation_ind, 
  co2_violation_comment, 
  q4tcp.mon_loc_id, 
  q4tcp.rpt_period_id, 
  q4tcp.userid, 
  q4tcp.add_date, 
  q4tcp.update_date 
FROM 
  camdecmpswks.nsps4t_compliance_period q4tcp 
WHERE 
  q4tcp.mon_loc_id = ANY(monLocIds) 
  AND q4tcp.rpt_period_id = rptPeriodId ON CONFLICT (nsps4t_cmp_id) DO 
UPDATE 
SET 
  nsps4t_sum_id = EXCLUDED.nsps4t_sum_id, 
  begin_year = EXCLUDED.begin_year, 
  begin_month = EXCLUDED.begin_month, 
  end_year = EXCLUDED.end_year, 
  end_month = EXCLUDED.end_month, 
  avg_co2_emission_rate = EXCLUDED.avg_co2_emission_rate, 
  co2_emission_rate_uom_cd = EXCLUDED.co2_emission_rate_uom_cd, 
  pct_valid_op_hours = EXCLUDED.pct_valid_op_hours, 
  co2_violation_ind = EXCLUDED.co2_violation_ind, 
  co2_violation_comment = EXCLUDED.co2_violation_comment, 
  mon_loc_id = EXCLUDED.mon_loc_id, 
  rpt_period_id = EXCLUDED.rpt_period_id, 
  userid = EXCLUDED.userid, 
  add_date = EXCLUDED.add_date, 
  update_date = EXCLUDED.update_date;
------------------------------------------------------------------------------------------------------------
-- SUPP DATA --
------------------------------------------------------------------------------------------------------------
-- Upsert into camdecmps.component_op_supp_data
INSERT INTO camdecmps.component_op_supp_data (
  comp_op_supp_data_id, component_id, 
  rpt_period_id, op_supp_data_type_cd, 
  days, hours, mon_loc_id, delete_ind, 
  userid, add_date, update_date
) 
SELECT 
  comp_op_supp_data_id, 
  component_id, 
  rpt_period_id, 
  op_supp_data_type_cd, 
  days, 
  hours, 
  mon_loc_id, 
  delete_ind, 
  userid, 
  add_date, 
  update_date 
FROM 
  camdecmpswks.component_op_supp_data 
WHERE 
  mon_loc_id = ANY(monLocIds) 
  AND rpt_period_id = rptPeriodId ON CONFLICT (comp_op_supp_data_id) DO 
UPDATE 
SET 
  component_id = EXCLUDED.component_id, 
  rpt_period_id = EXCLUDED.rpt_period_id, 
  op_supp_data_type_cd = EXCLUDED.op_supp_data_type_cd, 
  days = EXCLUDED.days, 
  hours = EXCLUDED.hours, 
  mon_loc_id = EXCLUDED.mon_loc_id, 
  delete_ind = EXCLUDED.delete_ind, 
  userid = EXCLUDED.userid, 
  add_date = EXCLUDED.add_date, 
  update_date = EXCLUDED.update_date;
-- Upsert into camdecmps.daily_test_supp_data
INSERT INTO camdecmps.daily_test_supp_data (
  daily_test_supp_data_id, component_id, 
  rpt_period_id, test_type_cd, span_scale_cd, 
  key_online_ind, key_valid_ind, op_hour_cnt, 
  last_covered_nonop_datehour, first_op_after_nonop_datehour, 
  daily_test_datehourmin, test_result_cd, 
  online_offline_ind, sort_daily_test_datehourmin, 
  daily_test_sum_id, calc_test_result_cd, 
  mon_loc_id, delete_ind, userid, add_date, 
  update_date
) 
SELECT 
  daily_test_supp_data_id, 
  component_id, 
  rpt_period_id, 
  test_type_cd, 
  span_scale_cd, 
  key_online_ind, 
  key_valid_ind, 
  op_hour_cnt, 
  last_covered_nonop_datehour, 
  first_op_after_nonop_datehour, 
  daily_test_datehourmin, 
  test_result_cd, 
  online_offline_ind, 
  sort_daily_test_datehourmin, 
  daily_test_sum_id, 
  calc_test_result_cd, 
  mon_loc_id, 
  delete_ind, 
  userid, 
  add_date, 
  update_date 
FROM 
  camdecmpswks.daily_test_supp_data 
WHERE 
  mon_loc_id = ANY(monLocIds) 
  AND rpt_period_id = rptPeriodId ON CONFLICT (daily_test_supp_data_id) DO 
UPDATE 
SET 
  component_id = EXCLUDED.component_id, 
  rpt_period_id = EXCLUDED.rpt_period_id, 
  test_type_cd = EXCLUDED.test_type_cd, 
  span_scale_cd = EXCLUDED.span_scale_cd, 
  key_online_ind = EXCLUDED.key_online_ind, 
  key_valid_ind = EXCLUDED.key_valid_ind, 
  op_hour_cnt = EXCLUDED.op_hour_cnt, 
  last_covered_nonop_datehour = EXCLUDED.last_covered_nonop_datehour, 
  first_op_after_nonop_datehour = EXCLUDED.first_op_after_nonop_datehour, 
  daily_test_datehourmin = EXCLUDED.daily_test_datehourmin, 
  test_result_cd = EXCLUDED.test_result_cd, 
  online_offline_ind = EXCLUDED.online_offline_ind, 
  sort_daily_test_datehourmin = EXCLUDED.sort_daily_test_datehourmin, 
  daily_test_sum_id = EXCLUDED.daily_test_sum_id, 
  calc_test_result_cd = EXCLUDED.calc_test_result_cd, 
  mon_loc_id = EXCLUDED.mon_loc_id, 
  delete_ind = EXCLUDED.delete_ind, 
  userid = EXCLUDED.userid, 
  add_date = EXCLUDED.add_date, 
  update_date = EXCLUDED.update_date;
-- Upsert into camdecmps.daily_test_system_supp_data
INSERT INTO camdecmps.daily_test_system_supp_data (
  daily_test_system_supp_data_id, 
  daily_test_supp_data_id, mon_sys_id, 
  op_hour_cnt, last_covered_nonop_datehour, 
  first_op_after_nonop_datehour, 
  mon_loc_id, rpt_period_id, userid, 
  add_date, update_date
) 
SELECT 
  daily_test_system_supp_data_id, 
  daily_test_supp_data_id, 
  mon_sys_id, 
  op_hour_cnt, 
  last_covered_nonop_datehour, 
  first_op_after_nonop_datehour, 
  mon_loc_id, 
  rpt_period_id, 
  userid, 
  add_date, 
  update_date 
FROM 
  camdecmpswks.daily_test_system_supp_data 
WHERE 
  mon_loc_id = ANY(monLocIds) 
  AND rpt_period_id = rptPeriodId ON CONFLICT (daily_test_system_supp_data_id) DO 
UPDATE 
SET 
  daily_test_supp_data_id = EXCLUDED.daily_test_supp_data_id, 
  mon_sys_id = EXCLUDED.mon_sys_id, 
  op_hour_cnt = EXCLUDED.op_hour_cnt, 
  last_covered_nonop_datehour = EXCLUDED.last_covered_nonop_datehour, 
  first_op_after_nonop_datehour = EXCLUDED.first_op_after_nonop_datehour, 
  mon_loc_id = EXCLUDED.mon_loc_id, 
  rpt_period_id = EXCLUDED.rpt_period_id, 
  userid = EXCLUDED.userid, 
  add_date = EXCLUDED.add_date, 
  update_date = EXCLUDED.update_date;
-- Upsert into camdecmps.last_qa_value_supp_data
INSERT INTO camdecmps.last_qa_value_supp_data (
  last_qa_value_supp_data_id, mon_loc_id, 
  rpt_period_id, parameter_cd, moisture_basis, 
  hourly_type_cd, mon_sys_id, component_id, 
  op_datehour, unadjusted_hrly_value, 
  adjusted_hrly_value, delete_ind, 
  userid, add_date, update_date
) 
SELECT 
  last_qa_value_supp_data_id, 
  mon_loc_id, 
  rpt_period_id, 
  parameter_cd, 
  moisture_basis, 
  hourly_type_cd, 
  mon_sys_id, 
  component_id, 
  op_datehour, 
  unadjusted_hrly_value, 
  adjusted_hrly_value, 
  delete_ind, 
  userid, 
  add_date, 
  update_date 
FROM 
  camdecmpswks.last_qa_value_supp_data 
WHERE 
  mon_loc_id = ANY(monLocIds) 
  AND rpt_period_id = rptPeriodId ON CONFLICT (last_qa_value_supp_data_id) DO 
UPDATE 
SET 
  mon_loc_id = EXCLUDED.mon_loc_id, 
  rpt_period_id = EXCLUDED.rpt_period_id, 
  parameter_cd = EXCLUDED.parameter_cd, 
  moisture_basis = EXCLUDED.moisture_basis, 
  hourly_type_cd = EXCLUDED.hourly_type_cd, 
  mon_sys_id = EXCLUDED.mon_sys_id, 
  component_id = EXCLUDED.component_id, 
  op_datehour = EXCLUDED.op_datehour, 
  unadjusted_hrly_value = EXCLUDED.unadjusted_hrly_value, 
  adjusted_hrly_value = EXCLUDED.adjusted_hrly_value, 
  delete_ind = EXCLUDED.delete_ind, 
  userid = EXCLUDED.userid, 
  add_date = EXCLUDED.add_date, 
  update_date = EXCLUDED.update_date;
-- Upsert into camdecmps.operating_supp_data
INSERT INTO camdecmps.operating_supp_data (
  op_supp_data_id, mon_loc_id, fuel_cd, 
  op_type_cd, rpt_period_id, op_value, 
  userid, add_date, update_date
) 
SELECT 
  op_supp_data_id, 
  mon_loc_id, 
  fuel_cd, 
  op_type_cd, 
  rpt_period_id, 
  op_value, 
  userid, 
  add_date, 
  update_date 
FROM 
  camdecmpswks.operating_supp_data 
WHERE 
  mon_loc_id = ANY(monLocIds) 
  AND rpt_period_id = rptPeriodId ON CONFLICT (op_supp_data_id) DO 
UPDATE 
SET 
  mon_loc_id = EXCLUDED.mon_loc_id, 
  fuel_cd = EXCLUDED.fuel_cd, 
  op_type_cd = EXCLUDED.op_type_cd, 
  rpt_period_id = EXCLUDED.rpt_period_id, 
  op_value = EXCLUDED.op_value, 
  userid = EXCLUDED.userid, 
  add_date = EXCLUDED.add_date, 
  update_date = EXCLUDED.update_date;
-- Upsert into camdecmps.sorbent_trap_supp_data
INSERT INTO camdecmps.sorbent_trap_supp_data (
  trap_id, mon_sys_id, begin_date, begin_hour, 
  end_date, end_hour, modc_cd, hg_concentration, 
  mon_loc_id, rpt_period_id, userid, 
  add_date, update_date, delete_ind, 
  sorbent_trap_aps_cd, rata_ind
) 
SELECT 
  trap_id, 
  mon_sys_id, 
  begin_date, 
  begin_hour, 
  end_date, 
  end_hour, 
  modc_cd, 
  hg_concentration, 
  mon_loc_id, 
  rpt_period_id, 
  userid, 
  add_date, 
  update_date, 
  delete_ind, 
  sorbent_trap_aps_cd, 
  rata_ind 
FROM 
  camdecmpswks.sorbent_trap_supp_data 
WHERE 
  mon_loc_id = ANY(monLocIds) 
  AND rpt_period_id = rptPeriodId ON CONFLICT (trap_id) DO 
UPDATE 
SET 
  mon_sys_id = EXCLUDED.mon_sys_id, 
  begin_date = EXCLUDED.begin_date, 
  begin_hour = EXCLUDED.begin_hour, 
  end_date = EXCLUDED.end_date, 
  end_hour = EXCLUDED.end_hour, 
  modc_cd = EXCLUDED.modc_cd, 
  hg_concentration = EXCLUDED.hg_concentration, 
  mon_loc_id = EXCLUDED.mon_loc_id, 
  userid = EXCLUDED.userid, 
  add_date = EXCLUDED.add_date, 
  update_date = EXCLUDED.update_date, 
  delete_ind = EXCLUDED.delete_ind, 
  sorbent_trap_aps_cd = EXCLUDED.sorbent_trap_aps_cd, 
  rata_ind = EXCLUDED.rata_ind;
/* LOAD AFTER PARENT TABLE sorbent_trap_supp_data */
-- Upsert into camdecmps.sampling_train_supp_data
INSERT INTO camdecmps.sampling_train_supp_data (
  trap_train_id, trap_id, component_id, 
  train_qa_status_cd, ref_flow_to_sampling_ratio, 
  hg_concentration, sfsr_total_count, 
  sfsr_deviated_count, gfm_total_count, 
  gfm_not_available_count, mon_loc_id, 
  rpt_period_id, userid, add_date, 
  update_date, sampling_ratio_test_result_cd
) 
SELECT 
  trap_train_id, 
  trap_id, 
  component_id, 
  train_qa_status_cd, 
  ref_flow_to_sampling_ratio, 
  hg_concentration, 
  sfsr_total_count, 
  sfsr_deviated_count, 
  gfm_total_count, 
  gfm_not_available_count, 
  mon_loc_id, 
  rpt_period_id, 
  userid, 
  add_date, 
  update_date, 
  sampling_ratio_test_result_cd 
FROM 
  camdecmpswks.sampling_train_supp_data 
WHERE 
  mon_loc_id = ANY(monLocIds) 
  AND rpt_period_id = rptPeriodId ON CONFLICT (trap_train_id) DO 
UPDATE 
SET 
  trap_id = EXCLUDED.trap_id, 
  component_id = EXCLUDED.component_id, 
  train_qa_status_cd = EXCLUDED.train_qa_status_cd, 
  ref_flow_to_sampling_ratio = EXCLUDED.ref_flow_to_sampling_ratio, 
  hg_concentration = EXCLUDED.hg_concentration, 
  sfsr_total_count = EXCLUDED.sfsr_total_count, 
  sfsr_deviated_count = EXCLUDED.sfsr_deviated_count, 
  gfm_total_count = EXCLUDED.gfm_total_count, 
  gfm_not_available_count = EXCLUDED.gfm_not_available_count, 
  mon_loc_id = EXCLUDED.mon_loc_id, 
  rpt_period_id = EXCLUDED.rpt_period_id, 
  userid = EXCLUDED.userid, 
  add_date = EXCLUDED.add_date, 
  update_date = EXCLUDED.update_date, 
  sampling_ratio_test_result_cd = EXCLUDED.sampling_ratio_test_result_cd;
-- Upsert into camdecmps.system_op_supp_data
INSERT INTO camdecmps.system_op_supp_data (
  sys_op_supp_data_id, mon_sys_id, 
  rpt_period_id, op_supp_data_type_cd, 
  days, hours, mon_loc_id, delete_ind, 
  userid, add_date, update_date
) 
SELECT 
  sys_op_supp_data_id, 
  mon_sys_id, 
  rpt_period_id, 
  op_supp_data_type_cd, 
  days, 
  hours, 
  mon_loc_id, 
  delete_ind, 
  userid, 
  add_date, 
  update_date 
FROM 
  camdecmpswks.system_op_supp_data 
WHERE 
  mon_loc_id = ANY(monLocIds) 
  AND rpt_period_id = rptPeriodId ON CONFLICT (sys_op_supp_data_id) DO 
UPDATE 
SET 
  mon_sys_id = EXCLUDED.mon_sys_id, 
  rpt_period_id = EXCLUDED.rpt_period_id, 
  op_supp_data_type_cd = EXCLUDED.op_supp_data_type_cd, 
  days = EXCLUDED.days, 
  hours = EXCLUDED.hours, 
  mon_loc_id = EXCLUDED.mon_loc_id, 
  delete_ind = EXCLUDED.delete_ind, 
  userid = EXCLUDED.userid, 
  add_date = EXCLUDED.add_date, 
  update_date = EXCLUDED.update_date;

<<<<<<< HEAD
  -- EMISSIONS VIEWS 
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
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId
  ON CONFLICT (mon_plan_id, mon_loc_id, rpt_period_id, date_hour) DO UPDATE SET
      hour_id = EXCLUDED.hour_id,
      op_time = EXCLUDED.op_time,
      unit_load = EXCLUDED.unit_load,
      load_uom = EXCLUDED.load_uom,
      hi_formula_cd = EXCLUDED.hi_formula_cd,
      rpt_hi_rate = EXCLUDED.rpt_hi_rate,
      calc_hi_rate = EXCLUDED.calc_hi_rate,
      so2_formula_cd = EXCLUDED.so2_formula_cd,
      rpt_so2_mass_rate = EXCLUDED.rpt_so2_mass_rate,
      calc_so2_mass_rate = EXCLUDED.calc_so2_mass_rate,
      nox_rate_formula_cd = EXCLUDED.nox_rate_formula_cd,
      rpt_adj_nox_rate = EXCLUDED.rpt_adj_nox_rate,
      calc_adj_nox_rate = EXCLUDED.calc_adj_nox_rate,
      nox_mass_formula_cd = EXCLUDED.nox_mass_formula_cd,
      rpt_nox_mass = EXCLUDED.rpt_nox_mass,
      calc_nox_mass = EXCLUDED.calc_nox_mass,
      co2_formula_cd = EXCLUDED.co2_formula_cd,
      rpt_co2_mass_rate = EXCLUDED.rpt_co2_mass_rate,
      calc_co2_mass_rate = EXCLUDED.calc_co2_mass_rate,
      error_codes = EXCLUDED.error_codes,
      adj_flow_used = EXCLUDED.adj_flow_used,
      rpt_adj_flow = EXCLUDED.rpt_adj_flow,
      unadj_flow = EXCLUDED.unadj_flow;

  -- EMISSIONS VIEWS 
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
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId
  ON CONFLICT (mon_plan_id, mon_loc_id, rpt_period_id, fuel_type, fuel_sys_id, date_hour) DO UPDATE SET
      op_time = EXCLUDED.op_time,
      unit_load = EXCLUDED.unit_load,
      load_uom = EXCLUDED.load_uom,
      calc_hi_rate = EXCLUDED.calc_hi_rate,
      fc_factor = EXCLUDED.fc_factor,
      formula_cd = EXCLUDED.formula_cd,
      rpt_co2_mass_rate = EXCLUDED.rpt_co2_mass_rate,
      calc_co2_mass_rate = EXCLUDED.calc_co2_mass_rate,
      summation_formula_cd = EXCLUDED.summation_formula_cd,
      rpt_co2_mass_rate_all_fuels = EXCLUDED.rpt_co2_mass_rate_all_fuels,
      calc_co2_mass_rate_all_fuels = EXCLUDED.calc_co2_mass_rate_all_fuels,
      error_codes = EXCLUDED.error_codes;

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
WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId
ON CONFLICT (mon_plan_id, mon_loc_id, rpt_period_id, date_hour) DO UPDATE SET
    op_time = EXCLUDED.op_time,
    co2c_modc = EXCLUDED.co2c_modc,
    co2c_pma = EXCLUDED.co2c_pma,
    rpt_pct_o2 = EXCLUDED.rpt_pct_o2,
    pct_o2_used = EXCLUDED.pct_o2_used,
    o2_modc = EXCLUDED.o2_modc,
    pct_h2o_used = EXCLUDED.pct_h2o_used,
    source_h2o_value = EXCLUDED.source_h2o_value,
    fc_factor = EXCLUDED.fc_factor,
    fd_factor = EXCLUDED.fd_factor,
    formula_cd = EXCLUDED.formula_cd,
    rpt_pct_co2 = EXCLUDED.rpt_pct_co2,
    calc_pct_co2 = EXCLUDED.calc_pct_co2,
    error_codes = EXCLUDED.error_codes;


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
WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId
ON CONFLICT (mon_plan_id, mon_loc_id, rpt_period_id, date_hour) DO UPDATE SET
    op_time = EXCLUDED.op_time,
    unit_load = EXCLUDED.unit_load,
    load_uom = EXCLUDED.load_uom,
    component_type = EXCLUDED.component_type,
    rpt_pct_co2 = EXCLUDED.rpt_pct_co2,
    pct_co2_used = EXCLUDED.pct_co2_used,
    co2_modc = EXCLUDED.co2_modc,
    co2_pma = EXCLUDED.co2_pma,
    unadj_flow = EXCLUDED.unadj_flow,
    calc_flow_baf = EXCLUDED.calc_flow_baf,
    rpt_adj_flow = EXCLUDED.rpt_adj_flow,
    adj_flow_used = EXCLUDED.adj_flow_used,
    flow_modc = EXCLUDED.flow_modc,
    flow_pma = EXCLUDED.flow_pma,
    pct_h2o_used = EXCLUDED.pct_h2o_used,
    source_h2o_value = EXCLUDED.source_h2o_value,
    co2_formula_cd = EXCLUDED.co2_formula_cd,
    rpt_co2_mass_rate = EXCLUDED.rpt_co2_mass_rate,
    calc_co2_mass_rate = EXCLUDED.calc_co2_mass_rate,
    error_codes = EXCLUDED.error_codes;


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
WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId
ON CONFLICT (mon_plan_id, mon_loc_id, rpt_period_id, fuel_cd, date) DO UPDATE SET
    rpt_total_daily_co2_mass = EXCLUDED.rpt_total_daily_co2_mass,
    rpt_unadjusted_co2_mass = EXCLUDED.rpt_unadjusted_co2_mass,
    rpt_adjusted_daily_co2_mass = EXCLUDED.rpt_adjusted_daily_co2_mass,
    rpt_sorbent_rltd_co2_mass = EXCLUDED.rpt_sorbent_rltd_co2_mass,
    error_codes = EXCLUDED.error_codes,
    fuel_cd = EXCLUDED.fuel_cd,
    daily_fuel_feed = EXCLUDED.daily_fuel_feed,
    carbon_content_used = EXCLUDED.carbon_content_used,
    fuel_carbon_burned = EXCLUDED.fuel_carbon_burned,
    calc_fuel_carbon_burned = EXCLUDED.calc_fuel_carbon_burned,
    total_carbon_burned = EXCLUDED.total_carbon_burned,
    calc_total_daily_emission = EXCLUDED.calc_total_daily_emission;


INSERT INTO camdecmps.emission_view_count (
    mon_plan_id, mon_loc_id, dataset_cd, rpt_period_id, count
)
SELECT 
    mon_plan_id, mon_loc_id, dataset_cd, rpt_period_id, count
FROM camdecmpswks.emission_view_count
WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId
ON CONFLICT (mon_plan_id, mon_loc_id, rpt_period_id, dataset_cd) DO UPDATE SET
    count = EXCLUDED.count;


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
WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId
ON CONFLICT (mon_plan_id, mon_loc_id, rpt_period_id, test_sum_id) DO UPDATE SET
    component_identifier = EXCLUDED.component_identifier,
    component_type_cd = EXCLUDED.component_type_cd,
    span_scale_cd = EXCLUDED.span_scale_cd,
    end_datetime = EXCLUDED.end_datetime,
    rpt_test_result_cd = EXCLUDED.rpt_test_result_cd,
    calc_test_result_cd = EXCLUDED.calc_test_result_cd,
    applicable_span_value = EXCLUDED.applicable_span_value,
    upscale_gas_level_cd = EXCLUDED.upscale_gas_level_cd,
    upscale_injection_date = EXCLUDED.upscale_injection_date,
    upscale_injection_time = EXCLUDED.upscale_injection_time,
    upscale_measured_value = EXCLUDED.upscale_measured_value,
    upscale_ref_value = EXCLUDED.upscale_ref_value,
    rpt_upscale_ce_or_mean_diff = EXCLUDED.rpt_upscale_ce_or_mean_diff,
    rpt_upscale_aps_ind = EXCLUDED.rpt_upscale_aps_ind,
    calc_upscale_ce_or_mean_diff = EXCLUDED.calc_upscale_ce_or_mean_diff,
    calc_upscale_aps_ind = EXCLUDED.calc_upscale_aps_ind,
    zero_injection_date = EXCLUDED.zero_injection_date,
    zero_injection_time = EXCLUDED.zero_injection_time,
    zero_measured_value = EXCLUDED.zero_measured_value,
    zero_ref_value = EXCLUDED.zero_ref_value,
    rpt_zero_ce_or_mean_diff = EXCLUDED.rpt_zero_ce_or_mean_diff,
    rpt_zero_aps_ind = EXCLUDED.rpt_zero_aps_ind,
    calc_zero_ce_or_mean_diff = EXCLUDED.calc_zero_ce_or_mean_diff,
    calc_zero_aps_ind = EXCLUDED.calc_zero_aps_ind,
    rpt_online_offline_ind = EXCLUDED.rpt_online_offline_ind,
    calc_online_offline_ind = EXCLUDED.calc_online_offline_ind,
    error_codes = EXCLUDED.error_codes,
    upscale_gas_type_cd = EXCLUDED.upscale_gas_type_cd,
    cylinder_id = EXCLUDED.cylinder_id,
    expiration_date = EXCLUDED.expiration_date,
    vendor_id = EXCLUDED.vendor_id;


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
WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId
ON CONFLICT (mon_plan_id, mon_loc_id, rpt_period_id, fuel_type, fuel_sys_id, date_hour) DO UPDATE SET
    op_time = EXCLUDED.op_time,
    fuel_use_time = EXCLUDED.fuel_use_time,
    unit_load = EXCLUDED.unit_load,
    load_uom = EXCLUDED.load_uom,
    rpt_fuel_flow = EXCLUDED.rpt_fuel_flow,
    calc_fuel_flow = EXCLUDED.calc_fuel_flow,
    fuel_flow_uom = EXCLUDED.fuel_flow_uom,
    fuel_flow_sodc = EXCLUDED.fuel_flow_sodc,
    gross_calorific_value = EXCLUDED.gross_calorific_value,
    gcv_uom = EXCLUDED.gcv_uom,
    gcv_sampling_type = EXCLUDED.gcv_sampling_type,
    formula_cd = EXCLUDED.formula_cd,
    rpt_hi_rate = EXCLUDED.rpt_hi_rate,
    calc_hi_rate = EXCLUDED.calc_hi_rate,
    error_codes = EXCLUDED.error_codes;

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
WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId
ON CONFLICT (mon_plan_id, mon_loc_id, rpt_period_id, date_hour) DO UPDATE SET
    hour_id = EXCLUDED.hour_id,
    op_time = EXCLUDED.op_time,
    unit_load = EXCLUDED.unit_load,
    load_uom = EXCLUDED.load_uom,
    load_range = EXCLUDED.load_range,
    common_stack_load_range = EXCLUDED.common_stack_load_range,
    hi_formula_cd = EXCLUDED.hi_formula_cd,
    hi_modc = EXCLUDED.hi_modc,
    rpt_hi_rate = EXCLUDED.rpt_hi_rate,
    calc_hi_rate = EXCLUDED.calc_hi_rate,
    diluent_param = EXCLUDED.diluent_param,
    rpt_pct_diluent = EXCLUDED.rpt_pct_diluent,
    pct_diluent_used = EXCLUDED.pct_diluent_used,
    diluent_modc = EXCLUDED.diluent_modc,
    diluent_pma = EXCLUDED.diluent_pma,
    unadj_flow = EXCLUDED.unadj_flow,
    calc_flow_baf = EXCLUDED.calc_flow_baf,
    rpt_adj_flow = EXCLUDED.rpt_adj_flow,
    adj_flow_used = EXCLUDED.adj_flow_used,
    flow_modc = EXCLUDED.flow_modc,
    flow_pma = EXCLUDED.flow_pma,
    pct_h2o_used = EXCLUDED.pct_h2o_used,
    source_h2o_value = EXCLUDED.source_h2o_value,
    f_factor = EXCLUDED.f_factor,
    error_codes = EXCLUDED.error_codes;

INSERT INTO camdecmps.emission_view_hiunitstack (
    mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, unit_load, load_uom, load_range,
    common_stack_load_range, hi_formula_cd, rpt_hi_rate, calc_hi_rate, error_codes
)
SELECT 
    mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, unit_load, load_uom, load_range,
    common_stack_load_range, hi_formula_cd, rpt_hi_rate, calc_hi_rate, error_codes
FROM camdecmpswks.emission_view_hiunitstack
WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId
ON CONFLICT (mon_plan_id, mon_loc_id, rpt_period_id, date_hour) DO UPDATE SET
    op_time = EXCLUDED.op_time,
    unit_load = EXCLUDED.unit_load,
    load_uom = EXCLUDED.load_uom,
    common_stack_load_range = EXCLUDED.common_stack_load_range,
    hi_formula_cd = EXCLUDED.hi_formula_cd,
    rpt_hi_rate = EXCLUDED.rpt_hi_rate,
    calc_hi_rate = EXCLUDED.calc_hi_rate,
    error_codes = EXCLUDED.error_codes;

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
WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId
ON CONFLICT (mon_plan_id, mon_loc_id, rpt_period_id, date_hour) DO UPDATE SET
    op_time = EXCLUDED.op_time,
    unit_load = EXCLUDED.unit_load,
    rpt_heat_input = EXCLUDED.rpt_heat_input,
    calc_heat_input = EXCLUDED.calc_heat_input,
    so2_emiss_rate = EXCLUDED.so2_emiss_rate,
    rpt_so2_mass = EXCLUDED.rpt_so2_mass,
    calc_so2_mass = EXCLUDED.calc_so2_mass,
    operating_condition_cd = EXCLUDED.operating_condition_cd,
    nox_emiss_rate = EXCLUDED.nox_emiss_rate,
    rpt_nox_mass = EXCLUDED.rpt_nox_mass,
    calc_nox_mass = EXCLUDED.calc_nox_mass,
    co2_emiss_rate = EXCLUDED.co2_emiss_rate,
    rpt_co2_mass = EXCLUDED.rpt_co2_mass,
    calc_co2_mass = EXCLUDED.calc_co2_mass,
    error_codes = EXCLUDED.error_codes;


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
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId
  ON CONFLICT (mon_plan_id, mon_loc_id, rpt_period_id, oil_type, fuel_sys_id, date_hour) DO UPDATE SET
      op_time = EXCLUDED.op_time,
      fuel_use_time = EXCLUDED.fuel_use_time,
      rpt_volumetric_oil_flow = EXCLUDED.rpt_volumetric_oil_flow,
      calc_volumetric_oil_flow = EXCLUDED.calc_volumetric_oil_flow,
      volumetric_oil_flow_uom = EXCLUDED.volumetric_oil_flow_uom,
      volumetric_oil_flow_sodc = EXCLUDED.volumetric_oil_flow_sodc,
      oil_density = EXCLUDED.oil_density,
      oil_density_uom = EXCLUDED.oil_density_uom,
      oil_density_sampling_type = EXCLUDED.oil_density_sampling_type,
      rpt_mass_oil_flow = EXCLUDED.rpt_mass_oil_flow,
      calc_mass_oil_flow = EXCLUDED.calc_mass_oil_flow,
      error_codes = EXCLUDED.error_codes;


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
WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId
ON CONFLICT (mon_plan_id, rpt_period_id) DO UPDATE SET
    date_hour = EXCLUDED.date_hour,
    op_time = EXCLUDED.op_time,
    mats_load = EXCLUDED.mats_load,
    mats_startup_shutdown = EXCLUDED.mats_startup_shutdown,
    hcl_conc_value = EXCLUDED.hcl_conc_value,
    hcl_conc_modc_cd = EXCLUDED.hcl_conc_modc_cd,
    hcl_conc_pma = EXCLUDED.hcl_conc_pma,
    flow_rate = EXCLUDED.flow_rate,
    flow_modc = EXCLUDED.flow_modc,
    flow_pma = EXCLUDED.flow_pma,
    rpt_pct_diluent = EXCLUDED.rpt_pct_diluent,
    diluent_parameter = EXCLUDED.diluent_parameter,
    calc_pct_diluent = EXCLUDED.calc_pct_diluent,
    diluent_modc = EXCLUDED.diluent_modc,
    calc_pct_h2o = EXCLUDED.calc_pct_h2o,
    h2o_source = EXCLUDED.h2o_source,
    f_factor = EXCLUDED.f_factor,
    rpt_hcl_rate = EXCLUDED.rpt_hcl_rate,
    hcl_uom = EXCLUDED.hcl_uom,
    hcl_modc_cd = EXCLUDED.hcl_modc_cd,
    error_codes = EXCLUDED.error_codes,
    calc_hcl_rate = EXCLUDED.calc_hcl_rate;

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
WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId
ON CONFLICT (mon_plan_id, rpt_period_id) DO UPDATE SET
    date_hour = EXCLUDED.date_hour,
    op_time = EXCLUDED.op_time,
    mats_load = EXCLUDED.mats_load,
    mats_startup_shutdown = EXCLUDED.mats_startup_shutdown,
    hf_conc_value = EXCLUDED.hf_conc_value,
    hf_conc_modc_cd = EXCLUDED.hf_conc_modc_cd,
    hf_conc_pma = EXCLUDED.hf_conc_pma,
    flow_rate = EXCLUDED.flow_rate,
    flow_modc = EXCLUDED.flow_modc,
    flow_pma = EXCLUDED.flow_pma,
    rpt_pct_diluent = EXCLUDED.rpt_pct_diluent,
    diluent_parameter = EXCLUDED.diluent_parameter,
    calc_pct_diluent = EXCLUDED.calc_pct_diluent,
    diluent_modc = EXCLUDED.diluent_modc,
    calc_pct_h2o = EXCLUDED.calc_pct_h2o,
    h2o_source = EXCLUDED.h2o_source,
    f_factor = EXCLUDED.f_factor,
    rpt_hf_rate = EXCLUDED.rpt_hf_rate,
    hf_uom = EXCLUDED.hf_uom,
    hf_modc_cd = EXCLUDED.hf_modc_cd,
    error_codes = EXCLUDED.error_codes,
    calc_hf_rate = EXCLUDED.calc_hf_rate;

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
WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId
ON CONFLICT (mon_plan_id, rpt_period_id) DO UPDATE SET
    date_hour = EXCLUDED.date_hour,
    op_time = EXCLUDED.op_time,
    mats_load = EXCLUDED.mats_load,
    mats_startup_shutdown = EXCLUDED.mats_startup_shutdown,
    hg_conc_value = EXCLUDED.hg_conc_value,
    hg_conc_system_id = EXCLUDED.hg_conc_system_id,
    hg_conc_sys_type = EXCLUDED.hg_conc_sys_type,
    hg_conc_modc_cd = EXCLUDED.hg_conc_modc_cd,
    hg_conc_pma = EXCLUDED.hg_conc_pma,
    sampling_train_comp_id1 = EXCLUDED.sampling_train_comp_id1,
    gas_flowmeter_reading1 = EXCLUDED.gas_flowmeter_reading1,
    ratio_stack_gas_flow_rate1 = EXCLUDED.ratio_stack_gas_flow_rate1,
    sampling_train_comp_id2 = EXCLUDED.sampling_train_comp_id2,
    gas_flowmeter_reading2 = EXCLUDED.gas_flowmeter_reading2,
    ratio_stack_gas_flow_rate2 = EXCLUDED.ratio_stack_gas_flow_rate2,
    flow_rate = EXCLUDED.flow_rate,
    flow_modc = EXCLUDED.flow_modc,
    flow_pma = EXCLUDED.flow_pma,
    rpt_pct_diluent = EXCLUDED.rpt_pct_diluent,
    diluent_parameter = EXCLUDED.diluent_parameter,
    calc_pct_diluent = EXCLUDED.calc_pct_diluent,
    diluent_modc = EXCLUDED.diluent_modc,
    calc_pct_h2o = EXCLUDED.calc_pct_h2o,
    h2o_source = EXCLUDED.h2o_source,
    f_factor = EXCLUDED.f_factor,
    rpt_hg_rate = EXCLUDED.rpt_hg_rate,
    hg_uom = EXCLUDED.hg_uom,
    hg_modc_cd = EXCLUDED.hg_modc_cd,
    error_codes = EXCLUDED.error_codes,
    calc_hg_rate = EXCLUDED.calc_hg_rate;

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
WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId
ON CONFLICT (mon_plan_id, rpt_period_id) DO UPDATE SET
    date_hour = EXCLUDED.date_hour,
    op_time = EXCLUDED.op_time,
    mats_load = EXCLUDED.mats_load,
    mats_startup_shutdown = EXCLUDED.mats_startup_shutdown,
    so2_conc_value = EXCLUDED.so2_conc_value,
    so2_conc_modc_cd = EXCLUDED.so2_conc_modc_cd,
    so2_conc_pma = EXCLUDED.so2_conc_pma,
    flow_rate = EXCLUDED.flow_rate,
    flow_modc = EXCLUDED.flow_modc,
    flow_pma = EXCLUDED.flow_pma,
    rpt_pct_diluent = EXCLUDED.rpt_pct_diluent,
    diluent_parameter = EXCLUDED.diluent_parameter,
    calc_pct_diluent = EXCLUDED.calc_pct_diluent,
    diluent_modc = EXCLUDED.diluent_modc,
    calc_pct_h2o = EXCLUDED.calc_pct_h2o,
    h2o_source = EXCLUDED.h2o_source,
    f_factor = EXCLUDED.f_factor,
    rpt_so2_rate = EXCLUDED.rpt_so2_rate,
    so2_uom = EXCLUDED.so2_uom,
    so2_modc_cd = EXCLUDED.so2_modc_cd,
    error_codes = EXCLUDED.error_codes,
    calc_so2_rate = EXCLUDED.calc_so2_rate;


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
WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId
ON CONFLICT (mon_plan_id, rpt_period_id) DO UPDATE SET
    system_identifier = EXCLUDED.system_identifier,
    date_hour = EXCLUDED.date_hour,
    end_date_time = EXCLUDED.end_date_time,
    paired_trap_agreement = EXCLUDED.paired_trap_agreement,
    absolute_difference_ind = EXCLUDED.absolute_difference_ind,
    modc_cd = EXCLUDED.modc_cd,
    hg_concentration = EXCLUDED.hg_concentration,
    a_component_id = EXCLUDED.a_component_id,
    a_sorbent_trap_serial_number = EXCLUDED.a_sorbent_trap_serial_number,
    a_main_trap_hg = EXCLUDED.a_main_trap_hg,
    a_breakthrough_trap_hg = EXCLUDED.a_breakthrough_trap_hg,
    a_spike_trap_hg = EXCLUDED.a_spike_trap_hg,
    a_spike_ref_value = EXCLUDED.a_spike_ref_value,
    a_total_sample_volume = EXCLUDED.a_total_sample_volume,
    a_ref_flow_to_sampling_ratio = EXCLUDED.a_ref_flow_to_sampling_ratio,
    a_hg_concentration = EXCLUDED.a_hg_concentration,
    a_percent_breakthrough = EXCLUDED.a_percent_breakthrough,
    a_percent_spike_recovery = EXCLUDED.a_percent_spike_recovery,
    a_sampling_ratio_test_result_cd = EXCLUDED.a_sampling_ratio_test_result_cd,
    a_post_leak_test_result_cd = EXCLUDED.a_post_leak_test_result_cd,
    a_train_qa_status_cd = EXCLUDED.a_train_qa_status_cd,
    a_sample_damage_explanation = EXCLUDED.a_sample_damage_explanation,
    b_component_id = EXCLUDED.b_component_id,
    b_sorbent_trap_serial_number = EXCLUDED.b_sorbent_trap_serial_number,
    b_main_trap_hg = EXCLUDED.b_main_trap_hg,
    b_breakthrough_trap_hg = EXCLUDED.b_breakthrough_trap_hg,
    b_spike_trap_hg = EXCLUDED.b_spike_trap_hg,
    b_spike_ref_value = EXCLUDED.b_spike_ref_value,
    b_total_sample_volume = EXCLUDED.b_total_sample_volume,
    b_ref_flow_to_sampling_ratio = EXCLUDED.b_ref_flow_to_sampling_ratio,
    b_hg_concentration = EXCLUDED.b_hg_concentration,
    b_percent_breakthrough = EXCLUDED.b_percent_breakthrough,
    b_percent_spike_recovery = EXCLUDED.b_percent_spike_recovery,
    b_sampling_ratio_test_result_cd = EXCLUDED.b_sampling_ratio_test_result_cd,
    b_post_leak_test_result_cd = EXCLUDED.b_post_leak_test_result_cd,
    b_train_qa_status_cd = EXCLUDED.b_train_qa_status_cd,
    b_sample_damage_explanation = EXCLUDED.b_sample_damage_explanation,
    error_codes = EXCLUDED.error_codes,
    sorbent_trap_aps_cd = EXCLUDED.sorbent_trap_aps_cd,
    rata_ind = EXCLUDED.rata_ind;


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
WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId
ON CONFLICT (mon_plan_id, rpt_period_id) DO UPDATE
    SET
    weekly_test_sum_id = EXCLUDED.weekly_test_sum_id,
    system_component_identifier = EXCLUDED.system_component_identifier,
    weekly_test_sum_id = EXCLUDED.weekly_test_sum_id,
    system_component_type = EXCLUDED.system_component_type,
    date_hour = EXCLUDED.date_hour,
    test_type = EXCLUDED.test_type,
    test_result = EXCLUDED.test_result,
    span_scale = EXCLUDED.span_scale,
    gas_level = EXCLUDED.gas_level,
    ref_value = EXCLUDED.ref_value,
    measured_value = EXCLUDED.measured_value,
    system_integrity_error = EXCLUDED.system_integrity_error,
    error_codes = EXCLUDED.error_codes;

  INSERT INTO camdecmps.emission_view_moisture (
    mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, h2o_modc, h2o_pma, pct_o2_wet, o2_wet_modc,
    pct_o2_dry, o2_dry_modc, h2o_formula_cd, rpt_pct_h2o, calc_pct_h2o, error_codes
)
SELECT 
    mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, h2o_modc, h2o_pma, pct_o2_wet, o2_wet_modc,
    pct_o2_dry, o2_dry_modc, h2o_formula_cd, rpt_pct_h2o, calc_pct_h2o, error_codes
FROM camdecmpswks.emission_view_moisture
WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId
ON CONFLICT (mon_plan_id, rpt_period_id) DO UPDATE
    SET
    date_hour = EXCLUDED.date_hour,
    op_time = EXCLUDED.op_time,
    h2o_modc = EXCLUDED.h2o_modc,
    h2o_pma = EXCLUDED.h2o_pma,
    pct_o2_wet = EXCLUDED.pct_o2_wet,
    o2_wet_modc = EXCLUDED.o2_wet_modc,
    pct_o2_dry = EXCLUDED.pct_o2_dry,
    o2_dry_modc = EXCLUDED.o2_dry_modc,
    h2o_formula_cd = EXCLUDED.h2o_formula_cd,
    rpt_pct_h2o = EXCLUDED.rpt_pct_h2o,
    calc_pct_h2o = EXCLUDED.calc_pct_h2o,
    error_codes = EXCLUDED.error_codes;

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
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId
  ON CONFLICT (mon_plan_id, rpt_period_id) DO UPDATE
      SET
      date_hour = EXCLUDED.date_hour,
      op_time = EXCLUDED.op_time,
      system_id = EXCLUDED.system_id,
      unit_load = EXCLUDED.unit_load,
      load_uom = EXCLUDED.load_uom,
      calc_hi_rate = EXCLUDED.calc_hi_rate,
      operating_condition_cd = EXCLUDED.operating_condition_cd,
      segment_number = EXCLUDED.segment_number,
      rpt_nox_emission_rate = EXCLUDED.rpt_nox_emission_rate,
      calc_nox_emission_rate = EXCLUDED.calc_nox_emission_rate,
      nox_mass_rate_formula_cd = EXCLUDED.nox_mass_rate_formula_cd,
      rpt_nox_mass_rate = EXCLUDED.rpt_nox_mass_rate,
      calc_nox_mass_rate = EXCLUDED.calc_nox_mass_rate,
      error_codes = EXCLUDED.error_codes;


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
WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId
ON CONFLICT (mon_plan_id, rpt_period_id) DO UPDATE
    SET
    date_hour = EXCLUDED.date_hour,
    op_time = EXCLUDED.op_time,
    fuel_sys_id = EXCLUDED.fuel_sys_id,
    fuel_type = EXCLUDED.fuel_type,
    fuel_use_time = EXCLUDED.fuel_use_time,
    unit_load = EXCLUDED.unit_load,
    load_uom = EXCLUDED.load_uom,
    calc_hi_rate = EXCLUDED.calc_hi_rate,
    operating_condition_cd = EXCLUDED.operating_condition_cd,
    segment_number = EXCLUDED.segment_number,
    app_e_sys_id = EXCLUDED.app_e_sys_id,
    rpt_nox_emission_rate = EXCLUDED.rpt_nox_emission_rate,
    calc_nox_emission_rate = EXCLUDED.calc_nox_emission_rate,
    summation_formula_cd = EXCLUDED.summation_formula_cd,
    rpt_nox_emission_rate_all_fuels = EXCLUDED.rpt_nox_emission_rate_all_fuels,
    calc_nox_emission_rate_all_fuels = EXCLUDED.calc_nox_emission_rate_all_fuels,
    calc_hi_rate_all_fuels = EXCLUDED.calc_hi_rate_all_fuels,
    nox_mass_rate_formula_cd = EXCLUDED.nox_mass_rate_formula_cd,
    rpt_nox_mass_all_fuels = EXCLUDED.rpt_nox_mass_all_fuels,
    calc_nox_mass_all_fuels = EXCLUDED.calc_nox_mass_all_fuels,
    error_codes = EXCLUDED.error_codes;


  INSERT INTO camdecmps.emission_view_noxmasscems (
    mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, unit_load, load_uom, unadj_nox, calc_nox_baf, rpt_adj_nox, adj_nox_used, nox_modc, nox_pma, unadj_flow, calc_flow_baf, rpt_adj_flow, adj_flow_used, flow_modc, flow_pma, pct_h2o_used, source_h2o_value, nox_mass_formula_cd, rpt_nox_mass, calc_nox_mass, error_codes
)
SELECT 
    mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, unit_load, load_uom, unadj_nox, calc_nox_baf, rpt_adj_nox, adj_nox_used, nox_modc, nox_pma, unadj_flow, calc_flow_baf, rpt_adj_flow, adj_flow_used, flow_modc, flow_pma, pct_h2o_used, source_h2o_value, nox_mass_formula_cd, rpt_nox_mass, calc_nox_mass, error_codes
FROM camdecmpswks.emission_view_noxmasscems
WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId
ON CONFLICT (mon_plan_id, rpt_period_id) DO UPDATE
    SET
    date_hour = EXCLUDED.date_hour,
    op_time = EXCLUDED.op_time,
    unit_load = EXCLUDED.unit_load,
    load_uom = EXCLUDED.load_uom,
    unadj_nox = EXCLUDED.unadj_nox,
    calc_nox_baf = EXCLUDED.calc_nox_baf,
    rpt_adj_nox = EXCLUDED.rpt_adj_nox,
    adj_nox_used = EXCLUDED.adj_nox_used,
    nox_modc = EXCLUDED.nox_modc,
    nox_pma = EXCLUDED.nox_pma,
    unadj_flow = EXCLUDED.unadj_flow,
    calc_flow_baf = EXCLUDED.calc_flow_baf,
    rpt_adj_flow = EXCLUDED.rpt_adj_flow,
    adj_flow_used = EXCLUDED.adj_flow_used,
    flow_modc = EXCLUDED.flow_modc,
    flow_pma = EXCLUDED.flow_pma,
    pct_h2o_used = EXCLUDED.pct_h2o_used,
    source_h2o_value = EXCLUDED.source_h2o_value,
    nox_mass_formula_cd = EXCLUDED.nox_mass_formula_cd,
    rpt_nox_mass = EXCLUDED.rpt_nox_mass,
    calc_nox_mass = EXCLUDED.calc_nox_mass,
    error_codes = EXCLUDED.error_codes;


  INSERT INTO camdecmps.emission_view_noxratecems (
      mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, unit_load, load_uom, nox_rate_modc, nox_rate_pma, unadj_nox, nox_modc, diluent_param, pct_diluent_used, diluent_modc, pct_h2o_used, source_h2o_value, f_factor, nox_rate_formula_cd, rpt_unadj_nox_rate, calc_unadj_nox_rate, calc_nox_baf, rpt_adj_nox_rate, calc_adj_nox_rate, calc_hi_rate, nox_mass_formula_cd, rpt_nox_mass, calc_nox_mass, error_codes, rpt_diluent
  )
  SELECT 
      mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, unit_load, load_uom, nox_rate_modc, nox_rate_pma, unadj_nox, nox_modc, diluent_param, pct_diluent_used, diluent_modc, pct_h2o_used, source_h2o_value, f_factor, nox_rate_formula_cd, rpt_unadj_nox_rate, calc_unadj_nox_rate, calc_nox_baf, rpt_adj_nox_rate, calc_adj_nox_rate, calc_hi_rate, nox_mass_formula_cd, rpt_nox_mass, calc_nox_mass, error_codes, rpt_diluent
  FROM camdecmpswks.emission_view_noxratecems
  WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId
  ON CONFLICT (mon_plan_id, rpt_period_id) DO UPDATE
      SET
      date_hour = EXCLUDED.date_hour,
      op_time = EXCLUDED.op_time,
      unit_load = EXCLUDED.unit_load,
      load_uom = EXCLUDED.load_uom,
      nox_rate_modc = EXCLUDED.nox_rate_modc,
      nox_rate_pma = EXCLUDED.nox_rate_pma,
      unadj_nox = EXCLUDED.unadj_nox,
      nox_modc = EXCLUDED.nox_modc,
      diluent_param = EXCLUDED.diluent_param,
      pct_diluent_used = EXCLUDED.pct_diluent_used,
      diluent_modc = EXCLUDED.diluent_modc,
      pct_h2o_used = EXCLUDED.pct_h2o_used,
      source_h2o_value = EXCLUDED.source_h2o_value,
      f_factor = EXCLUDED.f_factor,
      nox_rate_formula_cd = EXCLUDED.nox_rate_formula_cd,
      rpt_unadj_nox_rate = EXCLUDED.rpt_unadj_nox_rate,
      calc_unadj_nox_rate = EXCLUDED.calc_unadj_nox_rate,
      calc_nox_baf = EXCLUDED.calc_nox_baf,
      rpt_adj_nox_rate = EXCLUDED.rpt_adj_nox_rate,
      calc_adj_nox_rate = EXCLUDED.calc_adj_nox_rate,
      calc_hi_rate = EXCLUDED.calc_hi_rate,
      nox_mass_formula_cd = EXCLUDED.nox_mass_formula_cd,
      rpt_nox_mass = EXCLUDED.rpt_nox_mass,
      calc_nox_mass = EXCLUDED.calc_nox_mass,
      error_codes = EXCLUDED.error_codes,
      rpt_diluent = EXCLUDED.rpt_diluent;

INSERT INTO camdecmps.emission_view_otherdaily (
    mon_plan_id, mon_loc_id, rpt_period_id, test_type_cd, system_component_identifier, system_component_type, span_scale_cd, date_hour, rpt_test_result, error_codes, calc_test_result_cd, test_sum_id
)
SELECT 
    mon_plan_id, mon_loc_id, rpt_period_id, test_type_cd, system_component_identifier, system_component_type, span_scale_cd, date_hour, rpt_test_result, error_codes, calc_test_result_cd, test_sum_id
FROM camdecmpswks.emission_view_otherdaily
WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId
ON CONFLICT (mon_plan_id, rpt_period_id) DO UPDATE
    SET
    mon_loc_id = EXCLUDED.mon_loc_id,
    test_type_cd = EXCLUDED.test_type_cd,
    system_component_identifier = EXCLUDED.system_component_identifier,
    system_component_type = EXCLUDED.system_component_type,
    span_scale_cd = EXCLUDED.span_scale_cd,
    date_hour = EXCLUDED.date_hour,
    rpt_test_result = EXCLUDED.rpt_test_result,
    error_codes = EXCLUDED.error_codes,
    calc_test_result_cd = EXCLUDED.calc_test_result_cd,
    test_sum_id = EXCLUDED.test_sum_id;


  INSERT INTO camdecmps.emission_view_so2appd (
    mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, fuel_sys_id, fuel_type, fuel_use_time, unit_load, load_uom, calc_fuel_flow, fuel_flow_uom, fuel_flow_sodc, sulfur_content, sulfur_uom, sulfur_sampling_type, default_so2_emission_rate, calc_hi_rate, formula_cd, rpt_so2_mass_rate, calc_so2_mass_rate, summation_formula_cd, rpt_so2_mass_rate_all_fuels, calc_so2_mass_rate_all_fuels, error_codes
)
SELECT 
    mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, fuel_sys_id, fuel_type, fuel_use_time, unit_load, load_uom, calc_fuel_flow, fuel_flow_uom, fuel_flow_sodc, sulfur_content, sulfur_uom, sulfur_sampling_type, default_so2_emission_rate, calc_hi_rate, formula_cd, rpt_so2_mass_rate, calc_so2_mass_rate, summation_formula_cd, rpt_so2_mass_rate_all_fuels, calc_so2_mass_rate_all_fuels, error_codes
FROM camdecmpswks.emission_view_so2appd
WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId
ON CONFLICT (mon_plan_id, rpt_period_id) DO UPDATE
    SET
    date_hour = EXCLUDED.date_hour,
    fuel_sys_id = EXCLUDED.fuel_sys_id,
    fuel_type = EXCLUDED.fuel_type,
    op_time = EXCLUDED.op_time,
    fuel_use_time = EXCLUDED.fuel_use_time,
    unit_load = EXCLUDED.unit_load,
    load_uom = EXCLUDED.load_uom,
    calc_fuel_flow = EXCLUDED.calc_fuel_flow,
    fuel_flow_uom = EXCLUDED.fuel_flow_uom,
    fuel_flow_sodc = EXCLUDED.fuel_flow_sodc,
    sulfur_content = EXCLUDED.sulfur_content,
    sulfur_uom = EXCLUDED.sulfur_uom,
    sulfur_sampling_type = EXCLUDED.sulfur_sampling_type,
    default_so2_emission_rate = EXCLUDED.default_so2_emission_rate,
    calc_hi_rate = EXCLUDED.calc_hi_rate,
    formula_cd = EXCLUDED.formula_cd,
    rpt_so2_mass_rate = EXCLUDED.rpt_so2_mass_rate,
    calc_so2_mass_rate = EXCLUDED.calc_so2_mass_rate,
    summation_formula_cd = EXCLUDED.summation_formula_cd,
    rpt_so2_mass_rate_all_fuels = EXCLUDED.rpt_so2_mass_rate_all_fuels,
    calc_so2_mass_rate_all_fuels = EXCLUDED.calc_so2_mass_rate_all_fuels,
    error_codes = EXCLUDED.error_codes;


  INSERT INTO camdecmps.emission_view_so2cems (
    mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, unit_load, load_uom, unadj_so2, so2_baf, rpt_adj_so2, calc_adj_so2, so2_modc, so2_pma, unadj_flow, flow_baf, rpt_adj_flow, adj_flow_used, flow_modc, flow_pma, pct_h2o_used, source_h2o_value, so2_formula_cd, rpt_so2_mass_rate, calc_so2_mass_rate, calc_hi_rate, default_so2_emission_rate, error_codes
)
SELECT 
    mon_plan_id, mon_loc_id, rpt_period_id, date_hour, op_time, unit_load, load_uom, unadj_so2, so2_baf, rpt_adj_so2, calc_adj_so2, so2_modc, so2_pma, unadj_flow, flow_baf, rpt_adj_flow, adj_flow_used, flow_modc, flow_pma, pct_h2o_used, source_h2o_value, so2_formula_cd, rpt_so2_mass_rate, calc_so2_mass_rate, calc_hi_rate, default_so2_emission_rate, error_codes
FROM camdecmpswks.emission_view_so2cems
WHERE mon_plan_id = monPlanId AND rpt_period_id = rptPeriodId
ON CONFLICT (mon_plan_id, rpt_period_id) DO UPDATE
    SET
        mon_loc_id = excluded.mon_loc_id,
        date_hour = excluded.date_hour,
        op_time = excluded.op_time,
        unit_load = excluded.unit_load,
        load_uom = excluded.load_uom,
        unadj_so2 = excluded.unadj_so2,
        so2_baf = excluded.so2_baf,
        rpt_adj_so2 = excluded.rpt_adj_so2,
        calc_adj_so2 = excluded.calc_adj_so2,
        so2_modc = excluded.so2_modc,
        so2_pma = excluded.so2_pma,
        unadj_flow = excluded.unadj_flow,
        flow_baf = excluded.flow_baf,
        rpt_adj_flow = excluded.rpt_adj_flow,
        adj_flow_used = excluded.adj_flow_used,
        flow_modc = excluded.flow_modc,
        flow_pma = excluded.flow_pma,
        pct_h2o_used = excluded.pct_h2o_used,
        source_h2o_value = excluded.source_h2o_value,
        so2_formula_cd = excluded.so2_formula_cd,
        rpt_so2_mass_rate = excluded.rpt_so2_mass_rate,
        calc_so2_mass_rate = excluded.calc_so2_mass_rate,
        calc_hi_rate = excluded.calc_hi_rate,
        default_so2_emission_rate = excluded.default_so2_emission_rate,
        error_codes = excluded.error_codes;



=======
-- EMISSIONS VIEWS
CALL camdecmps.copy_emissions_from_workspace_to_global(monPlanId, rptPeriodId);
>>>>>>> 19c8360f9af15332837574bbb422999149deafee

-- DELETE WORKSPACE DATA
DELETE FROM camdecmpswks.check_session
WHERE chk_session_id = (
  SELECT chk_session_id FROM camdecmpswks.emission_evaluation
  WHERE mon_plan_id = monPlanId and rpt_period_id = rptPeriodId
);

DELETE FROM camdecmpswks.emission_evaluation
WHERE mon_plan_id = monPlanId and rpt_period_id = rptPeriodId;

DELETE FROM camdecmpswks.summary_value a 
WHERE a.rpt_period_id = rptPeriodId and a.mon_loc_id = ANY(monLocIds);

DELETE FROM camdecmpswks.daily_test_summary a 
WHERE a.rpt_period_id = rptPeriodId and a.mon_loc_id = ANY(monLocIds);

DELETE FROM camdecmpswks.weekly_test_summary a 
WHERE a.rpt_period_id = rptPeriodId and a.mon_loc_id = ANY(monLocIds);

DELETE FROM camdecmpswks.daily_backstop a
WHERE a.rpt_period_id = rptPeriodId and a.mon_loc_id = ANY(monLocIds);

DELETE FROM camdecmpswks.daily_emission a 
WHERE a.rpt_period_id = rptPeriodId and a.mon_loc_id = ANY(monLocIds);

DELETE FROM camdecmpswks.hrly_op_data a 
WHERE a.rpt_period_id = rptPeriodId and a.mon_loc_id = ANY(monLocIds);

DELETE FROM camdecmpswks.long_term_fuel_flow a 
WHERE a.rpt_period_id = rptPeriodId and a.mon_loc_id = ANY(monLocIds);
  
DELETE FROM camdecmpswks.sorbent_trap a 
WHERE a.rpt_period_id = rptPeriodId and a.mon_loc_id = ANY(monLocIds);

DELETE FROM camdecmpswks.nsps4t_summary a 
WHERE a.rpt_period_id = rptPeriodId and a.mon_loc_id = ANY(monLocIds);

END $BODY$;
