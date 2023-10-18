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
  AND rpt_period_id = rptPeriodId ON CONFLICT (ltff_id, rpt_period_id) DO 
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
  AND rpt_period_id = rptPeriodId ON CONFLICT (daily_test_sum_id, rpt_period_id) DO 
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
  AND dc.rpt_period_id = rptPeriodId ON CONFLICT (cal_inj_id, rpt_period_id) DO 
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
  AND rpt_period_id = rptPeriodId ON CONFLICT (weekly_test_sum_id, rpt_period_id) DO 
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
  AND wsi.rpt_period_id = rptPeriodId ON CONFLICT (weekly_sys_integrity_id, rpt_period_id) DO 
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
  AND rpt_period_id = rptPeriodId ON CONFLICT (weekly_test_sum_id, rpt_period_id) DO 
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
  AND wsi.rpt_period_id = rptPeriodId ON CONFLICT (weekly_sys_integrity_id, rpt_period_id) DO 
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
  AND rpt_period_id = rptPeriodId ON CONFLICT (hour_id, rpt_period_id) DO 
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
  AND mhv.rpt_period_id = rptPeriodId ON CONFLICT (monitor_hrly_val_id, rpt_period_id) DO 
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
  AND mmhv.rpt_period_id = rptPeriodId ON CONFLICT (mats_mhv_id, rpt_period_id) DO 
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
  AND dhv.rpt_period_id = rptPeriodId ON CONFLICT (derv_id, rpt_period_id) DO 
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
  AND mdhv.rpt_period_id = rptPeriodId ON CONFLICT (mats_dhv_id, rpt_period_id) DO 
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
  AND hff.rpt_period_id = rptPeriodId ON CONFLICT (hrly_fuel_flow_id, rpt_period_id) DO 
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
  AND hgfm.rpt_period_id = rptPeriodId ON CONFLICT (hrly_gas_flow_meter_id, rpt_period_id) DO 
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
  AND hpff.rpt_period_id = rptPeriodId ON CONFLICT (hrly_param_ff_id, rpt_period_id) DO 
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
  AND rpt_period_id = rptPeriodId ON CONFLICT (trap_id, rpt_period_id) DO 
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
  AND smpt.rpt_period_id = rptPeriodId ON CONFLICT (trap_train_id, rpt_period_id) DO 
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
  AND rpt_period_id = rptPeriodId ON CONFLICT (nsps4t_sum_id, rpt_period_id) DO 
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
  AND q4ta.rpt_period_id = rptPeriodId ON CONFLICT (nsps4t_ann_id, rpt_period_id) DO 
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
  AND q4tcp.rpt_period_id = rptPeriodId ON CONFLICT (nsps4t_cmp_id, rpt_period_id) DO 
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

-- EMISSIONS VIEWS

CALL camdecmps.copy_emissions_from_workspace_to_global(monPlanId, rptPeriodId);

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
