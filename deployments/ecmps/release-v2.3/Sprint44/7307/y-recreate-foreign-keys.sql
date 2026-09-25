-- PostgreSQL foreign-key recreation script for DBeaver.
-- Run after all bigint ALTER scripts and before z-recreate-dependent-views.sql.

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
