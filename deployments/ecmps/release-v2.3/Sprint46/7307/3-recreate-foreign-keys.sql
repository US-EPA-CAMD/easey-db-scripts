-- recreate foreign keys for the 43 converted ID columns.
-- Run after 2-alter-numeric-id-columns-to-integer.sql.

BEGIN;

ALTER TABLE camd.generator ADD CONSTRAINT fk_generator_plant FOREIGN KEY (fac_id) REFERENCES camd.plant (fac_id);
ALTER TABLE camd.plant_person ADD CONSTRAINT fk_plant_person_plant FOREIGN KEY (fac_id) REFERENCES camd.plant (fac_id);
ALTER TABLE camd.program_phase ADD CONSTRAINT fk_program_phase_program FOREIGN KEY (prg_id) REFERENCES camd.program (prg_id);
ALTER TABLE camd.unit ADD CONSTRAINT fk_unit_plant FOREIGN KEY (fac_id) REFERENCES camd.plant (fac_id);
ALTER TABLE camd.unit_boiler_type ADD CONSTRAINT fk_unit_boiler_type_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);
ALTER TABLE camd.unit_exemption ADD CONSTRAINT fk_unit_exemption_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);
ALTER TABLE camd.unit_generator ADD CONSTRAINT fk_unit_generator_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);
ALTER TABLE camd.unit_op_status ADD CONSTRAINT fk_unit_op_status_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);
ALTER TABLE camd.unit_program ADD CONSTRAINT fk_unit_program_program FOREIGN KEY (prg_id) REFERENCES camd.program (prg_id);
ALTER TABLE camd.unit_program ADD CONSTRAINT fk_unit_program_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);
ALTER TABLE camdaux.inventory_status_log ADD CONSTRAINT fk_inventory_status_log_plant FOREIGN KEY (fac_id) REFERENCES camd.plant (fac_id);
ALTER TABLE camdaux.inventory_status_log ADD CONSTRAINT fk_inventory_status_log_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);

ALTER TABLE camdecmps.daily_backstop ADD CONSTRAINT fk_daily_backstop_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);
ALTER TABLE camdecmps.dm_emissions ADD CONSTRAINT fk_dm_emissions_plant FOREIGN KEY (fac_id) REFERENCES camd.plant (fac_id);
ALTER TABLE camdecmps.monitor_location ADD CONSTRAINT fk_monitor_location_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);
ALTER TABLE camdecmps.monitor_plan ADD CONSTRAINT fk_monitor_plan_plant FOREIGN KEY (fac_id) REFERENCES camd.plant (fac_id);
ALTER TABLE camdecmps.stack_pipe ADD CONSTRAINT fk_stack_pipe_plant FOREIGN KEY (fac_id) REFERENCES camd.plant (fac_id);
ALTER TABLE camdecmps.unit_capacity ADD CONSTRAINT fk_unit_capacity_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);
ALTER TABLE camdecmps.unit_control ADD CONSTRAINT fk_unit_control_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);
ALTER TABLE camdecmps.unit_fuel ADD CONSTRAINT fk_unit_fuel_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);
ALTER TABLE camdecmps.unit_stack_configuration ADD CONSTRAINT fk_unit_stack_configuration_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);

ALTER TABLE camdecmpsaux.email_to_process ADD CONSTRAINT fk_email_to_process_plant FOREIGN KEY (fac_id) REFERENCES camd.plant (fac_id);
ALTER TABLE camdecmpsaux.es_spec ADD CONSTRAINT fk_es_spec_plant FOREIGN KEY (fac_id) REFERENCES camd.plant (fac_id);
ALTER TABLE camdecmpsaux.evaluation_set ADD CONSTRAINT fk_evaluation_set_plant FOREIGN KEY (fac_id) REFERENCES camd.plant (fac_id);
ALTER TABLE camdecmpsaux.mats_data_submission ADD CONSTRAINT fk_mats_data_submission_plant FOREIGN KEY (fac_id) REFERENCES camd.plant (fac_id);
ALTER TABLE camdecmpsaux.pdem_mats_unit_hour ADD CONSTRAINT pdem_mats_unit_hour_loc_fk FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);
ALTER TABLE camdecmpsaux.pdem_p75_unit_hour ADD CONSTRAINT pdem_p75_unit_hour_loc_fk FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);
ALTER TABLE camdecmpsaux.program_parameter ADD CONSTRAINT fk_program_parameter_program FOREIGN KEY (prg_id) REFERENCES camd.program (prg_id);
ALTER TABLE camdecmpsaux.submission_set ADD CONSTRAINT fk_submission_set_plant FOREIGN KEY (fac_id) REFERENCES camd.plant (fac_id);

ALTER TABLE camdecmpswks.daily_backstop ADD CONSTRAINT fk_daily_backstop_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);
ALTER TABLE camdecmpswks.mats_bulk_file ADD CONSTRAINT fk_mats_bulk_file_plant FOREIGN KEY (fac_id) REFERENCES camd.plant (fac_id);
ALTER TABLE camdecmpswks.monitor_location ADD CONSTRAINT fk_monitor_location_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);
ALTER TABLE camdecmpswks.monitor_plan ADD CONSTRAINT fk_monitor_plan_plant FOREIGN KEY (fac_id) REFERENCES camd.plant (fac_id);
ALTER TABLE camdecmpswks.stack_pipe ADD CONSTRAINT fk_stack_pipe_plant FOREIGN KEY (fac_id) REFERENCES camd.plant (fac_id);
ALTER TABLE camdecmpswks.unit ADD CONSTRAINT fk_unit_plant FOREIGN KEY (fac_id) REFERENCES camd.plant (fac_id);
ALTER TABLE camdecmpswks.unit_capacity ADD CONSTRAINT fk_unit_capacity_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);
ALTER TABLE camdecmpswks.unit_control ADD CONSTRAINT fk_unit_control_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);
ALTER TABLE camdecmpswks.unit_fuel ADD CONSTRAINT fk_unit_fuel_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);
ALTER TABLE camdecmpswks.unit_stack_configuration ADD CONSTRAINT fk_unit_stack_configuration_unit FOREIGN KEY (unit_id) REFERENCES camd.unit (unit_id);

COMMIT;
