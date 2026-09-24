-- Drop PostgreSQL views and foreign keys that depend on converted ID columns.
-- The affected camdsnap materialized views must be dropped first because they
-- may depend on the regular views below. Their indexes are dropped with them.
-- Run this script before the bigint ALTER scripts.

BEGIN;

DROP VIEW IF EXISTS camdecmpswks.vw_used_identifier;
DROP VIEW IF EXISTS camdecmpswks.vw_unit_reporting_period;
DROP VIEW IF EXISTS camdecmpswks.vw_unit_op_status;
DROP VIEW IF EXISTS camdecmpswks.vw_unit_monitor_system;
DROP VIEW IF EXISTS camdecmpswks.vw_unit_stack_configuration;
DROP VIEW IF EXISTS camdecmpswks.vw_test_summary_eval_and_submit;
DROP VIEW IF EXISTS camdecmpswks.vw_test_extension_exemption_eval_and_submit;
DROP VIEW IF EXISTS camdecmpswks.vw_system_fuel_flow;
DROP VIEW IF EXISTS camdecmpswks.vw_system_analyzer_range;
DROP VIEW IF EXISTS camdecmpswks.vw_stack_pipe;
DROP VIEW IF EXISTS camdecmpswks.vw_rpt_monitoring_plan_unit_stack_config;
DROP VIEW IF EXISTS camdecmpswks.vw_rect_duct_waf;
DROP VIEW IF EXISTS camdecmpswks.vw_qa_unit_default_test_run;
DROP VIEW IF EXISTS camdecmpswks.vw_qa_test_summary_unitdef;
DROP VIEW IF EXISTS camdecmpswks.vw_qa_test_summary_onoff;
DROP VIEW IF EXISTS camdecmpswks.vw_qa_test_summary_line;
DROP VIEW IF EXISTS camdecmpswks.vw_qa_test_summary_ffacctt;
DROP VIEW IF EXISTS camdecmpswks.vw_qa_test_summary_ffacc;
DROP VIEW IF EXISTS camdecmpswks.vw_qa_test_summary_ff2ltst;
DROP VIEW IF EXISTS camdecmpswks.vw_qa_test_summary_ff2lbas;
DROP VIEW IF EXISTS camdecmpswks.vw_qa_test_summary_f2lref;
DROP VIEW IF EXISTS camdecmpswks.vw_qa_test_summary_f2lchk;
DROP VIEW IF EXISTS camdecmpswks.vw_qa_test_extension_exemption;
DROP VIEW IF EXISTS camdecmpswks.vw_qa_test_claim;
DROP VIEW IF EXISTS camdecmpswks.vw_qa_supp_data_hourly_status;
DROP VIEW IF EXISTS camdecmpswks.vw_qa_test_summary;
DROP VIEW IF EXISTS camdecmpswks.vw_qa_supp_data;
DROP VIEW IF EXISTS camdecmpswks.vw_qa_supp_attribute;
DROP VIEW IF EXISTS camdecmpswks.vw_qa_rata_traverse;
DROP VIEW IF EXISTS camdecmpswks.vw_qa_flow_rata_run;
DROP VIEW IF EXISTS camdecmpswks.vw_qa_rata_run;
DROP VIEW IF EXISTS camdecmpswks.vw_qa_rata_summary;
DROP VIEW IF EXISTS camdecmpswks.vw_qa_test_summary_rata;
DROP VIEW IF EXISTS camdecmpswks.vw_qa_cycle_time_injection;
DROP VIEW IF EXISTS camdecmpswks.vw_qa_test_summary_cycle;
DROP VIEW IF EXISTS camdecmpswks.vw_qa_cert_event_eval_and_submit;
DROP VIEW IF EXISTS camdecmpswks.vw_qa_cert_event;
DROP VIEW IF EXISTS camdecmpswks.vw_qa_calibration_injection;
DROP VIEW IF EXISTS camdecmpswks.vw_qa_test_summary_7day;
DROP VIEW IF EXISTS camdecmpswks.vw_qa_ae_hi_oil;
DROP VIEW IF EXISTS camdecmpswks.vw_qa_ae_hi_gas;
DROP VIEW IF EXISTS camdecmpswks.vw_qa_ae_correlation_test_run;
DROP VIEW IF EXISTS camdecmpswks.vw_qa_ae_correlation_test_sum;
DROP VIEW IF EXISTS camdecmpswks.vw_qa_test_summary_appe;
DROP VIEW IF EXISTS camdecmpswks.vw_program_parameter;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_unit_stack_configuration;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_unit_program;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_unit_capacity;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_qa_supp_attribute;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_program_exemption;
DROP VIEW IF EXISTS camdecmpswks.vw_unit_program_exemption;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_operating_status;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_op_supp_data;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_span_so2;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_span_nox;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_span_flow;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_span_co2;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_span;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_qualification;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_plan;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_method_missing_data_fsp;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_method;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_load;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_hrly_value_o2_wet;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_hrly_value_o2_null;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_hrly_value_o2_dry;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_hrly_value_noxc;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_hrly_value_h2o;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_hrly_value_flow;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_hrly_value_co2c;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_hrly_value;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_formula_so2;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_formula;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_default_so2x;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_default_so2r_f23;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_default_so2c;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_default_o2x;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_default_norx;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_default_mxff;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_default_mnof;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_default_mngf;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_default_h2o;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_default_co2x;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_default_co2n_nfs;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_default;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_locations_and_unit_stack_configurations;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_location_unit_type;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_location_program;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_location_fuel;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_location_capacity;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_location_attribute;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_location;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_hrly_param_fuel_flow;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_hrly_fuel_flow;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_evaluation_results;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_derived_hrly_value_so2r;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_derived_hrly_value_so2;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_derived_hrly_value_noxr;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_derived_hrly_value_nox;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_derived_hrly_value_lme;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_derived_hrly_value_hi;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_derived_hrly_value_h2o;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_derived_hrly_value_co2c;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_derived_hrly_value_co2;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_derived_hrly_value;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_hrly_op_data;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_daily_fuel;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_daily_emission;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_component;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_analyzer_range;
DROP VIEW IF EXISTS camdecmpswks.vw_monitor_system_component;
DROP VIEW IF EXISTS camdecmpswks.vw_monitor_system;
DROP VIEW IF EXISTS camdecmpswks.vw_monitor_span;
DROP VIEW IF EXISTS camdecmpswks.vw_monitor_qualification_pct;
DROP VIEW IF EXISTS camdecmpswks.vw_monitor_qualification_lme;
DROP VIEW IF EXISTS camdecmpswks.vw_monitor_qualification;
DROP VIEW IF EXISTS camdecmpswks.vw_monitor_plan_comment;
DROP VIEW IF EXISTS camdecmpswks.vw_monitor_method;
DROP VIEW IF EXISTS camdecmpswks.vw_monitor_load;
DROP VIEW IF EXISTS camdecmpswks.vw_monitor_formula;
DROP VIEW IF EXISTS camdecmpswks.vw_monitor_default;
DROP VIEW IF EXISTS camdecmpswks.vw_location_unit_type;
DROP VIEW IF EXISTS camdecmpswks.vw_location_reporting_frequency;
DROP VIEW IF EXISTS camdecmpswks.vw_location_operating_status;
DROP VIEW IF EXISTS camdecmpswks.vw_location_fuel;
DROP VIEW IF EXISTS camdecmpswks.vw_location_control;
DROP VIEW IF EXISTS camdecmpswks.vw_location_capacity;
DROP VIEW IF EXISTS camdecmpswks.vw_location_attribute;
DROP VIEW IF EXISTS camdecmpswks.vw_evem_summary_value;
DROP VIEW IF EXISTS camdecmpswks.vw_evem_long_term_fuel_flow;
DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_location;
DROP VIEW IF EXISTS camdecmpswks.vw_monitor_location_merged;
DROP VIEW IF EXISTS camdecmpswks.vw_evem_dhv_total_and_april_load;
DROP VIEW IF EXISTS camdecmpswks.vw_em_submit;
DROP VIEW IF EXISTS camdecmpswks.vw_em_export_and_report;
DROP VIEW IF EXISTS camdecmpswks.vw_em_evaluate;
DROP VIEW IF EXISTS camdecmpswks.vw_component;
DROP VIEW IF EXISTS camdecmpswks.vw_ce_mp_monitor_location;
DROP VIEW IF EXISTS camdecmpswks.vw_location_program;
DROP VIEW IF EXISTS camdecmpswks.vw_analyzer_range;
DROP VIEW IF EXISTS camdecmpswks.vw_monitor_location;
DROP VIEW IF EXISTS camdecmpswks.emission_view_dailybackstop;
DROP VIEW IF EXISTS camdecmpswks.emission_view_counts;
DROP VIEW IF EXISTS camdecmpsmd.vw_rule_check_parameter;
DROP VIEW IF EXISTS camdecmpsmd.vw_rule_check_condition;
DROP VIEW IF EXISTS camdecmpsmd.vw_rule_check;
DROP VIEW IF EXISTS camdecmpsmd.vw_qa_certification_api_check_catalog_results;
DROP VIEW IF EXISTS camdecmpsmd.vw_monitor_plan_api_check_catalog_results;
DROP VIEW IF EXISTS camdecmpsmd.vw_es_parameter_code;
DROP VIEW IF EXISTS camdecmpsmd.vw_es_check_catalog_result;
DROP VIEW IF EXISTS camdecmpsmd.vw_emissions_api_check_catalog_results;
DROP VIEW IF EXISTS camdecmpsmd.vw_check_catalog_result;
DROP VIEW IF EXISTS camdecmpsmd.vw_check_catalog_plugin;
DROP VIEW IF EXISTS camdecmpsaux.vw_submission_window_job_open;
DROP VIEW IF EXISTS camdecmpsaux.vw_submission_window_job_close;
DROP VIEW IF EXISTS camdecmpsaux.vw_submission_list;
DROP VIEW IF EXISTS camdecmpsaux.vw_em_submission_access;
DROP VIEW IF EXISTS camdecmpsaux.vw_combined_submissions;
DROP VIEW IF EXISTS camdecmps.vw_unit_program_exemption;
DROP VIEW IF EXISTS camdecmps.vw_test_summary_eval_and_submit;
DROP VIEW IF EXISTS camdecmps.vw_test_extension_exemption_eval_and_submit;
DROP VIEW IF EXISTS camdecmps.vw_qa_test_summary_maintenance;
DROP VIEW IF EXISTS camdecmps.vw_qa_test_extens_exempt_maintenance;
DROP VIEW IF EXISTS camdecmps.vw_qa_cert_event_maintenance;
DROP VIEW IF EXISTS camdecmps.vw_qa_cert_event_eval_and_submit;
DROP VIEW IF EXISTS camdecmps.vw_mp_unit_stack_configuration;
DROP VIEW IF EXISTS camdecmps.vw_mp_em_inconsistencies;
DROP VIEW IF EXISTS camdecmps.vw_monitor_location;
DROP VIEW IF EXISTS camdecmps.vw_locations_in_multiple_mps;
DROP VIEW IF EXISTS camdecmpswks.vw_monitor_plan_location;
DROP VIEW IF EXISTS camdecmps.vw_inconsistent_mprf_dates;
DROP VIEW IF EXISTS camdecmps.vw_monitor_plan;
DROP VIEW IF EXISTS camdecmps.vw_em_reporting_status;
DROP VIEW IF EXISTS camdecmps.vw_em_export_and_report;
DROP VIEW IF EXISTS camdecmps.emission_view_dailybackstop;
DROP VIEW IF EXISTS camdecmps.emission_view_counts;
DROP VIEW IF EXISTS camddmw.vw_facility_unit_attributes;
DROP VIEW IF EXISTS camdaux.vw_annual_facility_bulk_files_to_generate;
DROP VIEW IF EXISTS camdaux.vw_annual_emissions_bulk_files_per_state_to_generate;

