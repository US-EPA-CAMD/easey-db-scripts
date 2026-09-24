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
DROP VIEW IF EXISTS camdecmpswks.vw_evem_emissions;
DROP VIEW IF EXISTS camdecmpswks.vw_evem_dhv_total_and_april_load;
DROP VIEW IF EXISTS camdecmpswks.vw_em_submit;
DROP VIEW IF EXISTS camdecmpswks.vw_em_export_and_report;
DROP VIEW IF EXISTS camdecmpswks.vw_em_evaluate;
DROP VIEW IF EXISTS camdecmpswks.vw_component;
DROP VIEW IF EXISTS camdecmpswks.vw_ce_mp_monitor_location;
DROP VIEW IF EXISTS camdecmpswks.vw_location_program;
DROP VIEW IF EXISTS camdecmpswks.vw_analyzer_range;
DROP VIEW IF EXISTS camdecmpswks.vw_monitor_location;
DROP VIEW IF EXISTS camdecmpswks.emission_view_sumval;
DROP VIEW IF EXISTS camdecmpswks.emission_view_nsps4t;
DROP VIEW IF EXISTS camdecmpswks.emission_view_ltff;
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
DROP VIEW IF EXISTS camdecmpsaux.vw_submission_queue_position;
DROP VIEW IF EXISTS camdecmpsaux.vw_submission_list;
DROP VIEW IF EXISTS camdecmpsaux.vw_last_submission;
DROP VIEW IF EXISTS camdecmpsaux.vw_evaluation_queue_position;
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
DROP VIEW IF EXISTS camdecmpsmd.vw_reporting_period;
DROP VIEW IF EXISTS camdecmps.vw_inconsistent_mprf_dates;
DROP VIEW IF EXISTS camdecmps.vw_monitor_plan;
DROP VIEW IF EXISTS camdecmps.vw_emissions_submissions_progress;
DROP VIEW IF EXISTS camdecmps.vw_emissions_submissions_received;
DROP VIEW IF EXISTS camdecmps.vw_emissions_submissions_gdm;
DROP VIEW IF EXISTS camdecmps.vw_emissions_submissions_expected;
DROP VIEW IF EXISTS camdecmps.vw_em_reporting_status;
DROP VIEW IF EXISTS camdecmps.vw_em_export_and_report;
DROP VIEW IF EXISTS camdecmps.emission_view_sumval;
DROP VIEW IF EXISTS camdecmps.emission_view_nsps4t;
DROP VIEW IF EXISTS camdecmps.emission_view_ltff;
DROP VIEW IF EXISTS camdecmps.emission_view_dailybackstop;
DROP VIEW IF EXISTS camdecmps.emission_view_counts;
DROP VIEW IF EXISTS camddmw.vw_facility_unit_attributes;
DROP VIEW IF EXISTS camdaux.vw_annual_facility_bulk_files_to_generate;
DROP VIEW IF EXISTS camdaux.vw_annual_emissions_bulk_files_per_state_to_generate;
DROP VIEW IF EXISTS camdaux.vw_annual_emissions_bulk_files_per_quarter_to_generate;

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

ALTER TABLE IF EXISTS camdecmps.component_op_supp_data DROP CONSTRAINT IF EXISTS fk_component_op_supp_data_reporting_period;

ALTER TABLE IF EXISTS camdecmps.daily_backstop DROP CONSTRAINT IF EXISTS fk_daily_backstop_reporting_period;
ALTER TABLE IF EXISTS camdecmps.daily_backstop DROP CONSTRAINT IF EXISTS fk_daily_backstop_unit;

ALTER TABLE IF EXISTS camdecmps.daily_calibration DROP CONSTRAINT IF EXISTS fk_daily_calibration_daily_test_summary;
ALTER TABLE IF EXISTS camdecmps.daily_calibration DROP CONSTRAINT IF EXISTS fk_daily_calibration_reporting_period;

ALTER TABLE IF EXISTS camdecmps.daily_emission DROP CONSTRAINT IF EXISTS fk_daily_emission_reporting_period;

ALTER TABLE IF EXISTS camdecmps.daily_fuel DROP CONSTRAINT IF EXISTS fk_daily_fuel_daily_emission;
ALTER TABLE IF EXISTS camdecmps.daily_fuel DROP CONSTRAINT IF EXISTS fk_daily_fuel_reporting_period;

ALTER TABLE IF EXISTS camdecmps.daily_test_summary DROP CONSTRAINT IF EXISTS fk_daily_test_summary_reporting_period;

ALTER TABLE IF EXISTS camdecmps.daily_test_supp_data DROP CONSTRAINT IF EXISTS fk_daily_test_supp_data_reporting_period;

ALTER TABLE IF EXISTS camdecmps.daily_test_system_supp_data DROP CONSTRAINT IF EXISTS fk_daily_test_system_sup_data_reporting_period;

ALTER TABLE IF EXISTS camdecmps.derived_hrly_value DROP CONSTRAINT IF EXISTS fk_derived_hrly_value_hrly_op_data;
ALTER TABLE IF EXISTS camdecmps.derived_hrly_value DROP CONSTRAINT IF EXISTS fk_derived_hrly_value_reporting_period;

ALTER TABLE IF EXISTS camdecmps.dm_emissions DROP CONSTRAINT IF EXISTS fk_dm_emissions_plant;
ALTER TABLE IF EXISTS camdecmps.dm_emissions DROP CONSTRAINT IF EXISTS fk_dm_emissions_reporting_period;

