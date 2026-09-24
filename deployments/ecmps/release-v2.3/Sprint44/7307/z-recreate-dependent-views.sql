-- PostgreSQL foreign-key and view recreation script for psql.
-- Run this file from deployments\ecmps\release-v2.3\Sprint44\7307 after all bigint ALTER scripts.
-- Foreign keys are recreated before the included view files execute in dependency order.
-- The units-expected function is recreated after its dependent views.
-- Then run the camdsnap scripts to recreate the affected materialized views and indexes.

\set ON_ERROR_STOP on

-- Foreign keys that reference converted columns

BEGIN;

ALTER TABLE IF EXISTS camd.generator ADD CONSTRAINT fk_generator_plant FOREIGN KEY (fac_id) REFERENCES camd.plant (fac_id);

ALTER TABLE IF EXISTS camd.plant_person ADD CONSTRAINT fk_plant_person_plant FOREIGN KEY (fac_id) REFERENCES camd.plant (fac_id);

ALTER TABLE IF EXISTS camd.program_phase ADD CONSTRAINT fk_program_phase_program FOREIGN KEY (prg_id) REFERENCES camd.program (prg_id);

ALTER TABLE IF EXISTS camd.unit ADD CONSTRAINT fk_unit_plant FOREIGN KEY (fac_id) REFERENCES camd.plant (fac_id);

ALTER TABLE IF EXISTS camd.unit_boiler_type ADD CONSTRAINT fk_unit_boiler_type_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);

ALTER TABLE IF EXISTS camd.unit_exemption ADD CONSTRAINT fk_unit_exemption_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);

ALTER TABLE IF EXISTS camd.unit_generator ADD CONSTRAINT fk_unit_generator_generator FOREIGN KEY (gen_id) REFERENCES camd.generator (gen_id);
ALTER TABLE IF EXISTS camd.unit_generator ADD CONSTRAINT fk_unit_generator_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);

ALTER TABLE IF EXISTS camd.unit_op_status ADD CONSTRAINT fk_unit_op_status_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);

ALTER TABLE IF EXISTS camd.unit_program ADD CONSTRAINT fk_unit_program_program FOREIGN KEY (prg_id) REFERENCES camd.program (prg_id);
ALTER TABLE IF EXISTS camd.unit_program ADD CONSTRAINT fk_unit_program_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);

ALTER TABLE IF EXISTS camdaux.inventory_status_log ADD CONSTRAINT fk_inventory_status_log_plant FOREIGN KEY (fac_id) REFERENCES camd.plant (fac_id);
ALTER TABLE IF EXISTS camdaux.inventory_status_log ADD CONSTRAINT fk_inventory_status_log_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);

ALTER TABLE IF EXISTS camdecmps.daily_backstop ADD CONSTRAINT fk_daily_backstop_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);

ALTER TABLE IF EXISTS camdecmps.dm_emissions ADD CONSTRAINT fk_dm_emissions_plant FOREIGN KEY (fac_id) REFERENCES camd.plant (fac_id);

ALTER TABLE IF EXISTS camdecmps.monitor_location ADD CONSTRAINT fk_monitor_location_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);

ALTER TABLE IF EXISTS camdecmps.monitor_plan ADD CONSTRAINT fk_monitor_plan_plant FOREIGN KEY (fac_id) REFERENCES camd.plant (fac_id);

ALTER TABLE IF EXISTS camdecmps.stack_pipe ADD CONSTRAINT fk_stack_pipe_plant FOREIGN KEY (fac_id) REFERENCES camd.plant (fac_id);

ALTER TABLE IF EXISTS camdecmps.unit_capacity ADD CONSTRAINT fk_unit_capacity_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);

ALTER TABLE IF EXISTS camdecmps.unit_control ADD CONSTRAINT fk_unit_control_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);

ALTER TABLE IF EXISTS camdecmps.unit_fuel ADD CONSTRAINT fk_unit_fuel_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);

ALTER TABLE IF EXISTS camdecmps.unit_stack_configuration ADD CONSTRAINT fk_unit_stack_configuration_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);

ALTER TABLE IF EXISTS camdecmpsaux.apportionment_data ADD CONSTRAINT fk_apportionment_data_apportionment_range FOREIGN KEY (apport_range_id) REFERENCES camdecmpsaux.apportionment_range (apport_range_id) ON DELETE CASCADE;

ALTER TABLE IF EXISTS camdecmpsaux.apportionment_range ADD CONSTRAINT fk_apportionment_range_apportionment FOREIGN KEY (apport_id) REFERENCES camdecmpsaux.apportionment (apport_id) ON DELETE CASCADE;