-- Foreign keys that reference converted columns

ALTER TABLE IF EXISTS camd.generator DROP CONSTRAINT IF EXISTS fk_generator_plant;

ALTER TABLE IF EXISTS camd.plant_person DROP CONSTRAINT IF EXISTS fk_plant_person_plant;

ALTER TABLE IF EXISTS camd.program_phase DROP CONSTRAINT IF EXISTS fk_program_phase_program;

ALTER TABLE IF EXISTS camd.unit DROP CONSTRAINT IF EXISTS fk_unit_plant;

ALTER TABLE IF EXISTS camd.unit_boiler_type DROP CONSTRAINT IF EXISTS fk_unit_boiler_type_unit;

ALTER TABLE IF EXISTS camd.unit_exemption DROP CONSTRAINT IF EXISTS fk_unit_exemption_unit;

ALTER TABLE IF EXISTS camd.unit_generator DROP CONSTRAINT IF EXISTS fk_unit_generator_generator;
ALTER TABLE IF EXISTS camd.unit_generator DROP CONSTRAINT IF EXISTS fk_unit_generator_unit;

ALTER TABLE IF EXISTS camd.unit_op_status DROP CONSTRAINT IF EXISTS fk_unit_op_status_unit;

ALTER TABLE IF EXISTS camd.unit_program DROP CONSTRAINT IF EXISTS fk_unit_program_program;
ALTER TABLE IF EXISTS camd.unit_program DROP CONSTRAINT IF EXISTS fk_unit_program_unit;