ALTER TABLE IF EXISTS camdecmps.emission_evaluation DROP CONSTRAINT IF EXISTS fk_emission_evaluation_reporting_period;

ALTER TABLE IF EXISTS camdecmps.emission_view_all DROP CONSTRAINT IF EXISTS fk_emission_view_all_emission_evaluation;
ALTER TABLE IF EXISTS camdecmps.emission_view_all DROP CONSTRAINT IF EXISTS fk_emission_view_all_hrly_op_data;
ALTER TABLE IF EXISTS camdecmps.emission_view_all DROP CONSTRAINT IF EXISTS fk_emission_view_all_reporting_period;

ALTER TABLE IF EXISTS camdecmps.emission_view_co2appd DROP CONSTRAINT IF EXISTS fk_emission_view_co2appd_emission_evaluation;
ALTER TABLE IF EXISTS camdecmps.emission_view_co2appd DROP CONSTRAINT IF EXISTS fk_emission_view_co2appd_reporting_period;

ALTER TABLE IF EXISTS camdecmps.emission_view_co2calc DROP CONSTRAINT IF EXISTS fk_emission_view_co2calc_emission_evaluation;
ALTER TABLE IF EXISTS camdecmps.emission_view_co2calc DROP CONSTRAINT IF EXISTS fk_emission_view_co2calc_reporting_period;

ALTER TABLE IF EXISTS camdecmps.emission_view_co2cems DROP CONSTRAINT IF EXISTS fk_emission_view_co2cems_emission_evaluation;
ALTER TABLE IF EXISTS camdecmps.emission_view_co2cems DROP CONSTRAINT IF EXISTS fk_emission_view_co2cems_reporting_period;

ALTER TABLE IF EXISTS camdecmps.emission_view_co2dailyfuel DROP CONSTRAINT IF EXISTS fk_emission_view_co2dailyfuel_emission_evaluation;
ALTER TABLE IF EXISTS camdecmps.emission_view_co2dailyfuel DROP CONSTRAINT IF EXISTS fk_emission_view_co2dailyfuel_reporting_period;

ALTER TABLE IF EXISTS camdecmps.emission_view_count DROP CONSTRAINT IF EXISTS fk_emission_view_count_emission_evaluation;
ALTER TABLE IF EXISTS camdecmps.emission_view_count DROP CONSTRAINT IF EXISTS fk_emission_view_count_reporting_period;

ALTER TABLE IF EXISTS camdecmps.emission_view_dailycal DROP CONSTRAINT IF EXISTS fk_emission_view_dailycal_daily_test_summary;
ALTER TABLE IF EXISTS camdecmps.emission_view_dailycal DROP CONSTRAINT IF EXISTS fk_emission_view_dailycal_emission_evaluation;
ALTER TABLE IF EXISTS camdecmps.emission_view_dailycal DROP CONSTRAINT IF EXISTS fk_emission_view_dailycal_reporting_period;

ALTER TABLE IF EXISTS camdecmps.emission_view_hiappd DROP CONSTRAINT IF EXISTS fk_emission_view_hiappd_emission_evaluation;
ALTER TABLE IF EXISTS camdecmps.emission_view_hiappd DROP CONSTRAINT IF EXISTS fk_emission_view_hiappd_reporting_period;

ALTER TABLE IF EXISTS camdecmps.emission_view_hicems DROP CONSTRAINT IF EXISTS fk_emission_view_hicems_emission_evaluation;
ALTER TABLE IF EXISTS camdecmps.emission_view_hicems DROP CONSTRAINT IF EXISTS fk_emission_view_hicems_hrly_op_data;
ALTER TABLE IF EXISTS camdecmps.emission_view_hicems DROP CONSTRAINT IF EXISTS fk_emission_view_hicems_reporting_period;

ALTER TABLE IF EXISTS camdecmps.emission_view_hiunitstack DROP CONSTRAINT IF EXISTS fk_emission_view_hiunitstack_emission_evaluation;
ALTER TABLE IF EXISTS camdecmps.emission_view_hiunitstack DROP CONSTRAINT IF EXISTS fk_emission_view_hiunitstack_reporting_period;

ALTER TABLE IF EXISTS camdecmps.emission_view_lme DROP CONSTRAINT IF EXISTS fk_emission_view_lme_emission_evaluation;
ALTER TABLE IF EXISTS camdecmps.emission_view_lme DROP CONSTRAINT IF EXISTS fk_emission_view_lme_hrly_op_data;
ALTER TABLE IF EXISTS camdecmps.emission_view_lme DROP CONSTRAINT IF EXISTS fk_emission_view_lme_reporting_period;

ALTER TABLE IF EXISTS camdecmps.emission_view_massoilcalc DROP CONSTRAINT IF EXISTS fk_emission_view_massoilcalc_emission_evaluation;
ALTER TABLE IF EXISTS camdecmps.emission_view_massoilcalc DROP CONSTRAINT IF EXISTS fk_emission_view_massoilcalc_reporting_period;

ALTER TABLE IF EXISTS camdecmps.emission_view_matshcl DROP CONSTRAINT IF EXISTS fk_emission_view_matshcl_emission_evaluation;
ALTER TABLE IF EXISTS camdecmps.emission_view_matshcl DROP CONSTRAINT IF EXISTS fk_emission_view_matshcl_reporting_period;

ALTER TABLE IF EXISTS camdecmps.emission_view_matshf DROP CONSTRAINT IF EXISTS fk_emission_view_matshf_emission_evaluation;
ALTER TABLE IF EXISTS camdecmps.emission_view_matshf DROP CONSTRAINT IF EXISTS fk_emission_view_matshf_reporting_period;