ALTER TABLE IF EXISTS camdecmpsaux.email_to_process ADD CONSTRAINT fk_email_to_process_plant FOREIGN KEY (fac_id) REFERENCES camd.plant (fac_id);

ALTER TABLE IF EXISTS camdecmpsaux.es_spec ADD CONSTRAINT fk_es_spec_check_catalog_result FOREIGN KEY (check_catalog_result_id) REFERENCES camdecmpsmd.check_catalog_result (check_catalog_result_id);
ALTER TABLE IF EXISTS camdecmpsaux.es_spec ADD CONSTRAINT fk_es_spec_plant FOREIGN KEY (fac_id) REFERENCES camd.plant (fac_id);

ALTER TABLE IF EXISTS camdecmpsaux.evaluation_set ADD CONSTRAINT fk_evaluation_set_plant FOREIGN KEY (fac_id) REFERENCES camd.plant (fac_id);

ALTER TABLE IF EXISTS camdecmpsaux.mats_data_submission ADD CONSTRAINT fk_mats_data_submission_plant FOREIGN KEY (fac_id) REFERENCES camd.plant (fac_id);

ALTER TABLE IF EXISTS camdecmpsaux.pdem_mats_unit_hour ADD CONSTRAINT pdem_mats_unit_hour_loc_fk FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);

ALTER TABLE IF EXISTS camdecmpsaux.pdem_p75_unit_hour ADD CONSTRAINT pdem_p75_unit_hour_loc_fk FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);

ALTER TABLE IF EXISTS camdecmpsaux.program_parameter ADD CONSTRAINT fk_program_parameter_program FOREIGN KEY (prg_id) REFERENCES camd.program (prg_id);

ALTER TABLE IF EXISTS camdecmpsaux.submission_set ADD CONSTRAINT fk_submission_set_plant FOREIGN KEY (fac_id) REFERENCES camd.plant (fac_id);

ALTER TABLE IF EXISTS camdecmpsmd.check_catalog_parameter ADD CONSTRAINT fk_check_catalog_parameter_check_catalog FOREIGN KEY (check_catalog_id) REFERENCES camdecmpsmd.check_catalog (check_catalog_id);

ALTER TABLE IF EXISTS camdecmpsmd.check_catalog_plugin ADD CONSTRAINT fk_check_catalog_plugin_check_catalog FOREIGN KEY (check_catalog_id) REFERENCES camdecmpsmd.check_catalog (check_catalog_id);

ALTER TABLE IF EXISTS camdecmpsmd.rule_check ADD CONSTRAINT pk_rule_check_check_catalog FOREIGN KEY (check_catalog_id) REFERENCES camdecmpsmd.check_catalog (check_catalog_id);

ALTER TABLE IF EXISTS camdecmpsmd.rule_check_condition ADD CONSTRAINT fk_rule_check_condition_rule_check FOREIGN KEY (rule_check_id) REFERENCES camdecmpsmd.rule_check (rule_check_id);

ALTER TABLE IF EXISTS camdecmpswks.daily_backstop ADD CONSTRAINT fk_daily_backstop_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);

ALTER TABLE IF EXISTS camdecmpswks.mats_bulk_file ADD CONSTRAINT fk_mats_bulk_file_plant FOREIGN KEY (fac_id) REFERENCES camd.plant (fac_id);

ALTER TABLE IF EXISTS camdecmpswks.monitor_location ADD CONSTRAINT fk_monitor_location_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);

ALTER TABLE IF EXISTS camdecmpswks.monitor_plan ADD CONSTRAINT fk_monitor_plan_plant FOREIGN KEY (fac_id) REFERENCES camd.plant (fac_id);

ALTER TABLE IF EXISTS camdecmpswks.stack_pipe ADD CONSTRAINT fk_stack_pipe_plant FOREIGN KEY (fac_id) REFERENCES camd.plant (fac_id);

ALTER TABLE IF EXISTS camdecmpswks.unit ADD CONSTRAINT fk_unit_plant FOREIGN KEY (fac_id) REFERENCES camd.plant (fac_id);

ALTER TABLE IF EXISTS camdecmpswks.unit_capacity ADD CONSTRAINT fk_unit_capacity_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);

ALTER TABLE IF EXISTS camdecmpswks.unit_control ADD CONSTRAINT fk_unit_control_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);

ALTER TABLE IF EXISTS camdecmpswks.unit_fuel ADD CONSTRAINT fk_unit_fuel_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);

ALTER TABLE IF EXISTS camdecmpswks.unit_stack_configuration ADD CONSTRAINT fk_unit_stack_configuration_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);