ALTER TABLE IF EXISTS camdaux.inventory_status_log DROP CONSTRAINT IF EXISTS fk_inventory_status_log_plant;
ALTER TABLE IF EXISTS camdaux.inventory_status_log DROP CONSTRAINT IF EXISTS fk_inventory_status_log_unit;

ALTER TABLE IF EXISTS camdecmps.daily_backstop DROP CONSTRAINT IF EXISTS fk_daily_backstop_unit;

ALTER TABLE IF EXISTS camdecmps.dm_emissions DROP CONSTRAINT IF EXISTS fk_dm_emissions_plant;

ALTER TABLE IF EXISTS camdecmps.monitor_location DROP CONSTRAINT IF EXISTS fk_monitor_location_unit;

ALTER TABLE IF EXISTS camdecmps.monitor_plan DROP CONSTRAINT IF EXISTS fk_monitor_plan_plant;

ALTER TABLE IF EXISTS camdecmps.stack_pipe DROP CONSTRAINT IF EXISTS fk_stack_pipe_plant;

ALTER TABLE IF EXISTS camdecmps.unit_capacity DROP CONSTRAINT IF EXISTS fk_unit_capacity_unit;

ALTER TABLE IF EXISTS camdecmps.unit_control DROP CONSTRAINT IF EXISTS fk_unit_control_unit;