ALTER TABLE IF EXISTS camdecmps.emission_view_matshg DROP CONSTRAINT IF EXISTS fk_emission_view_matshg_emission_evaluation;
ALTER TABLE IF EXISTS camdecmps.emission_view_matshg DROP CONSTRAINT IF EXISTS fk_emission_view_matshg_reporting_period;

ALTER TABLE IF EXISTS camdecmps.emission_view_matsso2 DROP CONSTRAINT IF EXISTS fk_emission_view_matsso2_emission_evaluation;
ALTER TABLE IF EXISTS camdecmps.emission_view_matsso2 DROP CONSTRAINT IF EXISTS fk_emission_view_matsso2_reporting_period;

ALTER TABLE IF EXISTS camdecmps.emission_view_matssorbent DROP CONSTRAINT IF EXISTS fk_emission_view_matssorbent_emission_evaluation;
ALTER TABLE IF EXISTS camdecmps.emission_view_matssorbent DROP CONSTRAINT IF EXISTS fk_emission_view_matssorbent_reporting_period;

ALTER TABLE IF EXISTS camdecmps.emission_view_matsweekly DROP CONSTRAINT IF EXISTS fk_emission_view_matsweekly_emission_evaluation;
ALTER TABLE IF EXISTS camdecmps.emission_view_matsweekly DROP CONSTRAINT IF EXISTS fk_emission_view_matsweekly_reporting_period;
ALTER TABLE IF EXISTS camdecmps.emission_view_matsweekly DROP CONSTRAINT IF EXISTS fk_emission_view_matsweekly_weekly_test_summary;

ALTER TABLE IF EXISTS camdecmps.emission_view_moisture DROP CONSTRAINT IF EXISTS fk_emission_view_moisture_emission_evaluation;
ALTER TABLE IF EXISTS camdecmps.emission_view_moisture DROP CONSTRAINT IF EXISTS fk_emission_view_moisture_reporting_period;

ALTER TABLE IF EXISTS camdecmps.emission_view_noxappemixedfuel DROP CONSTRAINT IF EXISTS fk_emission_view_noxappemixedfuel_emission_evaluation;
ALTER TABLE IF EXISTS camdecmps.emission_view_noxappemixedfuel DROP CONSTRAINT IF EXISTS fk_emission_view_noxappemixedfuel_reporting_period;

ALTER TABLE IF EXISTS camdecmps.emission_view_noxappesinglefuel DROP CONSTRAINT IF EXISTS fk_emission_view_noxappesinglefuel_emission_evaluation;
ALTER TABLE IF EXISTS camdecmps.emission_view_noxappesinglefuel DROP CONSTRAINT IF EXISTS fk_emission_view_noxappesinglefuel_reporting_period;

ALTER TABLE IF EXISTS camdecmps.emission_view_noxmasscems DROP CONSTRAINT IF EXISTS fk_emission_view_noxmasscems_emission_evaluation;
ALTER TABLE IF EXISTS camdecmps.emission_view_noxmasscems DROP CONSTRAINT IF EXISTS fk_emission_view_noxmasscems_reporting_period;

ALTER TABLE IF EXISTS camdecmps.emission_view_noxratecems DROP CONSTRAINT IF EXISTS fk_emission_view_noxratecems_emission_evaluation;
ALTER TABLE IF EXISTS camdecmps.emission_view_noxratecems DROP CONSTRAINT IF EXISTS fk_emission_view_noxratecems_reporting_period;

ALTER TABLE IF EXISTS camdecmps.emission_view_otherdaily DROP CONSTRAINT IF EXISTS fk_emission_view_otherdaily_daily_test_summary;
ALTER TABLE IF EXISTS camdecmps.emission_view_otherdaily DROP CONSTRAINT IF EXISTS fk_emission_view_otherdaily_emission_evaluation;
ALTER TABLE IF EXISTS camdecmps.emission_view_otherdaily DROP CONSTRAINT IF EXISTS fk_emission_view_otherdaily_reporting_period;

ALTER TABLE IF EXISTS camdecmps.emission_view_so2appd DROP CONSTRAINT IF EXISTS fk_emission_view_so2appd_emission_evaluation;
ALTER TABLE IF EXISTS camdecmps.emission_view_so2appd DROP CONSTRAINT IF EXISTS fk_emission_view_so2appd_reporting_period;

ALTER TABLE IF EXISTS camdecmps.emission_view_so2cems DROP CONSTRAINT IF EXISTS fk_emission_view_so2cems_emission_evaluation;
ALTER TABLE IF EXISTS camdecmps.emission_view_so2cems DROP CONSTRAINT IF EXISTS fk_emission_view_so2cems_reporting_period;

ALTER TABLE IF EXISTS camdecmps.hrly_fuel_flow DROP CONSTRAINT IF EXISTS fk_hrly_fuel_flow_hrly_op_data;
ALTER TABLE IF EXISTS camdecmps.hrly_fuel_flow DROP CONSTRAINT IF EXISTS fk_hrly_fuel_flow_reporting_period;

ALTER TABLE IF EXISTS camdecmps.hrly_gas_flow_meter DROP CONSTRAINT IF EXISTS fk_hrly_gas_flow_meter_hrly_op_data;
ALTER TABLE IF EXISTS camdecmps.hrly_gas_flow_meter DROP CONSTRAINT IF EXISTS fk_hrly_gas_flow_meter_reporting_period;