COMMIT;

\i ..\..\..\..\..\camdaux\views\vw_annual_emissions_bulk_files_per_state_to_generate.sql
\i ..\..\..\..\..\camdaux\views\vw_annual_facility_bulk_files_to_generate.sql
\i ..\..\..\..\..\camddmw\views\2-vw_facility_unit_attributes.sql
\i ..\..\..\..\..\camdecmps\views\emission_view_counts.sql
\i ..\..\..\..\..\camdecmps\views\emission_view_dailybackstop.sql
\i ..\..\..\..\..\camdecmps\views\vw_em_export_and_report.sql
\i ..\..\..\..\..\camdecmps\views\vw_em_reporting_status.sql
\i ..\..\..\..\..\camdecmps\views\vw_monitor_plan.sql
\i ..\..\..\..\..\camdecmps\views\vw_inconsistent_mprf_dates.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_monitor_plan_location.sql
\i ..\..\..\..\..\camdecmps\views\vw_locations_in_multiple_mps.sql
\i ..\..\..\..\..\camdecmps\views\vw_monitor_location.sql
\i ..\..\..\..\..\camdecmps\views\vw_mp_em_inconsistencies.sql
\i ..\..\..\..\..\camdecmps\views\vw_mp_unit_stack_configuration.sql
\i ..\..\..\..\..\camdecmps\views\vw_qa_cert_event_eval_and_submit.sql
\i ..\..\..\..\..\camdecmps\views\vw_qa_cert_event_maintenance.sql
\i ..\..\..\..\..\camdecmps\views\vw_qa_test_extens_exempt_maintenance.sql
\i ..\..\..\..\..\camdecmps\views\vw_qa_test_summary_maintenance.sql
\i ..\..\..\..\..\camdecmps\views\vw_test_extension_exemption_eval_and_submit.sql
\i ..\..\..\..\..\camdecmps\views\vw_test_summary_eval_and_submit.sql
\i ..\..\..\..\..\camdecmps\views\vw_unit_program_exemption.sql
\i ..\..\..\..\..\camdecmpsaux\views\vw_combined_submissions.sql
\i ..\..\..\..\..\camdecmpsaux\views\vw_em_submission_access.sql
\i ..\..\..\..\..\camdecmpsaux\views\vw_submission_list.sql
\i ..\..\..\..\..\camdecmpsaux\views\vw_submission_window_job_close.sql
\i ..\..\..\..\..\camdecmpsaux\views\vw_submission_window_job_open.sql
\i ..\..\..\..\..\camdecmpsmd\views\vw_check_catalog_plugin.sql
\i ..\..\..\..\..\camdecmpsmd\views\vw_check_catalog_result.sql
\i ..\..\..\..\..\camdecmpsmd\views\vw_emission_api_check_catalog_results.sql
\i ..\..\..\..\..\camdecmpsmd\views\vw_es_check_catalog_result.sql
\i ..\..\..\..\..\camdecmpsmd\views\vw_es_parameter_code.sql
\i ..\..\..\..\..\camdecmpsmd\views\vw_monitor_plan_api_check_catalog_results.sql
\i ..\..\..\..\..\camdecmpsmd\views\vw_qa_certification_api_check_catalog_results.sql
\i ..\..\..\..\..\camdecmpsmd\views\vw_rule_check.sql
\i ..\..\..\..\..\camdecmpsmd\views\vw_rule_check_condition.sql
\i ..\..\..\..\..\camdecmpsmd\views\vw_rule_check_parameter.sql
\i ..\..\..\..\..\camdecmpswks\views\emission_view_counts.sql
\i ..\..\..\..\..\camdecmpswks\views\emission_view_dailybackstop.sql
\i ..\..\..\..\..\camdecmpswks\views\1-vw_monitor_location.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_analyzer_range.sql
\i ..\..\..\..\..\camdecmpswks\views\2-vw_location_program.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_ce_mp_monitor_location.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_component.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_em_evaluate.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_em_export_and_report.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_em_submit.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_evem_dhv_total_and_april_load.sql
\i ..\..\..\..\..\camdecmpswks\views\1-vw_monitor_location_merged.sql
\i ..\..\..\..\..\camdecmpswks\views\2-vw_mp_monitor_location.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_evem_long_term_fuel_flow.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_evem_summary_value.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_location_attribute.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_location_capacity.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_location_control.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_location_fuel.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_location_operating_status.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_location_reporting_frequency.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_location_unit_type.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_monitor_default.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_monitor_formula.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_monitor_load.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_monitor_method.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_monitor_plan_comment.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_monitor_qualification.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_monitor_qualification_lme.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_monitor_qualification_pct.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_monitor_span.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_monitor_system.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_monitor_system_component.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_analyzer_range.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_component.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_daily_emission.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_daily_fuel.sql
\i ..\..\..\..\..\camdecmpswks\views\3-vw_mp_hrly_op_data.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_derived_hrly_value.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_derived_hrly_value_co2.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_derived_hrly_value_co2c.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_derived_hrly_value_h2o.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_derived_hrly_value_hi.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_derived_hrly_value_lme.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_derived_hrly_value_nox.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_derived_hrly_value_noxr.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_derived_hrly_value_so2.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_derived_hrly_value_so2r.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_evaluation_results.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_hrly_fuel_flow.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_hrly_param_fuel_flow.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_location.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_location_attribute.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_location_capacity.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_location_fuel.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_location_program.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_location_unit_type.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_locations_and_unit_stack_configurations.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_monitor_default.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_monitor_default_co2n_nfs.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_monitor_default_co2x.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_monitor_default_h2o.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_monitor_default_mngf.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_monitor_default_mnof.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_monitor_default_mxff.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_monitor_default_norx.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_monitor_default_o2x.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_monitor_default_so2c.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_monitor_default_so2r_f23.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_monitor_default_so2x.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_monitor_formula.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_monitor_formula_so2.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_monitor_hrly_value.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_monitor_hrly_value_co2c.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_monitor_hrly_value_flow.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_monitor_hrly_value_h2o.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_monitor_hrly_value_noxc.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_monitor_hrly_value_o2_dry.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_monitor_hrly_value_o2_null.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_monitor_hrly_value_o2_wet.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_monitor_load.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_monitor_method.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_monitor_method_missing_data_fsp.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_monitor_plan.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_monitor_qualification.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_monitor_span.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_monitor_span_co2.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_monitor_span_flow.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_monitor_span_nox.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_monitor_span_so2.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_op_supp_data.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_operating_status.sql
\i ..\..\..\..\..\camdecmpswks\views\1-vw_unit_program_exemption.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_program_exemption.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_qa_supp_attribute.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_unit_capacity.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_unit_program.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_mp_unit_stack_configuration.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_program_parameter.sql
\i ..\..\..\..\..\camdecmpswks\views\2-vw_qa_test_summary_appe.sql
\i ..\..\..\..\..\camdecmpswks\views\3-vw_qa_ae_correlation_test_sum.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_qa_ae_correlation_test_run.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_qa_ae_hi_gas.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_qa_ae_hi_oil.sql
\i ..\..\..\..\..\camdecmpswks\views\2-vw_qa_test_summary_7day.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_qa_calibration_injection.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_qa_cert_event.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_qa_cert_event_eval_and_submit.sql
\i ..\..\..\..\..\camdecmpswks\views\2-vw_qa_test_summary_cycle.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_qa_cycle_time_injection.sql
\i ..\..\..\..\..\camdecmpswks\views\2-vw_qa_test_summary_rata.sql
\i ..\..\..\..\..\camdecmpswks\views\3-vw_qa_rata_summary.sql
\i ..\..\..\..\..\camdecmpswks\views\4-vw_qa_rata_run.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_qa_flow_rata_run.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_qa_rata_traverse.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_qa_supp_attribute.sql
\i ..\..\..\..\..\camdecmpswks\views\2-vw_qa_supp_data.sql
\i ..\..\..\..\..\camdecmpswks\views\2-vw_qa_test_summary.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_qa_supp_data_hourly_status.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_qa_test_claim.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_qa_test_extension_exemption.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_qa_test_summary_f2lchk.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_qa_test_summary_f2lref.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_qa_test_summary_ff2lbas.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_qa_test_summary_ff2ltst.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_qa_test_summary_ffacc.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_qa_test_summary_ffacctt.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_qa_test_summary_line.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_qa_test_summary_onoff.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_qa_test_summary_unitdef.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_qa_unit_default_test_run.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_rect_duct_waf.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_rpt_monitoring_plan_unit_stack_config.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_stack_pipe.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_system_analyzer_range.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_system_fuel_flow.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_test_extension_exemption_eval_and_submit.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_test_summary_eval_and_submit.sql
\i ..\..\..\..\..\camdecmpswks\views\2-vw_unit_stack_configuration.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_unit_monitor_system.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_unit_op_status.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_unit_reporting_period.sql
\i ..\..\..\..\..\camdecmpswks\views\vw_used_identifier.sql
\i ..\..\..\..\..\camdecmpsaux\functions\get_units_expected_to_submit_report_data.sql