ALTER TABLE IF EXISTS camdecmps.unit_fuel DROP CONSTRAINT IF EXISTS fk_unit_fuel_unit;

ALTER TABLE IF EXISTS camdecmps.unit_stack_configuration DROP CONSTRAINT IF EXISTS fk_unit_stack_configuration_unit;

ALTER TABLE IF EXISTS camdecmpsaux.apportionment_data DROP CONSTRAINT IF EXISTS fk_apportionment_data_apportionment_range;

ALTER TABLE IF EXISTS camdecmpsaux.apportionment_range DROP CONSTRAINT IF EXISTS fk_apportionment_range_apportionment;

ALTER TABLE IF EXISTS camdecmpsaux.email_to_process DROP CONSTRAINT IF EXISTS fk_email_to_process_plant;

ALTER TABLE IF EXISTS camdecmpsaux.es_spec DROP CONSTRAINT IF EXISTS fk_es_spec_check_catalog_result;
ALTER TABLE IF EXISTS camdecmpsaux.es_spec DROP CONSTRAINT IF EXISTS fk_es_spec_plant;

ALTER TABLE IF EXISTS camdecmpsaux.evaluation_set DROP CONSTRAINT IF EXISTS fk_evaluation_set_plant;

ALTER TABLE IF EXISTS camdecmpsaux.mats_data_submission DROP CONSTRAINT IF EXISTS fk_mats_data_submission_plant;

ALTER TABLE IF EXISTS camdecmpsaux.pdem_mats_unit_hour DROP CONSTRAINT IF EXISTS pdem_mats_unit_hour_loc_fk;

ALTER TABLE IF EXISTS camdecmpsaux.pdem_p75_unit_hour DROP CONSTRAINT IF EXISTS pdem_p75_unit_hour_loc_fk;

ALTER TABLE IF EXISTS camdecmpsaux.program_parameter DROP CONSTRAINT IF EXISTS fk_program_parameter_program;

ALTER TABLE IF EXISTS camdecmpsaux.submission_set DROP CONSTRAINT IF EXISTS fk_submission_set_plant;

ALTER TABLE IF EXISTS camdecmpsmd.check_catalog_parameter DROP CONSTRAINT IF EXISTS fk_check_catalog_parameter_check_catalog;

ALTER TABLE IF EXISTS camdecmpsmd.check_catalog_plugin DROP CONSTRAINT IF EXISTS fk_check_catalog_plugin_check_catalog;

ALTER TABLE IF EXISTS camdecmpsmd.rule_check DROP CONSTRAINT IF EXISTS pk_rule_check_check_catalog;

ALTER TABLE IF EXISTS camdecmpsmd.rule_check_condition DROP CONSTRAINT IF EXISTS fk_rule_check_condition_rule_check;

ALTER TABLE IF EXISTS camdecmpswks.daily_backstop DROP CONSTRAINT IF EXISTS fk_daily_backstop_unit;

ALTER TABLE IF EXISTS camdecmpswks.mats_bulk_file DROP CONSTRAINT IF EXISTS fk_mats_bulk_file_plant;

ALTER TABLE IF EXISTS camdecmpswks.monitor_location DROP CONSTRAINT IF EXISTS fk_monitor_location_unit;

ALTER TABLE IF EXISTS camdecmpswks.monitor_plan DROP CONSTRAINT IF EXISTS fk_monitor_plan_plant;

ALTER TABLE IF EXISTS camdecmpswks.stack_pipe DROP CONSTRAINT IF EXISTS fk_stack_pipe_plant;

ALTER TABLE IF EXISTS camdecmpswks.unit DROP CONSTRAINT IF EXISTS fk_unit_plant;

ALTER TABLE IF EXISTS camdecmpswks.unit_capacity DROP CONSTRAINT IF EXISTS fk_unit_capacity_unit;

ALTER TABLE IF EXISTS camdecmpswks.unit_control DROP CONSTRAINT IF EXISTS fk_unit_control_unit;

ALTER TABLE IF EXISTS camdecmpswks.unit_fuel DROP CONSTRAINT IF EXISTS fk_unit_fuel_unit;

ALTER TABLE IF EXISTS camdecmpswks.unit_stack_configuration DROP CONSTRAINT IF EXISTS fk_unit_stack_configuration_unit;

COMMIT;