ALTER TABLE IF EXISTS camdecmps.hrly_op_data DROP CONSTRAINT IF EXISTS fk_hrly_op_data_reporting_period;

ALTER TABLE IF EXISTS camdecmps.hrly_param_fuel_flow DROP CONSTRAINT IF EXISTS fk_hrly_param_fuel_flow_hrly_fuel_flow;
ALTER TABLE IF EXISTS camdecmps.hrly_param_fuel_flow DROP CONSTRAINT IF EXISTS fk_hrly_param_fuel_flow_reporting_period;

ALTER TABLE IF EXISTS camdecmps.last_qa_value_supp_data DROP CONSTRAINT IF EXISTS fk_last_qa_value_supp_data_reporting_period;

ALTER TABLE IF EXISTS camdecmps.long_term_fuel_flow DROP CONSTRAINT IF EXISTS fk_long_term_fuel_flow_reporting_period;

ALTER TABLE IF EXISTS camdecmps.mats_derived_hrly_value DROP CONSTRAINT IF EXISTS fk_mats_derived_hrly_value_hrly_op_data;
ALTER TABLE IF EXISTS camdecmps.mats_derived_hrly_value DROP CONSTRAINT IF EXISTS fk_mats_derived_hrly_value_reporting_period;

ALTER TABLE IF EXISTS camdecmps.mats_monitor_hrly_value DROP CONSTRAINT IF EXISTS fk_mats_monitor_hrly_value_hrly_op_data;
ALTER TABLE IF EXISTS camdecmps.mats_monitor_hrly_value DROP CONSTRAINT IF EXISTS fk_mats_monitor_hrly_value_reporting_period;

ALTER TABLE IF EXISTS camdecmps.monitor_hrly_value DROP CONSTRAINT IF EXISTS fk_monitor_hrly_value_hrly_op_data;
ALTER TABLE IF EXISTS camdecmps.monitor_hrly_value DROP CONSTRAINT IF EXISTS fk_monitor_hrly_value_reporting_period;

ALTER TABLE IF EXISTS camdecmps.monitor_location DROP CONSTRAINT IF EXISTS fk_monitor_location_unit;

ALTER TABLE IF EXISTS camdecmps.monitor_plan DROP CONSTRAINT IF EXISTS fk_monitor_plan_plant;
ALTER TABLE IF EXISTS camdecmps.monitor_plan DROP CONSTRAINT IF EXISTS fk_monitor_plan_reporting_period_begin_rpt_period;
ALTER TABLE IF EXISTS camdecmps.monitor_plan DROP CONSTRAINT IF EXISTS fk_monitor_plan_reporting_period_end_rpt_period;

ALTER TABLE IF EXISTS camdecmps.monitor_plan_reporting_freq DROP CONSTRAINT IF EXISTS fk_monitor_plan_reporting_freq_begin_rpt_period;
ALTER TABLE IF EXISTS camdecmps.monitor_plan_reporting_freq DROP CONSTRAINT IF EXISTS fk_monitor_plan_reporting_freq_end_rpt_period;

ALTER TABLE IF EXISTS camdecmps.nsps4t_annual DROP CONSTRAINT IF EXISTS fk_nsps4t_annual_nsps4t_summary;
ALTER TABLE IF EXISTS camdecmps.nsps4t_annual DROP CONSTRAINT IF EXISTS fk_nsps4t_annual_reporting_period;

ALTER TABLE IF EXISTS camdecmps.nsps4t_compliance_period DROP CONSTRAINT IF EXISTS fk_nsps4t_compliance_period_nsps4t_summary;
ALTER TABLE IF EXISTS camdecmps.nsps4t_compliance_period DROP CONSTRAINT IF EXISTS fk_nsps4t_compliance_period_reporting_period;

ALTER TABLE IF EXISTS camdecmps.nsps4t_summary DROP CONSTRAINT IF EXISTS fk_nsps4t_summary_reporting_period;

ALTER TABLE IF EXISTS camdecmps.operating_supp_data DROP CONSTRAINT IF EXISTS fk_operating_supp_data_reporting_period;

ALTER TABLE IF EXISTS camdecmps.qa_cert_event_supp_data DROP CONSTRAINT IF EXISTS fk_qa_cert_event_supp_data_reporting_period;

ALTER TABLE IF EXISTS camdecmps.qa_supp_data DROP CONSTRAINT IF EXISTS fk_qa_supp_data_reporting_period;

ALTER TABLE IF EXISTS camdecmps.sampling_train DROP CONSTRAINT IF EXISTS fk_sampling_train_reporting_period;
ALTER TABLE IF EXISTS camdecmps.sampling_train DROP CONSTRAINT IF EXISTS fk_sampling_train_sorbent_trap;

ALTER TABLE IF EXISTS camdecmps.sampling_train_supp_data DROP CONSTRAINT IF EXISTS fk_sampling_train_supp_data_reporting_period;

ALTER TABLE IF EXISTS camdecmps.sorbent_trap DROP CONSTRAINT IF EXISTS fk_sorbent_trap_reporting_period;

ALTER TABLE IF EXISTS camdecmps.sorbent_trap_supp_data DROP CONSTRAINT IF EXISTS fk_sorbent_trap_supp_data_reporting_period;

ALTER TABLE IF EXISTS camdecmps.stack_pipe DROP CONSTRAINT IF EXISTS fk_stack_pipe_plant;

ALTER TABLE IF EXISTS camdecmps.summary_value DROP CONSTRAINT IF EXISTS fk_summary_value_reporting_period;

ALTER TABLE IF EXISTS camdecmps.system_op_supp_data DROP CONSTRAINT IF EXISTS fk_system_op_supp_data_reporting_period;

ALTER TABLE IF EXISTS camdecmps.test_extension_exemption DROP CONSTRAINT IF EXISTS fk_test_extension_exemption_reporting_period;

ALTER TABLE IF EXISTS camdecmps.test_summary DROP CONSTRAINT IF EXISTS fk_test_summary_reporting_period;

ALTER TABLE IF EXISTS camdecmps.unit_capacity DROP CONSTRAINT IF EXISTS fk_unit_capacity_unit;

ALTER TABLE IF EXISTS camdecmps.unit_control DROP CONSTRAINT IF EXISTS fk_unit_control_unit;

ALTER TABLE IF EXISTS camdecmps.unit_fuel DROP CONSTRAINT IF EXISTS fk_unit_fuel_unit;

ALTER TABLE IF EXISTS camdecmps.unit_stack_configuration DROP CONSTRAINT IF EXISTS fk_unit_stack_configuration_unit;

ALTER TABLE IF EXISTS camdecmps.weekly_system_integrity DROP CONSTRAINT IF EXISTS fk_weekly_system_integrity_reporting_period;
ALTER TABLE IF EXISTS camdecmps.weekly_system_integrity DROP CONSTRAINT IF EXISTS fk_weekly_system_integrity_weekly_test_summary;

ALTER TABLE IF EXISTS camdecmps.weekly_test_summary DROP CONSTRAINT IF EXISTS fk_weekly_test_summary_reporting_period;

ALTER TABLE IF EXISTS camdecmpsaux.apportionment DROP CONSTRAINT IF EXISTS fk_apportionment_begin_rpt_period_id;
ALTER TABLE IF EXISTS camdecmpsaux.apportionment DROP CONSTRAINT IF EXISTS fk_apportionment_end_rpt_period_id;

ALTER TABLE IF EXISTS camdecmpsaux.apportionment_data DROP CONSTRAINT IF EXISTS fk_apportionment_data_apportionment_range;

ALTER TABLE IF EXISTS camdecmpsaux.apportionment_range DROP CONSTRAINT IF EXISTS fk_apportionment_range_apportionment;

ALTER TABLE IF EXISTS camdecmpsaux.check_session DROP CONSTRAINT IF EXISTS fk_check_session_reporting_period;

ALTER TABLE IF EXISTS camdecmpsaux.em_submission_access DROP CONSTRAINT IF EXISTS fk_em_submission_access_reporting_period;

ALTER TABLE IF EXISTS camdecmpsaux.email_to_process DROP CONSTRAINT IF EXISTS fk_email_to_process_plant;
ALTER TABLE IF EXISTS camdecmpsaux.email_to_process DROP CONSTRAINT IF EXISTS fk_email_to_process_reporting_period;

ALTER TABLE IF EXISTS camdecmpsaux.es_spec DROP CONSTRAINT IF EXISTS fk_es_spec_check_catalog_result;
ALTER TABLE IF EXISTS camdecmpsaux.es_spec DROP CONSTRAINT IF EXISTS fk_es_spec_plant;

ALTER TABLE IF EXISTS camdecmpsaux.evaluation_queue DROP CONSTRAINT IF EXISTS fk_evaluation_queue_reporting_period;

ALTER TABLE IF EXISTS camdecmpsaux.evaluation_set DROP CONSTRAINT IF EXISTS fk_evaluation_set_plant;

ALTER TABLE IF EXISTS camdecmpsaux.import_queue DROP CONSTRAINT IF EXISTS fk_import_queue_reporting_period;

ALTER TABLE IF EXISTS camdecmpsaux.mats_data_submission DROP CONSTRAINT IF EXISTS fk_mats_data_submission_plant;

ALTER TABLE IF EXISTS camdecmpsaux.pdem_mats_monitor_hour DROP CONSTRAINT IF EXISTS pdem_mats_monitor_hour_prd_fk;

ALTER TABLE IF EXISTS camdecmpsaux.pdem_mats_unit_hour DROP CONSTRAINT IF EXISTS pdem_mats_unit_hour_loc_fk;
ALTER TABLE IF EXISTS camdecmpsaux.pdem_mats_unit_hour DROP CONSTRAINT IF EXISTS pdem_mats_unit_hour_prd_fk;

ALTER TABLE IF EXISTS camdecmpsaux.pdem_p75_monitor_hour DROP CONSTRAINT IF EXISTS pdem_p75_monitor_hour_prd_fk;

ALTER TABLE IF EXISTS camdecmpsaux.pdem_p75_unit_hour DROP CONSTRAINT IF EXISTS pdem_p75_unit_hour_loc_fk;
ALTER TABLE IF EXISTS camdecmpsaux.pdem_p75_unit_hour DROP CONSTRAINT IF EXISTS pdem_p75_unit_hour_prd_fk;

ALTER TABLE IF EXISTS camdecmpsaux.pdem_report DROP CONSTRAINT IF EXISTS pdem_report_prd_fk;

ALTER TABLE IF EXISTS camdecmpsaux.program_parameter DROP CONSTRAINT IF EXISTS fk_program_parameter_begin_rpt_period;
ALTER TABLE IF EXISTS camdecmpsaux.program_parameter DROP CONSTRAINT IF EXISTS fk_program_parameter_end_rpt_period;
ALTER TABLE IF EXISTS camdecmpsaux.program_parameter DROP CONSTRAINT IF EXISTS fk_program_parameter_program;

ALTER TABLE IF EXISTS camdecmpsaux.submission_queue DROP CONSTRAINT IF EXISTS fk_submission_queue_reporting_period;

ALTER TABLE IF EXISTS camdecmpsaux.submission_set DROP CONSTRAINT IF EXISTS fk_submission_set_plant;

ALTER TABLE IF EXISTS camdecmpscalc.component_op_supp_data DROP CONSTRAINT IF EXISTS fk_component_op_supp_data_reporting_period;

ALTER TABLE IF EXISTS camdecmpscalc.daily_test_supp_data DROP CONSTRAINT IF EXISTS fk_daily_test_supp_data_reporting_period;

ALTER TABLE IF EXISTS camdecmpscalc.daily_test_system_supp_data DROP CONSTRAINT IF EXISTS fk_daily_test_system_supp_data_reporting_period;

ALTER TABLE IF EXISTS camdecmpscalc.last_qa_value_supp_data DROP CONSTRAINT IF EXISTS fk_last_qa_value_supp_data_reporting_period;

ALTER TABLE IF EXISTS camdecmpscalc.operating_supp_data DROP CONSTRAINT IF EXISTS fk_operating_supp_data_reporting_period;

ALTER TABLE IF EXISTS camdecmpscalc.qa_cert_event_supp_data DROP CONSTRAINT IF EXISTS fk_qa_cert_event_supp_data_reporting_period;

ALTER TABLE IF EXISTS camdecmpscalc.qa_supp_data DROP CONSTRAINT IF EXISTS fk_qa_supp_data_reporting_period;

ALTER TABLE IF EXISTS camdecmpscalc.summary_value DROP CONSTRAINT IF EXISTS fk_summary_value_reporting_period;

ALTER TABLE IF EXISTS camdecmpscalc.system_op_supp_data DROP CONSTRAINT IF EXISTS fk_system_op_supp_data_reporting_period;

ALTER TABLE IF EXISTS camdecmpsmd.check_catalog_parameter DROP CONSTRAINT IF EXISTS fk_check_catalog_parameter_check_catalog;

ALTER TABLE IF EXISTS camdecmpsmd.check_catalog_plugin DROP CONSTRAINT IF EXISTS fk_check_catalog_plugin_check_catalog;

ALTER TABLE IF EXISTS camdecmpsmd.earliest_partition_quarter DROP CONSTRAINT IF EXISTS fk_rpt_period_id;

ALTER TABLE IF EXISTS camdecmpsmd.rule_check DROP CONSTRAINT IF EXISTS pk_rule_check_check_catalog;

ALTER TABLE IF EXISTS camdecmpsmd.rule_check_condition DROP CONSTRAINT IF EXISTS fk_rule_check_condition_rule_check;

ALTER TABLE IF EXISTS camdecmpswks.check_session DROP CONSTRAINT IF EXISTS fk_check_session_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.component_op_supp_data DROP CONSTRAINT IF EXISTS fk_component_op_supp_data_prd;

ALTER TABLE IF EXISTS camdecmpswks.daily_backstop DROP CONSTRAINT IF EXISTS fk_daily_backstop_reporting_period;
ALTER TABLE IF EXISTS camdecmpswks.daily_backstop DROP CONSTRAINT IF EXISTS fk_daily_backstop_unit;

ALTER TABLE IF EXISTS camdecmpswks.daily_calibration DROP CONSTRAINT IF EXISTS fk_daily_calibration_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.daily_emission DROP CONSTRAINT IF EXISTS fk_daily_emission_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.daily_fuel DROP CONSTRAINT IF EXISTS fk_daily_fuel_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.daily_test_summary DROP CONSTRAINT IF EXISTS fk_daily_test_summary_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.daily_test_supp_data DROP CONSTRAINT IF EXISTS fk_daily_test_supp_data_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.daily_test_system_supp_data DROP CONSTRAINT IF EXISTS fk_daily_test_sys_sup_data_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.derived_hrly_value DROP CONSTRAINT IF EXISTS fk_derived_hrly_value_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.emission_evaluation DROP CONSTRAINT IF EXISTS fk_emission_evaluation_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.emission_view_all DROP CONSTRAINT IF EXISTS fk_emission_view_all_emission_evaluation;
ALTER TABLE IF EXISTS camdecmpswks.emission_view_all DROP CONSTRAINT IF EXISTS fk_emission_view_all_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.emission_view_co2appd DROP CONSTRAINT IF EXISTS fk_emission_view_co2appd_emission_evaluation;
ALTER TABLE IF EXISTS camdecmpswks.emission_view_co2appd DROP CONSTRAINT IF EXISTS fk_emission_view_co2appd_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.emission_view_co2calc DROP CONSTRAINT IF EXISTS fk_emission_view_co2calc_emission_evaluation;
ALTER TABLE IF EXISTS camdecmpswks.emission_view_co2calc DROP CONSTRAINT IF EXISTS fk_emission_view_co2calc_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.emission_view_co2cems DROP CONSTRAINT IF EXISTS fk_emission_view_co2cems_emission_evaluation;
ALTER TABLE IF EXISTS camdecmpswks.emission_view_co2cems DROP CONSTRAINT IF EXISTS fk_emission_view_co2cems_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.emission_view_co2dailyfuel DROP CONSTRAINT IF EXISTS fk_emission_view_co2dailyfuel_emission_evaluation;
ALTER TABLE IF EXISTS camdecmpswks.emission_view_co2dailyfuel DROP CONSTRAINT IF EXISTS fk_emission_view_co2dailyfuel_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.emission_view_count DROP CONSTRAINT IF EXISTS fk_emission_view_count_emission_evaluation;
ALTER TABLE IF EXISTS camdecmpswks.emission_view_count DROP CONSTRAINT IF EXISTS fk_emission_view_count_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.emission_view_dailycal DROP CONSTRAINT IF EXISTS fk_emission_view_dailycal_emission_evaluation;
ALTER TABLE IF EXISTS camdecmpswks.emission_view_dailycal DROP CONSTRAINT IF EXISTS fk_emission_view_dailycal_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.emission_view_hiappd DROP CONSTRAINT IF EXISTS fk_emission_view_hiappd_emission_evaluation;
ALTER TABLE IF EXISTS camdecmpswks.emission_view_hiappd DROP CONSTRAINT IF EXISTS fk_emission_view_hiappd_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.emission_view_hicems DROP CONSTRAINT IF EXISTS fk_emission_view_hicems_emission_evaluation;
ALTER TABLE IF EXISTS camdecmpswks.emission_view_hicems DROP CONSTRAINT IF EXISTS fk_emission_view_hicems_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.emission_view_hiunitstack DROP CONSTRAINT IF EXISTS fk_emission_view_hiunitstack_emission_evaluation;
ALTER TABLE IF EXISTS camdecmpswks.emission_view_hiunitstack DROP CONSTRAINT IF EXISTS fk_emission_view_hiunitstack_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.emission_view_lme DROP CONSTRAINT IF EXISTS fk_emission_view_lme_emission_evaluation;
ALTER TABLE IF EXISTS camdecmpswks.emission_view_lme DROP CONSTRAINT IF EXISTS fk_emission_view_lme_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.emission_view_massoilcalc DROP CONSTRAINT IF EXISTS fk_emission_view_massoilcalc_emission_evaluation;
ALTER TABLE IF EXISTS camdecmpswks.emission_view_massoilcalc DROP CONSTRAINT IF EXISTS fk_emission_view_massoilcalc_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.emission_view_matshcl DROP CONSTRAINT IF EXISTS fk_emission_view_matshcl_emission_evaluation;
ALTER TABLE IF EXISTS camdecmpswks.emission_view_matshcl DROP CONSTRAINT IF EXISTS fk_emission_view_matshcl_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.emission_view_matshf DROP CONSTRAINT IF EXISTS fk_emission_view_matshf_emission_evaluation;
ALTER TABLE IF EXISTS camdecmpswks.emission_view_matshf DROP CONSTRAINT IF EXISTS fk_emission_view_matshf_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.emission_view_matshg DROP CONSTRAINT IF EXISTS fk_emission_view_matshg_emission_evaluation;
ALTER TABLE IF EXISTS camdecmpswks.emission_view_matshg DROP CONSTRAINT IF EXISTS fk_emission_view_matshg_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.emission_view_matsso2 DROP CONSTRAINT IF EXISTS fk_emission_view_matsso2_emission_evaluation;
ALTER TABLE IF EXISTS camdecmpswks.emission_view_matsso2 DROP CONSTRAINT IF EXISTS fk_emission_view_matsso2_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.emission_view_matssorbent DROP CONSTRAINT IF EXISTS fk_emission_view_matssorbent_emission_evaluation;
ALTER TABLE IF EXISTS camdecmpswks.emission_view_matssorbent DROP CONSTRAINT IF EXISTS fk_emission_view_matssorbent_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.emission_view_matsweekly DROP CONSTRAINT IF EXISTS fk_emission_view_matsweekly_emission_evaluation;
ALTER TABLE IF EXISTS camdecmpswks.emission_view_matsweekly DROP CONSTRAINT IF EXISTS fk_emission_view_matsweekly_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.emission_view_moisture DROP CONSTRAINT IF EXISTS fk_emission_view_moisture_emission_evaluation;
ALTER TABLE IF EXISTS camdecmpswks.emission_view_moisture DROP CONSTRAINT IF EXISTS fk_emission_view_moisture_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.emission_view_noxappemixedfuel DROP CONSTRAINT IF EXISTS fk_emission_view_noxappemixedfuel_emission_evaluation;
ALTER TABLE IF EXISTS camdecmpswks.emission_view_noxappemixedfuel DROP CONSTRAINT IF EXISTS fk_emission_view_noxappemixedfuel_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.emission_view_noxappesinglefuel DROP CONSTRAINT IF EXISTS fk_emission_view_noxappesinglefuel_emission_evaluation;
ALTER TABLE IF EXISTS camdecmpswks.emission_view_noxappesinglefuel DROP CONSTRAINT IF EXISTS fk_emission_view_noxappesinglefuel_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.emission_view_noxmasscems DROP CONSTRAINT IF EXISTS fk_emission_view_noxmasscems_emission_evaluation;
ALTER TABLE IF EXISTS camdecmpswks.emission_view_noxmasscems DROP CONSTRAINT IF EXISTS fk_emission_view_noxmasscems_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.emission_view_noxratecems DROP CONSTRAINT IF EXISTS fk_emission_view_noxratecems_emission_evaluation;
ALTER TABLE IF EXISTS camdecmpswks.emission_view_noxratecems DROP CONSTRAINT IF EXISTS fk_emission_view_noxratecems_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.emission_view_otherdaily DROP CONSTRAINT IF EXISTS fk_emission_view_otherdaily_emission_evaluation;
ALTER TABLE IF EXISTS camdecmpswks.emission_view_otherdaily DROP CONSTRAINT IF EXISTS fk_emission_view_otherdaily_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.emission_view_so2appd DROP CONSTRAINT IF EXISTS fk_emission_view_so2appd_emission_evaluation;
ALTER TABLE IF EXISTS camdecmpswks.emission_view_so2appd DROP CONSTRAINT IF EXISTS fk_emission_view_so2appd_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.emission_view_so2cems DROP CONSTRAINT IF EXISTS fk_emission_view_so2cems_emission_evaluation;
ALTER TABLE IF EXISTS camdecmpswks.emission_view_so2cems DROP CONSTRAINT IF EXISTS fk_emission_view_so2cems_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.hrly_fuel_flow DROP CONSTRAINT IF EXISTS fk_hrly_fuel_flow_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.hrly_gas_flow_meter DROP CONSTRAINT IF EXISTS fk_hrly_gas_flow_meter_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.hrly_op_data DROP CONSTRAINT IF EXISTS fk_hrly_op_data_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.hrly_param_fuel_flow DROP CONSTRAINT IF EXISTS fk_hrly_param_fuel_flow_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.last_qa_value_supp_data DROP CONSTRAINT IF EXISTS fk_last_qa_value_supp_data_pr;

ALTER TABLE IF EXISTS camdecmpswks.long_term_fuel_flow DROP CONSTRAINT IF EXISTS fk_long_term_fuel_flow_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.mats_bulk_file DROP CONSTRAINT IF EXISTS fk_mats_bulk_file_plant;

ALTER TABLE IF EXISTS camdecmpswks.mats_derived_hrly_value DROP CONSTRAINT IF EXISTS fk_mats_derived_hrly_value_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.mats_monitor_hrly_value DROP CONSTRAINT IF EXISTS fk_mats_monitor_hrly_value_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.monitor_hrly_value DROP CONSTRAINT IF EXISTS fk_monitor_hrly_value_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.monitor_location DROP CONSTRAINT IF EXISTS fk_monitor_location_unit;

ALTER TABLE IF EXISTS camdecmpswks.monitor_plan DROP CONSTRAINT IF EXISTS fk_monitor_plan_plant;
ALTER TABLE IF EXISTS camdecmpswks.monitor_plan DROP CONSTRAINT IF EXISTS fk_monitor_plan_reporting_period_begin_rpt_period;
ALTER TABLE IF EXISTS camdecmpswks.monitor_plan DROP CONSTRAINT IF EXISTS fk_monitor_plan_reporting_period_end_rpt_period;

ALTER TABLE IF EXISTS camdecmpswks.monitor_plan_reporting_freq DROP CONSTRAINT IF EXISTS fk_monitor_plan_reporting_freq_begin_rpt_period;
ALTER TABLE IF EXISTS camdecmpswks.monitor_plan_reporting_freq DROP CONSTRAINT IF EXISTS fk_monitor_plan_reporting_freq_end_rpt_period;

ALTER TABLE IF EXISTS camdecmpswks.nsps4t_annual DROP CONSTRAINT IF EXISTS fk_nsps4t_annual_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.nsps4t_compliance_period DROP CONSTRAINT IF EXISTS fk_nsps4t_compliance_period_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.nsps4t_summary DROP CONSTRAINT IF EXISTS fk_nsps4t_summary_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.operating_supp_data DROP CONSTRAINT IF EXISTS fk_operating_supp_data_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.qa_supp_data DROP CONSTRAINT IF EXISTS fk_qa_supp_data_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.sampling_train DROP CONSTRAINT IF EXISTS fk_sampling_train_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.sampling_train_supp_data DROP CONSTRAINT IF EXISTS fk_sampling_train_supp_data_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.sorbent_trap DROP CONSTRAINT IF EXISTS fk_sorbent_trap_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.sorbent_trap_supp_data DROP CONSTRAINT IF EXISTS fk_sorbent_trap_supp_data_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.stack_pipe DROP CONSTRAINT IF EXISTS fk_stack_pipe_plant;

ALTER TABLE IF EXISTS camdecmpswks.summary_value DROP CONSTRAINT IF EXISTS fk_summary_value_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.system_op_supp_data DROP CONSTRAINT IF EXISTS fk_system_op_supp_data_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.test_extension_exemption DROP CONSTRAINT IF EXISTS fk_test_extension_exemption_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.test_summary DROP CONSTRAINT IF EXISTS fk_test_summary_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.unit DROP CONSTRAINT IF EXISTS fk_unit_plant;

ALTER TABLE IF EXISTS camdecmpswks.unit_capacity DROP CONSTRAINT IF EXISTS fk_unit_capacity_unit;

ALTER TABLE IF EXISTS camdecmpswks.unit_control DROP CONSTRAINT IF EXISTS fk_unit_control_unit;

ALTER TABLE IF EXISTS camdecmpswks.unit_fuel DROP CONSTRAINT IF EXISTS fk_unit_fuel_unit;

ALTER TABLE IF EXISTS camdecmpswks.unit_stack_configuration DROP CONSTRAINT IF EXISTS fk_unit_stack_configuration_unit;

ALTER TABLE IF EXISTS camdecmpswks.weekly_system_integrity DROP CONSTRAINT IF EXISTS fk_weekly_system_integrity_reporting_period;

ALTER TABLE IF EXISTS camdecmpswks.weekly_test_summary DROP CONSTRAINT IF EXISTS fk_weekly_test_summary_reporting_period;

COMMIT;
