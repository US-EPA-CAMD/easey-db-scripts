ALTER TABLE IF EXISTS camdecmps.monitor_plan
    ADD CONSTRAINT pk_monitor_plan PRIMARY KEY (mon_plan_id),
    ADD CONSTRAINT fk_monitor_plan_plant FOREIGN KEY (fac_id)
        REFERENCES camd.plant (fac_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_plan_reporting_period_begin_rpt_period FOREIGN KEY (begin_rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_plan_reporting_period_end_rpt_period FOREIGN KEY (end_rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_plan_submission_availability_code FOREIGN KEY (submission_availability_cd)
        REFERENCES camdecmpsmd.submission_availability_code (submission_availability_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_monitor_plan_fac_id
    ON camdecmps.monitor_plan USING btree
    (fac_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_plan_chk_session_id
    ON camdecmps.monitor_plan USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_plan_submission_id
    ON camdecmps.monitor_plan USING btree
    (submission_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_plan_submission_availability_cd
    ON camdecmps.monitor_plan USING btree
    (submission_availability_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_plan_begin_rpt_period_id
    ON camdecmps.monitor_plan USING btree
    (begin_rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_plan_end_rpt_period_id
    ON camdecmps.monitor_plan USING btree
    (end_rpt_period_id ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.protocol_gas_vendor
    ADD CONSTRAINT pk_protocol_gas_vendor PRIMARY KEY (vendor_id);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.stack_pipe
    ADD CONSTRAINT pk_stack_pipe PRIMARY KEY (stack_pipe_id),
    ADD CONSTRAINT fk_stack_pipe_plant FOREIGN KEY (fac_id)
        REFERENCES camd.plant (fac_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_stack_pipe_fac_id
    ON camdecmps.stack_pipe USING btree
    (fac_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_stack_pipe_stack_name
    ON camdecmps.stack_pipe USING btree
    (stack_name COLLATE pg_catalog."default" ASC NULLS LAST)
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.unit_capacity
    ADD CONSTRAINT pk_unit_capacity PRIMARY KEY (unit_cap_id),
    ADD CONSTRAINT fk_unit_capacity_unit FOREIGN KEY (unit_id)
        REFERENCES camd.unit (unit_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_unit_capacity_unit
    ON camdecmps.unit_capacity USING btree
    (unit_id ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.unit_control
    ADD CONSTRAINT pk_unit_control PRIMARY KEY (ctl_id),
    ADD CONSTRAINT fk_unit_control_control_code FOREIGN KEY (control_cd)
        REFERENCES camdecmpsmd.control_code (control_cd) MATCH SIMPLE,
	ADD CONSTRAINT fk_unit_control_control_equip_param_code FOREIGN KEY (ce_param)
        REFERENCES camdecmpsmd.control_equip_param_code (control_equip_param_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_unit_control_fuel_indicator_code FOREIGN KEY (indicator_cd)
        REFERENCES camdecmpsmd.fuel_indicator_code (fuel_indicator_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_unit_control_unit FOREIGN KEY (unit_id)
        REFERENCES camd.unit (unit_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_unit_control_unit_id
    ON camdecmps.unit_control USING btree
    (unit_id ASC NULLS LAST)

CREATE INDEX IF NOT EXISTS idx_unit_control_control_cd
    ON camdecmps.unit_control USING btree
    (control_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_unit_control_ce_param
    ON camdecmps.unit_control USING btree
    (ce_param COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_unit_control_indicator_cd
    ON camdecmps.unit_control USING btree
    (indicator_cd COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.unit_fuel
    ADD CONSTRAINT pk_unit_fuel PRIMARY KEY (uf_id),
    ADD CONSTRAINT uq_unit_fuel UNIQUE (unit_id, fuel_type, begin_date),
    ADD CONSTRAINT fk_unit_fuel_dem_method_code_gcv FOREIGN KEY (dem_gcv)
        REFERENCES camdecmpsmd.dem_method_code (dem_method_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_unit_fuel_dem_method_code_so2 FOREIGN KEY (dem_so2)
        REFERENCES camdecmpsmd.dem_method_code (dem_method_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_unit_fuel_fuel_indicator_code FOREIGN KEY (indicator_cd)
        REFERENCES camdecmpsmd.fuel_indicator_code (fuel_indicator_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_unit_fuel_fuel_type_code FOREIGN KEY (fuel_type)
        REFERENCES camdecmpsmd.fuel_type_code (fuel_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_unit_fuel_unit FOREIGN KEY (unit_id)
        REFERENCES camd.unit (unit_id) MATCH SIMPLE,
    ADD CONSTRAINT ck_unit_fuel_act_or_proj_cd CHECK (act_or_proj_cd::text = ANY (ARRAY['A'::character varying::text, 'P'::character varying::text, NULL::character varying::text]));

CREATE INDEX IF NOT EXISTS idx_unit_fuel_unit_id
    ON camdecmps.unit_fuel USING btree
    (unit_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_unit_fuel_fuel_type
    ON camdecmps.unit_fuel USING btree
    (fuel_type COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_unit_fuel_indicator_cd
    ON camdecmps.unit_fuel USING btree
    (indicator_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_unit_fuel_dem_so2
    ON camdecmps.unit_fuel USING btree
    (dem_so2 COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_unit_fuel_dem_gcv
    ON camdecmps.unit_fuel USING btree
    (dem_gcv COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.dm_emissions
    ADD CONSTRAINT pk_dm_emissions PRIMARY KEY (dm_emissions_id),
    ADD CONSTRAINT uq_dm_emissions UNIQUE (mon_plan_id, rpt_period_id),
    ADD CONSTRAINT fk_dm_emissions_plant FOREIGN KEY (fac_id)
        REFERENCES camd.plant (fac_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_dm_emissions_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmps.monitor_plan (mon_plan_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_dm_emissions_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_dm_emissions_apportionment_type_code FOREIGN KEY (apportionment_type_cd)
        REFERENCES camdecmpsmd.apportionment_type_code (apportionment_type_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_dm_emissions_mon_plan_id
    ON camdecmps.dm_emissions USING btree
    (mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_dm_emissions_rpt_period_id
    ON camdecmps.dm_emissions USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_dm_emissions_apportionment_type_cd
    ON camdecmps.dm_emissions USING btree
    (apportionment_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_dm_emissions_fac_id
    ON camdecmps.dm_emissions USING btree
    (fac_id ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE camdecmps.emission_evaluation
    ADD CONSTRAINT pk_emission_evaluation PRIMARY KEY (mon_plan_id, rpt_period_id),
    ADD CONSTRAINT uq_emission_evaluation UNIQUE (mon_plan_id, rpt_period_id),
    ADD CONSTRAINT fk_emission_evaluation_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmps.monitor_plan (mon_plan_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_emission_evaluation_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_emission_evaluation_submission_availability_code FOREIGN KEY (submission_availability_cd)
        REFERENCES camdecmpsmd.submission_availability_code (submission_availability_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_emission_evaluation_mon_plan_id
    ON camdecmps.emission_evaluation USING btree
    (mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_emission_evaluation_rpt_period_id
    ON camdecmps.emission_evaluation USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_emission_evaluation_submission_id
    ON camdecmps.emission_evaluation USING btree
    (submission_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_emission_evaluation_chk_session_id
    ON camdecmps.emission_evaluation USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_emission_evaluation_submission_availability_cd
    ON camdecmps.emission_evaluation USING btree
    (submission_availability_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_emission_evaluation_rpt_period_id_mon_plan_id
    ON camdecmps.emission_evaluation USING btree
    (rpt_period_id ASC NULLS LAST, mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.monitor_location
    ADD CONSTRAINT pk_monitor_location PRIMARY KEY (mon_loc_id),
    ADD CONSTRAINT fk_monitor_location_stack_pipe FOREIGN KEY (stack_pipe_id)
        REFERENCES camdecmps.stack_pipe (stack_pipe_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_location_unit FOREIGN KEY (unit_id)
        REFERENCES camd.unit (unit_id) MATCH SIMPLE;

CREATE INDEX idx_monitor_location_mon_loc_id
    ON camdecmps.monitor_location USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX idx_monitor_location_stack_pipe_id
    ON camdecmps.monitor_location USING btree
    (stack_pipe_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX idx_monitor_location_unit_id
    ON camdecmps.monitor_location USING btree
    (unit_id ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.monitor_plan_comment
    ADD CONSTRAINT pk_monitor_plan_comment PRIMARY KEY (mon_plan_comment_id),
    ADD CONSTRAINT fk_monitor_plan_comment_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmps.monitor_plan (mon_plan_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_plan_comment_submission_availability_code FOREIGN KEY (submission_availability_cd)
        REFERENCES camdecmpsmd.submission_availability_code (submission_availability_cd) MATCH SIMPLE;

CREATE INDEX idx_monitor_plan_comment_mon_plan_id
    ON camdecmps.monitor_plan_comment USING btree
    (mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX idx_monitor_plan_comment_submission_availability_cd
    ON camdecmps.monitor_plan_comment USING btree
    (submission_availability_cd COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.monitor_plan_reporting_freq
    ADD CONSTRAINT pk_monitor_plan_reporting_freq PRIMARY KEY (mon_plan_rf_id),
    ADD CONSTRAINT fk_monitor_plan_reporting_freq_begin_rpt_period FOREIGN KEY (begin_rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_plan_reporting_freq_end_rpt_period FOREIGN KEY (end_rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_plan_reporting_freq_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmps.monitor_plan (mon_plan_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_plan_reporting_freq_report_freq_code FOREIGN KEY (report_freq_cd)
        REFERENCES camdecmpsmd.report_freq_code (report_freq_cd) MATCH SIMPLE;

CREATE INDEX idx_monitor_plan_reporting_freq_begin_rpt_period_id
    ON camdecmps.monitor_plan_reporting_freq USING btree
    (begin_rpt_period_id ASC NULLS LAST);
	
CREATE INDEX idx_monitor_plan_reporting_freq_end_rpt_period_id
    ON camdecmps.monitor_plan_reporting_freq USING btree
    (end_rpt_period_id ASC NULLS LAST);

CREATE INDEX idx_monitor_plan_reporting_freq_mon_plan_id
    ON camdecmps.monitor_plan_reporting_freq USING btree
    (mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX idx_monitor_plan_reporting_freq_report_freq_cd
    ON camdecmps.monitor_plan_reporting_freq USING btree
    (report_freq_cd COLLATE pg_catalog."default" ASC NULLS LAST)
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.unit_stack_configuration
    ADD CONSTRAINT pk_unit_stack_configuration PRIMARY KEY (config_id),
    ADD CONSTRAINT fk_unit_stack_configuration_stack_pipe FOREIGN KEY (stack_pipe_id)
        REFERENCES camdecmps.stack_pipe (stack_pipe_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_unit_stack_configuration_unit FOREIGN KEY (unit_id)
        REFERENCES camd.unit (unit_id) MATCH SIMPLE;

CREATE INDEX idx_unit_stack_configuration_stack_pipe_id
    ON camdecmps.unit_stack_configuration USING btree
    (stack_pipe_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX idx_unit_stack_configuration_unit_id
    ON camdecmps.unit_stack_configuration USING btree
    (unit_id ASC NULLS LAST);

CREATE INDEX idx_unit_stack_configuration_stack_pipe_id_unit_id
    ON camdecmps.unit_stack_configuration USING btree
    (stack_pipe_id COLLATE pg_catalog."default" ASC NULLS LAST, unit_id ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.component
    ADD CONSTRAINT pk_component PRIMARY KEY (component_id),
    ADD CONSTRAINT fk_component_acquisition_method_code FOREIGN KEY (acq_cd)
        REFERENCES camdecmpsmd.acquisition_method_code (acq_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_component_analytical_principle_code FOREIGN KEY (analytical_principle_cd)
        REFERENCES camdecmpsmd.analytical_principle_code (analytical_principle_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_component_basis_code FOREIGN KEY (basis_cd)
        REFERENCES camdecmpsmd.basis_code (basis_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_component_component_type_code FOREIGN KEY (component_type_cd)
        REFERENCES camdecmpsmd.component_type_code (component_type_cd) MATCH SIMPLE,
	ADD CONSTRAINT fk_component_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
		ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_component_acq_cd
    ON camdecmps.component USING btree
    (acq_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_component_analytical_principle_cd
    ON camdecmps.component USING btree
    (analytical_principle_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_component_basis_cd
    ON camdecmps.component USING btree
    (basis_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_component_component_type_cd
    ON camdecmps.component USING btree
    (component_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_component_mon_loc_id
    ON camdecmps.component USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_component_component_identifier
    ON camdecmps.component USING btree
    (component_identifier COLLATE pg_catalog."default" ASC NULLS LAST);

/* WHY ???
CREATE INDEX IF NOT EXISTS idx_component_
    ON camdecmps.component USING btree (
		mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST,
		component_identifier COLLATE pg_catalog."default" ASC NULLS LAST,
		component_id COLLATE pg_catalog."default" ASC NULLS LAST
	);
*/
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.daily_backstop
    ADD CONSTRAINT pk_daily_backstop PRIMARY KEY (daily_backstop_id),
    ADD CONSTRAINT fk_daily_backstop_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_daily_backstop_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_daily_backstop_unit FOREIGN KEY (unit_id)
        REFERENCES camd.unit (unit_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_daily_backstop_unit_id
    ON camdecmps.daily_backstop USING btree
    (unit_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_backstop_mon_loc_id
    ON camdecmps.daily_backstop USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_backstop_rpt_period_id
    ON camdecmps.daily_backstop USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_backstop_rpt_period_id_mon_loc_id
    ON camdecmps.daily_backstop USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.daily_emission
    ADD CONSTRAINT pk_daily_emission PRIMARY KEY (daily_emission_id),
    ADD CONSTRAINT fk_daily_emission_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_daily_emission_parameter_code FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_daily_emission_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_daily_emission_parameter_cd
    ON camdecmps.daily_emission USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_emission_rpt_period_id
    ON camdecmps.daily_emission USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_emission_mon_loc_id
    ON camdecmps.daily_emission USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_emission_rpt_period_id_mon_loc_id
    ON camdecmps.daily_emission USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.dm_emissions_user
	ADD CONSTRAINT pk_dm_emissions_user PRIMARY KEY (dm_emissions_user_id),
    ADD CONSTRAINT uq_dm_emissions_user UNIQUE (dm_emissions_id, dm_emissions_user_cd),
    ADD CONSTRAINT fk_dm_emissions_user_dm_emissions FOREIGN KEY (dm_emissions_id)
        REFERENCES camdecmps.dm_emissions (dm_emissions_id) MATCH SIMPLE,
	ADD CONSTRAINT fk_dm_emissions_user_dm_emissions_user_code FOREIGN KEY (dm_emissions_user_cd)
        REFERENCES camdecmpsmd.dm_emissions_user_code (dm_emissions_user_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_dm_emissions_dm_emissions_id
    ON camdecmps.dm_emissions_user USING btree
    (dm_emissions_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_dm_emissions_dm_emissions_user_cd
    ON camdecmps.dm_emissions_user USING btree
    (dm_emissions_user_cd COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.hrly_op_data
    ADD CONSTRAINT pk_hrly_op_data PRIMARY KEY (hour_id),
    ADD CONSTRAINT fk_hrly_op_data_fuel_code FOREIGN KEY (fuel_cd)
        REFERENCES camdecmpsmd.fuel_code (fuel_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_hrly_op_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_hrly_op_data_operating_condition_code FOREIGN KEY (operating_condition_cd)
        REFERENCES camdecmpsmd.operating_condition_code (operating_condition_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_hrly_op_data_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_hrly_op_data_units_of_measure_code FOREIGN KEY (load_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_hrly_op_data_mon_loc_id
    ON camdecmps.hrly_op_data USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_op_data_rpt_period_id
    ON camdecmps.hrly_op_data USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_op_data_fuel_cd
    ON camdecmps.hrly_op_data USING btree
    (fuel_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_op_data_load_uom_cd
    ON camdecmps.hrly_op_data USING btree
    (load_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_op_data_operating_condition_cd
    ON camdecmps.hrly_op_data USING btree
    (operating_condition_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_op_data_rpt_period_id_mon_loc_id
    ON camdecmps.hrly_op_data USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.mats_method_data
    ADD CONSTRAINT pk_mats_method_data PRIMARY KEY (mats_method_data_id),
    ADD CONSTRAINT fk_mats_method_data_mats_method_code FOREIGN KEY (mats_method_cd)
        REFERENCES camdecmpsmd.mats_method_code (mats_method_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_mats_method_data_mats_method_parameter_code FOREIGN KEY (mats_method_parameter_cd)
        REFERENCES camdecmpsmd.mats_method_parameter_code (mats_method_parameter_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_mats_method_da IF EXISTSta_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
		ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_mats_method_data_mats_method_cd
    ON camdecmps.mats_method_data USING btree
    (mats_method_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_mats_method_data_mon_loc_id
    ON camdecmps.mats_method_data USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_mats_method_data_mats_method_parameter_cd
    ON camdecmps.mats_method_data USING btree
    (mats_method_parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.monitor_default
    ADD CONSTRAINT pk_monitor_default PRIMARY KEY (mondef_id),
    ADD CONSTRAINT fk_monitor_default_default_purpose_code FOREIGN KEY (default_purpose_cd)
        REFERENCES camdecmpsmd.default_purpose_code (default_purpose_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_default_default_source_code FOREIGN KEY (default_source_cd)
        REFERENCES camdecmpsmd.default_source_code (default_source_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_default_fuel_code FOREIGN KEY (fuel_cd)
        REFERENCES camdecmpsmd.fuel_code (fuel_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_default_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_default_operating_condition_code FOREIGN KEY (operating_condition_cd)
        REFERENCES camdecmpsmd.operating_condition_code (operating_condition_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_default_parameter_code FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_default_units_of_measure_code FOREIGN KEY (default_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_monitor_default_default_purpose_cd
    ON camdecmps.monitor_default USING btree
    (default_purpose_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_default_default_source_cd
    ON camdecmps.monitor_default USING btree
    (default_source_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_default_default_uom_cd
    ON camdecmps.monitor_default USING btree
    (default_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_default_fuel_cd
    ON camdecmps.monitor_default USING btree
    (fuel_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_default_operating_condition_cd
    ON camdecmps.monitor_default USING btree
    (operating_condition_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_default_parameter_cd
    ON camdecmps.monitor_default USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_default_mon_loc_id
    ON camdecmps.monitor_default USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

/* WHY ???
CREATE INDEX IF NOT EXISTS idx_monitor_default_
    ON camdecmps.monitor_default USING btree
    (begin_date ASC NULLS LAST, begin_hour ASC NULLS LAST, parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_default_
    ON camdecmps.monitor_default USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST, default_purpose_cd COLLATE pg_catalog."default" ASC NULLS LAST);
*/
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.monitor_formula
    ADD CONSTRAINT pk_monitor_formula PRIMARY KEY (mon_form_id),
    ADD CONSTRAINT fk_monitor_formula_equation_code FOREIGN KEY (equation_cd)
        REFERENCES camdecmpsmd.equation_code (equation_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_formula_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_formula_parameter_code FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_monitor_formula_equation_cd
    ON camdecmps.monitor_formula USING btree
    (equation_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_formula_mon_loc_id
    ON camdecmps.monitor_formula USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_formula_formula_identifier
    ON camdecmps.monitor_formula USING btree
    (formula_identifier COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_formula_parameter_cd
    ON camdecmps.monitor_formula USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.monitor_load
    ADD CONSTRAINT pk_monitor_load PRIMARY KEY (load_id),
    ADD CONSTRAINT fk_monitor_load_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_load_units_of_measure_code FOREIGN KEY (max_load_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_monitor_load_mon_loc_id
    ON camdecmps.monitor_load USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_load_max_load_uom_cd
    ON camdecmps.monitor_load USING btree
    (max_load_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.monitor_location_attribute
    ADD CONSTRAINT pk_monitor_location_attribute PRIMARY KEY (mon_loc_attrib_id),
    ADD CONSTRAINT fk_monitor_location_attribute_material_code FOREIGN KEY (material_cd)
        REFERENCES camdecmpsmd.material_code (material_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_location_attribute_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_location_attribute_shape_code FOREIGN KEY (shape_cd)
        REFERENCES camdecmpsmd.shape_code (shape_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_monitor_location_material_cd
    ON camdecmps.monitor_location_attribute USING btree
    (material_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_location_mon_loc_id
    ON camdecmps.monitor_location_attribute USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_location_shape_cd
    ON camdecmps.monitor_location_attribute USING btree
    (shape_cd COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.monitor_method
    ADD CONSTRAINT pk_monitor_method PRIMARY KEY (mon_method_id),
    ADD CONSTRAINT fk_monitor_method_bypass_approach_code FOREIGN KEY (bypass_approach_cd)
        REFERENCES camdecmpsmd.bypass_approach_code (bypass_approach_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_method_method_code FOREIGN KEY (method_cd)
        REFERENCES camdecmpsmd.method_code (method_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_method_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_method_parameter_code FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_method_substitute_data_code FOREIGN KEY (sub_data_cd)
        REFERENCES camdecmpsmd.substitute_data_code (sub_data_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_monitor_method_mon_loc_id
    ON camdecmps.monitor_method USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_method_parameter_cd
    ON camdecmps.monitor_method USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_method_bypass_approach_cd
    ON camdecmps.monitor_method USING btree
    (bypass_approach_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_method_method_cd
    ON camdecmps.monitor_method USING btree
    (method_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_method_sub_data_cd
    ON camdecmps.monitor_method USING btree
    (sub_data_cd COLLATE pg_catalog."default" ASC NULLS LAST);

/* WHY ???
CREATE INDEX IF NOT EXISTS idx_monitor_method_
    ON camdecmps.monitor_method USING btree
    (begin_date ASC NULLS LAST, begin_hour ASC NULLS LAST, parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);
*/
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.monitor_plan_location
    ADD CONSTRAINT pk_monitor_plan_location PRIMARY KEY (monitor_plan_location_id),
    ADD CONSTRAINT uq_monitor_plan_location UNIQUE (mon_plan_id, mon_loc_id),
    ADD CONSTRAINT fk_monitor_plan_location_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_plan_location_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmps.monitor_plan (mon_plan_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_monitor_plan_location_mon_plan_id
    ON camdecmps.monitor_plan_location USING btree
    (mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_plan_location_mon_loc_id
    ON camdecmps.monitor_plan_location USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_plan_location_mon_plan_id_mon_loc_id
    ON camdecmps.monitor_plan_location USING btree
    (mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.monitor_qualification
    ADD CONSTRAINT pk_monitor_qualification PRIMARY KEY (mon_qual_id),
    ADD CONSTRAINT fk_monitor_qualification_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_qualification_qual_type_code FOREIGN KEY (qual_type_cd)
        REFERENCES camdecmpsmd.qual_type_code (qual_type_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_monitor_qualification_mon_loc_id
    ON camdecmps.monitor_qualification USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_qualification_qual_type_cd
    ON camdecmps.monitor_qualification USING btree
    (qual_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.monitor_span
    ADD CONSTRAINT pk_monitor_span PRIMARY KEY (span_id),
    ADD CONSTRAINT fk_monitor_span_component_type_code FOREIGN KEY (component_type_cd)
        REFERENCES camdecmpsmd.component_type_code (component_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_span_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_span_span_method_code FOREIGN KEY (span_method_cd)
        REFERENCES camdecmpsmd.span_method_code (span_method_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_span_span_scale_code FOREIGN KEY (span_scale_cd)
        REFERENCES camdecmpsmd.span_scale_code (span_scale_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_span_units_of_measure_code FOREIGN KEY (span_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_monitor_span_component_type_cd
    ON camdecmps.monitor_span USING btree
    (component_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_span_mon_loc_id
    ON camdecmps.monitor_span USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_span_span_method_cd
    ON camdecmps.monitor_span USING btree
    (span_method_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_span_span_scale_cd
    ON camdecmps.monitor_span USING btree
    (span_scale_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_span_span_uom_cd
    ON camdecmps.monitor_span USING btree
    (span_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.monitor_system
    ADD CONSTRAINT pk_monitor_system PRIMARY KEY (mon_sys_id),
    ADD CONSTRAINT fk_monitor_system_fuel_code FOREIGN KEY (fuel_cd)
        REFERENCES camdecmpsmd.fuel_code (fuel_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_system_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_system_system_designation_code FOREIGN KEY (sys_designation_cd)
        REFERENCES camdecmpsmd.system_designation_code (sys_designation_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_system_system_type_code FOREIGN KEY (sys_type_cd)
        REFERENCES camdecmpsmd.system_type_code (sys_type_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_monitor_system_fuel_cd
    ON camdecmps.monitor_system USING btree
    (fuel_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_system_mon_loc_id
    ON camdecmps.monitor_system USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_system_system_identifier
    ON camdecmps.monitor_system USING btree
    (system_identifier COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_system_sys_designation_cd
    ON camdecmps.monitor_system USING btree
    (sys_designation_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_system_sys_type_cd
    ON camdecmps.monitor_system USING btree
    (sys_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

/* WHY ???
CREATE UNIQUE INDEX IF NOT EXISTS udx_monitor_system_mon_loc_id_mon_sys_id_system_identifier
    ON camdecmps.monitor_system USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST, mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST, system_identifier COLLATE pg_catalog."default" ASC NULLS LAST);
*/
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.nsps4t_summary
    ADD CONSTRAINT pk_nsps4t_summary PRIMARY KEY (nsps4t_sum_id),
    ADD CONSTRAINT fk_nsps4t_summary_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_nsps4t_summary_nsps4t_electrical_load_code FOREIGN KEY (electrical_load_cd)
        REFERENCES camdecmpsmd.nsps4t_electrical_load_code (electrical_load_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_nsps4t_summary_nsps4t_emission_standard_code FOREIGN KEY (emission_standard_cd)
        REFERENCES camdecmpsmd.nsps4t_emission_standard_code (emission_standard_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_nsps4t_summary_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_nsps4t_summary_units_of_measure_code FOREIGN KEY (modus_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_nsps4t_summary_mon_loc_id
    ON camdecmps.nsps4t_summary USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_nsps4t_summary_electrical_load_cd
    ON camdecmps.nsps4t_summary USING btree
    (electrical_load_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_nsps4t_summary_rpt_period_id
    ON camdecmps.nsps4t_summary USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_nsps4t_summary_emission_standard_cd
    ON camdecmps.nsps4t_summary USING btree
    (emission_standard_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_nsps4t_summary_modus_uom_cd
    ON camdecmps.nsps4t_summary USING btree
    (modus_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_nsps4t_summary_rpt_period_id_mon_loc_id
    ON camdecmps.nsps4t_summary USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.operating_supp_data
	ADD CONSTRAINT pk_operating_supp_data PRIMARY KEY (op_supp_data_id),
    ADD CONSTRAINT fk_operating_supp_data_fuel_code FOREIGN KEY (fuel_cd)
        REFERENCES camdecmpsmd.fuel_code (fuel_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_operating_supp_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_operating_supp_data_operating_type_code FOREIGN KEY (op_type_cd)
        REFERENCES camdecmpsmd.operating_type_code (op_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_operating_supp_data_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_operating_supp_data_fuel_cd
    ON camdecmps.operating_supp_data USING btree
    (fuel_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_operating_supp_data_mon_loc_id
    ON camdecmps.operating_supp_data USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_operating_supp_data_op_type_cd
    ON camdecmps.operating_supp_data USING btree
    (op_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_operating_supp_data_rpt_period_id
    ON camdecmps.operating_supp_data USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_operating_supp_data_rpt_period_id_mon_loc_id
    ON camdecmps.operating_supp_data USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.rect_duct_waf
    ADD CONSTRAINT pk_rect_duct_waf PRIMARY KEY (rect_duct_waf_data_id),
    ADD CONSTRAINT fk_rect_duct_waf_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_rect_duct_waf_waf_method_code FOREIGN KEY (waf_method_cd)
        REFERENCES camdecmpsmd.waf_method_code (waf_method_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_rect_duct_waf_mon_loc_id
    ON camdecmps.rect_duct_waf USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_rect_duct_waf_waf_method_cd
    ON camdecmps.rect_duct_waf USING btree
    (waf_method_cd COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.summary_value
    ADD CONSTRAINT pk_summary_value PRIMARY KEY (sum_value_id),
    ADD CONSTRAINT uq_summary_value UNIQUE (mon_loc_id, rpt_period_id, parameter_cd),
    ADD CONSTRAINT fk_summary_value_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_summary_value_parameter_code FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_summary_value_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_summary_value_mon_loc_id
    ON camdecmps.summary_value USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_summary_value_parameter_cd
    ON camdecmps.summary_value USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_summary_value_rpt_period_id
    ON camdecmps.summary_value USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_summary_value_rpt_period_id_mon_loc_id
    ON camdecmps.summary_value USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.used_identifier
    ADD CONSTRAINT pk_used_identifier PRIMARY KEY (mon_loc_id, table_cd, identifier),
    ADD CONSTRAINT fk_used_identifier_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_used_identifier_mon_loc_id
    ON camdecmps.used_identifier USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_used_identifier_table_cd
    ON camdecmps.used_identifier USING btree
    (table_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_used_identifier_identifier
    ON camdecmps.used_identifier USING btree
    (identifier COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_used_identifier_type_or_parameter_cd
    ON camdecmps.used_identifier USING btree
    (type_or_parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_used_identifier_formula_or_basis_cd
    ON camdecmps.used_identifier USING btree
    (formula_or_basis_cd COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.analyzer_range
    ADD CONSTRAINT pk_analyzer_range PRIMARY KEY (analyzer_range_id),
    ADD CONSTRAINT fk_analyzer_range_analyzer_range_code FOREIGN KEY (analyzer_range_cd)
        REFERENCES camdecmpsmd.analyzer_range_code (analyzer_range_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_analyzer_range_component FOREIGN KEY (component_id)
        REFERENCES camdecmps.component (component_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT ck_analyzer_range_begin_date_end_date CHECK (begin_date <= end_date);

CREATE INDEX IF NOT EXISTS idx_analyzer_range_analyzer_range_cd
    ON camdecmps.analyzer_range USING btree
    (analyzer_range_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_analyzer_range_component_id
    ON camdecmps.analyzer_range USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.component_op_supp_data
	ADD CONSTRAINT pk_component_op_supp_data PRIMARY KEY (comp_op_supp_data_id),
    ADD CONSTRAINT fk_component_op_supp_data_component FOREIGN KEY (component_id)
        REFERENCES camdecmps.component (component_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_component_op_supp_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_component_op_supp_data_op_supp_data_type_code FOREIGN KEY (op_supp_data_type_cd)
        REFERENCES camdecmpsmd.op_supp_data_type_code (op_supp_data_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_component_op_supp_data_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_component_op_supp_data_component_id
    ON camdecmps.component_op_supp_data USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_component_op_supp_data_op_supp_data_type_cd
    ON camdecmps.component_op_supp_data USING btree
    (op_supp_data_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_component_op_supp_data_rpt_period_id
    ON camdecmps.component_op_supp_data USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_component_op_supp_data_mon_loc_id
    ON camdecmps.component_op_supp_data USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_component_op_supp_data_rpt_period_id_mon_loc_id
    ON camdecmps.component_op_supp_data USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.daily_fuel
    ADD CONSTRAINT pk_daily_fuel PRIMARY KEY (daily_fuel_id),
    ADD CONSTRAINT fk_daily_fuel_daily_emission FOREIGN KEY (daily_emission_id)
        REFERENCES camdecmps.daily_emission (daily_emission_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_daily_fuel_fuel_code FOREIGN KEY (fuel_cd)
        REFERENCES camdecmpsmd.fuel_code (fuel_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_daily_fuel_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_daily_fuel_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_daily_fuel_daily_emission_id
    ON camdecmps.daily_fuel USING btree
    (daily_emission_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_fuel_fuel_cd
    ON camdecmps.daily_fuel USING btree
    (fuel_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_fuel_mon_loc_id
    ON camdecmps.daily_fuel USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_fuel_rpt_period_id
    ON camdecmps.daily_fuel USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_fuel_rpt_period_id_mon_loc_id
    ON camdecmps.daily_fuel USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.daily_test_summary
    ADD CONSTRAINT pk_daily_test_summary PRIMARY KEY (daily_test_sum_id),
    ADD CONSTRAINT fk_daily_test_summary_component FOREIGN KEY (component_id)
        REFERENCES camdecmps.component (component_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_daily_test_summary_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_daily_test_summary_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_daily_test_summary_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_daily_test_summary_span_scale_code FOREIGN KEY (span_scale_cd)
        REFERENCES camdecmpsmd.span_scale_code (span_scale_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_daily_test_summary_test_result_code FOREIGN KEY (test_result_cd)
        REFERENCES camdecmpsmd.test_result_code (test_result_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_daily_test_summary_test_result_code_calc FOREIGN KEY (calc_test_result_cd)
        REFERENCES camdecmpsmd.test_result_code (test_result_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_daily_test_summary_test_type_code FOREIGN KEY (test_type_cd)
        REFERENCES camdecmpsmd.test_type_code (test_type_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_daily_test_summary_rpt_period_id
    ON camdecmps.daily_test_summary USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_summary_component_id
    ON camdecmps.daily_test_summary USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_summary_mon_loc_id
    ON camdecmps.daily_test_summary USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_summary_span_scale_cd
    ON camdecmps.daily_test_summary USING btree
    (span_scale_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_summary_test_result_cd
    ON camdecmps.daily_test_summary USING btree
    (test_result_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_summary_test_type_cd
    ON camdecmps.daily_test_summary USING btree
    (test_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_summary_mon_sys_id
    ON camdecmps.daily_test_summary USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_summary_rpt_period_id_mon_loc_id
    ON camdecmps.daily_test_summary USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.derived_hrly_value
    ADD CONSTRAINT pk_derived_hrly_value PRIMARY KEY (derv_id),
    ADD CONSTRAINT fk_derived_hrly_value_fuel_code FOREIGN KEY (fuel_cd)
        REFERENCES camdecmpsmd.fuel_code (fuel_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_derived_hrly_value_hrly_op_data FOREIGN KEY (hour_id)
        REFERENCES camdecmps.hrly_op_data (hour_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_derived_hrly_value_modc_code FOREIGN KEY (modc_cd)
        REFERENCES camdecmpsmd.modc_code (modc_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_derived_hrly_value_monitor_formula FOREIGN KEY (mon_form_id)
        REFERENCES camdecmps.monitor_formula (mon_form_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_derived_hrly_value_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_derived_hrly_value_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_derived_hrly_value_operating_condition_code FOREIGN KEY (operating_condition_cd)
        REFERENCES camdecmpsmd.operating_condition_code (operating_condition_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_derived_hrly_value_parameter_code FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_derived_hrly_value_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_derived_hrly_value_fuel_cd
    ON camdecmps.derived_hrly_value USING btree
    (fuel_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_derived_hrly_value_hour_id
    ON camdecmps.derived_hrly_value USING btree
    (hour_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_derived_hrly_value_mon_form_id
    ON camdecmps.derived_hrly_value USING btree
    (mon_form_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_derived_hrly_value_mon_sys_id
    ON camdecmps.derived_hrly_value USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_derived_hrly_value_operating_condition_cd
    ON camdecmps.derived_hrly_value USING btree
    (operating_condition_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_derived_hrly_value_parameter_cd
    ON camdecmps.derived_hrly_value USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_derived_hrly_value_rpt_period_id
    ON camdecmps.derived_hrly_value USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_derived_hrly_value_mon_loc_id
    ON camdecmps.derived_hrly_value USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_derived_hrly_value_rpt_period_id_mon_loc_id
    ON camdecmps.derived_hrly_value USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

/* WHY ???
CREATE INDEX IF NOT EXISTS idx_derived_hrly_value_
    ON camdecmps.derived_hrly_value USING btree
    (modc_cd COLLATE pg_catalog."default" ASC NULLS LAST, unadjusted_hrly_value ASC NULLS LAST, parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST, hour_id COLLATE pg_catalog."default" ASC NULLS LAST);
*/
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE If EXISTS camdecmps.hrly_fuel_flow
    ADD CONSTRAINT pk_hrly_fuel_flow PRIMARY KEY (hrly_fuel_flow_id),
    ADD CONSTRAINT fk_hrly_fuel_flow_fuel_code FOREIGN KEY (fuel_cd)
        REFERENCES camdecmpsmd.fuel_code (fuel_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_hrly_fuel_flow_hrly_op_data FOREIGN KEY (hour_id)
        REFERENCES camdecmps.hrly_op_data (hour_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_hrly_fuel_flow_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_hrly_fuel_flow_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_hrly_fuel_flow_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_hrly_fuel_flow_sod_mass_code FOREIGN KEY (sod_mass_cd)
        REFERENCES camdecmpsmd.sod_mass_code (sod_mass_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_hrly_fuel_flow_sod_volumetric_code FOREIGN KEY (sod_volumetric_cd)
        REFERENCES camdecmpsmd.sod_volumetric_code (sod_volumetric_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_hrly_fuel_flow_units_of_measure_code FOREIGN KEY (volumetric_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_hrly_fuel_flow_rpt_period_id
    ON camdecmps.hrly_fuel_flow USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_fuel_flow_mon_loc_id
    ON camdecmps.hrly_fuel_flow USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_fuel_flow_fuel_cd
    ON camdecmps.hrly_fuel_flow USING btree
    (fuel_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_fuel_flow_hour_id
    ON camdecmps.hrly_fuel_flow USING btree
    (hour_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_fuel_flow_mon_sys_id
    ON camdecmps.hrly_fuel_flow USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_fuel_flow_sod_mass_cd
    ON camdecmps.hrly_fuel_flow USING btree
    (sod_mass_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_fuel_flow_sod_volumetric_cd
    ON camdecmps.hrly_fuel_flow USING btree
    (sod_volumetric_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_fuel_flow_volumetric_uom_cd
    ON camdecmps.hrly_fuel_flow USING btree
    (volumetric_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_fuel_flow_rpt_period_id_mon_loc_id
    ON camdecmps.hrly_fuel_flow USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.hrly_gas_flow_meter
    ADD CONSTRAINT pk_hrly_gas_flow_meter PRIMARY KEY (hrly_gas_flow_meter_id),
    ADD CONSTRAINT fk_hrly_gas_flow_meter_component FOREIGN KEY (component_id)
        REFERENCES camdecmps.component (component_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_hrly_gas_flow_meter_hrly_op_data FOREIGN KEY (hour_id)
        REFERENCES camdecmps.hrly_op_data (hour_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_hrly_gas_flow_meter_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_hrly_gas_flow_meter_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
	ADD CONSTRAINT fk_hrly_gas_flow_meter_begin_end_hour_flg FOREIGN KEY (begin_end_hour_flg)
        REFERENCES camdecmpsmd.begin_end_hour_flag (begin_end_hour_flg) MATCH SIMPLE,
	ADD CONSTRAINT fk_hrly_gas_flow_meter_sampling_rate_uom FOREIGN KEY (sampling_rate_uom)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_hrly_gas_flow_meter_hour_id
    ON camdecmps.hrly_gas_flow_meter USING btree
    (hour_id COLLATE pg_catalog."default" ASC NULLS LAST);
	
CREATE INDEX IF NOT EXISTS idx_hrly_gas_flow_meter_mon_loc_id
    ON camdecmps.hrly_gas_flow_meter USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_gas_flow_meter_rpt_period_id
    ON camdecmps.hrly_gas_flow_meter USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_gas_flow_meter_component_id
    ON camdecmps.hrly_gas_flow_meter USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_gas_flow_meter_begin_end_hour_flg
    ON camdecmps.hrly_gas_flow_meter USING btree
    (begin_end_hour_flg COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_gas_flow_meter_sampling_rate_uom
    ON camdecmps.hrly_gas_flow_meter USING btree
    (sampling_rate_uom COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_gas_flow_meter_rpt_period_id_mon_loc_id
    ON camdecmps.hrly_gas_flow_meter USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.last_qa_value_supp_data
	ADD CONSTRAINT pk_last_qa_value_supp_data PRIMARY KEY (last_qa_value_supp_data_id),
    ADD CONSTRAINT fk_last_qa_value_supp_data_component FOREIGN KEY (component_id)
        REFERENCES camdecmps.component (component_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_last_qa_value_supp_data_hourly_type_code FOREIGN KEY (hourly_type_cd)
        REFERENCES camdecmpsmd.hourly_type_code (hourly_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_last_qa_value_supp_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_last_qa_value_supp_data_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_last_qa_value_supp_data_parameter_code FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_last_qa_value_supp_data_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_last_qa_value_supp_data_component_id
    ON camdecmps.last_qa_value_supp_data USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_last_qa_value_supp_data_mon_loc_id
    ON camdecmps.last_qa_value_supp_data USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_last_qa_value_supp_data_mon_sys_id
    ON camdecmps.last_qa_value_supp_data USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_last_qa_value_supp_data_parameter_cd
    ON camdecmps.last_qa_value_supp_data USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_last_qa_value_supp_data_hourly_type_cd
    ON camdecmps.last_qa_value_supp_data USING btree
    (hourly_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_last_qa_value_supp_data_rpt_period_id
    ON camdecmps.last_qa_value_supp_data USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_last_qa_value_supp_data_rpt_period_id_mon_loc_id
    ON camdecmps.last_qa_value_supp_data USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.long_term_fuel_flow
    ADD CONSTRAINT pk_long_term_fuel_flow PRIMARY KEY (ltff_id),
    ADD CONSTRAINT fk_long_term_fuel_flow_fuel_flow_period_code FOREIGN KEY (fuel_flow_period_cd)
        REFERENCES camdecmpsmd.fuel_flow_period_code (fuel_flow_period_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_long_term_fuel_flow_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_long_term_fuel_flow_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_long_term_fuel_flow_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_long_term_fuel_flow_units_of_measure_code_gcv FOREIGN KEY (gcv_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_long_term_fuel_flow_units_of_measure_code_ltff FOREIGN KEY (ltff_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_long_term_fuel_fuel_flow_fuel_flow_period_cd
    ON camdecmps.long_term_fuel_flow USING btree
    (fuel_flow_period_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_long_term_fuel_fuel_flow_gcv_uom_cd
    ON camdecmps.long_term_fuel_flow USING btree
    (gcv_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_long_term_fuel_fuel_flow_ltff_uom_cd
    ON camdecmps.long_term_fuel_flow USING btree
    (ltff_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_long_term_fuel_fuel_flow_mon_loc_id
    ON camdecmps.long_term_fuel_flow USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_long_term_fuel_fuel_flow_mon_sys_id
    ON camdecmps.long_term_fuel_flow USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_long_term_fuel_flow_rpt_period_id
    ON camdecmps.long_term_fuel_flow USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_long_term_fuel_flow_rpt_period_id_mon_loc_id
    ON camdecmps.long_term_fuel_flow USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.mats_derived_hrly_value
    ADD CONSTRAINT pk_mats_derived_hrly_value PRIMARY KEY (mats_dhv_id),
    ADD CONSTRAINT fk_mats_derived_hrly_value_hrly_op_data FOREIGN KEY (hour_id)
        REFERENCES camdecmps.hrly_op_data (hour_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_mats_derived_hrly_value_modc_code FOREIGN KEY (modc_cd)
        REFERENCES camdecmpsmd.modc_code (modc_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_mats_derived_hrly_value_monitor_formula FOREIGN KEY (mon_form_id)
        REFERENCES camdecmps.monitor_formula (mon_form_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_mats_derived_hrly_value_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_mats_derived_hrly_value_parameter_code FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_mats_derived_hrly_value_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_mats_derived_hrly_value_hour_id
    ON camdecmps.mats_derived_hrly_value USING btree
    (hour_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_mats_derived_hrly_value_mon_form_id
    ON camdecmps.mats_derived_hrly_value USING btree
    (mon_form_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_mats_derived_hrly_value_parameter_cd
    ON camdecmps.mats_derived_hrly_value USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_mats_derived_hrly_value_modc_cd
    ON camdecmps.mats_derived_hrly_value USING btree
    (modc_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_mats_derived_hrly_value_rpt_period_id
    ON camdecmps.mats_derived_hrly_value USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_mats_derived_hrly_value_mon_loc_id
    ON camdecmps.mats_derived_hrly_value USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_mats_derived_hrly_value_rpt_period_id_mon_loc_id
    ON camdecmps.mats_derived_hrly_value USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

/* WHY ???
CREATE INDEX IF NOT EXISTS idx_mats_derived_hrly_value_
    ON camdecmps.mats_derived_hrly_value USING btree
    (modc_cd COLLATE pg_catalog."default" ASC NULLS LAST, unadjusted_hrly_value COLLATE pg_catalog."default" ASC NULLS LAST, parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST, hour_id COLLATE pg_catalog."default" ASC NULLS LAST);
*/
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.mats_monitor_hrly_value
    ADD CONSTRAINT pk_mats_monitor_hrly_value PRIMARY KEY (mats_mhv_id),
    ADD CONSTRAINT fk_mats_monitor_hrly_value_component FOREIGN KEY (component_id)
        REFERENCES camdecmps.component (component_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_mats_monitor_hrly_value_hrly_op_data FOREIGN KEY (hour_id)
        REFERENCES camdecmps.hrly_op_data (hour_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_mats_monitor_hrly_value_modc_code FOREIGN KEY (modc_cd)
        REFERENCES camdecmpsmd.modc_code (modc_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_mats_monitor_hrly_value_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_mats_monitor_hrly_value_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_mats_monitor_hrly_value_parameter_code FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_mats_monitor_hrly_value_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE

CREATE INDEX IF NOT EXISTS idx_mats_monitor_hrly_value_component_id
    ON camdecmps.mats_monitor_hrly_value USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_mats_monitor_hrly_value_hour_id
    ON camdecmps.mats_monitor_hrly_value USING btree
    (hour_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_mats_monitor_hrly_value_modc_cd
    ON camdecmps.mats_monitor_hrly_value USING btree
    (modc_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_mats_monitor_hrly_value_mon_sys_id
    ON camdecmps.mats_monitor_hrly_value USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_mats_monitor_hrly_value_parameter_cd
    ON camdecmps.mats_monitor_hrly_value USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_mats_monitor_hrly_value_rpt_period_id
    ON camdecmps.mats_monitor_hrly_value USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_mats_monitor_hrly_value_mon_loc_id
    ON camdecmps.mats_monitor_hrly_value USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_mats_monitor_hrly_value_rpt_period_id_mon_loc_id
    ON camdecmps.mats_monitor_hrly_value USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

/* WHY ???
CREATE INDEX IF NOT EXISTS idx_mats_monitor_hrly_value_
    ON camdecmps.mats_monitor_hrly_value USING btree
    (hour_id COLLATE pg_catalog."default" ASC NULLS LAST, parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_mats_monitor_hrly_value_
    ON camdecmps.mats_monitor_hrly_value USING btree
    (modc_cd COLLATE pg_catalog."default" ASC NULLS LAST, unadjusted_hrly_value COLLATE pg_catalog."default" ASC NULLS LAST, hour_id COLLATE pg_catalog."default" ASC NULLS LAST, parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);
*/
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.monitor_hrly_value
    ADD CONSTRAINT pk_monitor_hrly_value PRIMARY KEY (monitor_hrly_val_id),
    ADD CONSTRAINT fk_monitor_hrly_value_component FOREIGN KEY (component_id)
        REFERENCES camdecmps.component (component_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_hrly_value_hrly_op_data FOREIGN KEY (hour_id)
        REFERENCES camdecmps.hrly_op_data (hour_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_hrly_value_modc_code FOREIGN KEY (modc_cd)
        REFERENCES camdecmpsmd.modc_code (modc_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_hrly_value_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_hrly_value_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_hrly_value_parameter_code FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_hrly_value_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT chk_monitor_hrly_value_hour_id CHECK (hour_id IS NOT NULL),
    ADD CONSTRAINT chk_monitor_hrly_value_mon_loc_id CHECK (mon_loc_id IS NOT NULL),
    ADD CONSTRAINT chk_monitor_hrly_value_monitor_hrly_val_id CHECK (monitor_hrly_val_id IS NOT NULL),
    ADD CONSTRAINT chk_monitor_hrly_value_parameter_cd CHECK (parameter_cd IS NOT NULL),
    ADD CONSTRAINT chk_monitor_hrly_value_rpt_period_id CHECK (rpt_period_id IS NOT NULL);

CREATE INDEX IF NOT EXISTS idx_monitor_hrly_value_hour_id
    ON camdecmps.monitor_hrly_value USING btree
    (hour_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_hrly_value_mon_sys_id
    ON camdecmps.monitor_hrly_value USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_hrly_value_component_id
    ON camdecmps.monitor_hrly_value USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_hrly_value_parameter_cd
    ON camdecmps.monitor_hrly_value USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_hrly_value_modc_cd
    ON camdecmps.monitor_hrly_value USING btree
    (modc_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_hrly_value_rpt_period_id
    ON camdecmps.monitor_hrly_value USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_hrly_value_mon_loc_id
    ON camdecmps.monitor_hrly_value USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_hrly_value_rpt_period_id_mon_loc_id
    ON camdecmps.monitor_hrly_value USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

/* WHY ???
CREATE INDEX IF NOT EXISTS idx_monitor_hrly_value_
    ON camdecmps.monitor_hrly_value USING btree
    (hour_id COLLATE pg_catalog."default" ASC NULLS LAST, parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_hrly_value_
    ON camdecmps.monitor_hrly_value USING btree
    (modc_cd COLLATE pg_catalog."default" ASC NULLS LAST, unadjusted_hrly_value ASC NULLS LAST, hour_id COLLATE pg_catalog."default" ASC NULLS LAST, parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);
*/
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.monitor_qualification_cpms
	ADD CONSTRAINT pk_monitor_qualification_cpms PRIMARY KEY (mon_qual_cpms_id),
  	ADD CONSTRAINT fk_monitor_qualification_cpms_monitor_qualification FOREIGN KEY (mon_qual_id)
		REFERENCES camdecmps.monitor_qualification (mon_qual_id) MATCH SIMPLE
		ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_monitor_qualification_cpms_mon_qual_id
    ON camdecmps.monitor_qualification_cpms USING btree
    (mon_qual_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.monitor_qualification_lee
    ADD CONSTRAINT pk_monitor_qualification_lee PRIMARY KEY (mon_qual_lee_id),
    ADD CONSTRAINT fk_monitor_qualification_lee_monitor_qualification FOREIGN KEY (mon_qual_id)
        REFERENCES camdecmps.monitor_qualification (mon_qual_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_qualification_lee_parameter_code FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_qualification_lee_qual_test_type_code FOREIGN KEY (qual_lee_test_type_cd)
        REFERENCES camdecmpsmd.qual_lee_test_type_code (qual_lee_test_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_qualification_lee_units_of_measure_code FOREIGN KEY (emission_standard_uom)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_monitor_qualification_lee_emission_standard_uom
    ON camdecmps.monitor_qualification_lee USING btree
    (emission_standard_uom COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_qualification_lee_mon_qual_id
    ON camdecmps.monitor_qualification_lee USING btree
    (mon_qual_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_qualification_lee_parameter_cd
    ON camdecmps.monitor_qualification_lee USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_qualification_lee_qaul_lee_test_type_cd
    ON camdecmps.monitor_qualification_lee USING btree
    (qual_lee_test_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.monitor_qualification_lme
    ADD CONSTRAINT pk_monitor_qualification_lme PRIMARY KEY (mon_lme_id),
    ADD CONSTRAINT fk_monitor_qualification_lme_monitor_qualification FOREIGN KEY (mon_qual_id)
        REFERENCES camdecmps.monitor_qualification (mon_qual_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_monitor_qualification_lme_mon_qual_id
    ON camdecmps.monitor_qualification_lme USING btree
    (mon_qual_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.monitor_qualification_pct
    ADD CONSTRAINT pk_monitor_qualification_pct PRIMARY KEY (mon_pct_id),
    ADD CONSTRAINT fk_monitor_qualification_pct_monitor_qualification FOREIGN KEY (mon_qual_id)
        REFERENCES camdecmps.monitor_qualification (mon_qual_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_qualification_pct_qual_data_type_code_yr1 FOREIGN KEY (yr1_qual_data_type_cd)
        REFERENCES camdecmpsmd.qual_data_type_code (qual_data_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_qualification_pct_qual_data_type_code_yr2 FOREIGN KEY (yr2_qual_data_type_cd)
        REFERENCES camdecmpsmd.qual_data_type_code (qual_data_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_qualification_pct_qual_data_type_code_yr3 FOREIGN KEY (yr3_qual_data_type_cd)
        REFERENCES camdecmpsmd.qual_data_type_code (qual_data_type_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_monitor_qualification_pct_mon_qual_id
    ON camdecmps.monitor_qualification_pct USING btree
    (mon_qual_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_qualification_pct_yr1_qual_data_type_cd
    ON camdecmps.monitor_qualification_pct USING btree
    (yr1_qual_data_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_qualification_pct_yr2_qual_data_type_cd
    ON camdecmps.monitor_qualification_pct USING btree
    (yr2_qual_data_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_qualification_pct_yr3_qual_data_type_cd
    ON camdecmps.monitor_qualification_pct USING btree
    (yr3_qual_data_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.monitor_system_component
    ADD CONSTRAINT pk_monitor_system_component PRIMARY KEY (mon_sys_comp_id),
    ADD CONSTRAINT fk_monitor_system_component_component FOREIGN KEY (component_id)
        REFERENCES camdecmps.component (component_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_system_component_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_monitor_system_component_mon_sys_id
    ON camdecmps.monitor_system_component USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_system_component_component_id
    ON camdecmps.monitor_system_component USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.nsps4t_annual
    ADD CONSTRAINT pk_nsps4t_annual PRIMARY KEY (nsps4t_ann_id),
    ADD CONSTRAINT fk_nsps4t_annual_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_nsps4t_annual_nsps4t_electrical_load_code FOREIGN KEY (annual_energy_sold_type_cd)
        REFERENCES camdecmpsmd.nsps4t_electrical_load_code (electrical_load_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_nsps4t_annual_nsps4t_summary FOREIGN KEY (nsps4t_sum_id)
        REFERENCES camdecmps.nsps4t_summary (nsps4t_sum_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_nsps4t_annual_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_nsps4t_annual_mon_loc_id
    ON camdecmps.nsps4t_annual USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_nsps4t_annual_rpt_period_id
    ON camdecmps.nsps4t_annual USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_nsps4t_annual_nsps4t_sum_id
    ON camdecmps.nsps4t_annual USING btree
    (nsps4t_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_nsps4t_annual_annual_energy_sold_type_cd
    ON camdecmps.nsps4t_annual USING btree
    (annual_energy_sold_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_nsps4t_annual_rpt_period_id_mon_loc_id
    ON camdecmps.nsps4t_annual USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.nsps4t_compliance_period
    ADD CONSTRAINT pk_nsps4t_compliance_period PRIMARY KEY (nsps4t_cmp_id),
    ADD CONSTRAINT fk_nsps4t_compliance_period_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_nsps4t_compliance_period_nsps4t_summary FOREIGN KEY (nsps4t_sum_id)
        REFERENCES camdecmps.nsps4t_summary (nsps4t_sum_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_nsps4t_compliance_period_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_nsps4t_compliance_period_units_of_measure_code FOREIGN KEY (co2_emission_rate_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_nsps4t_compliance_period_mon_loc_id
    ON camdecmps.nsps4t_compliance_period USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_nsps4t_compliance_period_rpt_period_id
    ON camdecmps.nsps4t_compliance_period USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_nsps4t_compliance_period_nsps4t_sum_id
    ON camdecmps.nsps4t_compliance_period USING btree
    (nsps4t_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_nsps4t_compliance_period_co2_emission_rate_uom_cd
    ON camdecmps.nsps4t_compliance_period USING btree
    (co2_emission_rate_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_nsps4t_compliance_period_rpt_period_id_mon_loc_id
    ON camdecmps.nsps4t_compliance_period USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.qa_cert_event
	ADD CONSTRAINT pk_qa_cert_event PRIMARY KEY (qa_cert_event_id),
    ADD CONSTRAINT fk_qa_cert_event_component FOREIGN KEY (component_id)
        REFERENCES camdecmps.component (component_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_qa_cert_event_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_qa_cert_event_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_qa_cert_event_qa_cert_event_code FOREIGN KEY (qa_cert_event_cd)
        REFERENCES camdecmpsmd.qa_cert_event_code (qa_cert_event_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_qa_cert_event_required_test_code FOREIGN KEY (required_test_cd)
        REFERENCES camdecmpsmd.required_test_code (required_test_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_qa_cert_event_submission_availability_code FOREIGN KEY (submission_availability_cd)
        REFERENCES camdecmpsmd.submission_availability_code (submission_availability_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_chk_session_id
    ON camdecmps.qa_cert_event USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_component_id
    ON camdecmps.qa_cert_event USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_mon_loc_id
    ON camdecmps.qa_cert_event USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_mon_sys_id
    ON camdecmps.qa_cert_event USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_qa_cert_event_cd
    ON camdecmps.qa_cert_event USING btree
    (qa_cert_event_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_required_test_cd
    ON camdecmps.qa_cert_event USING btree
    (required_test_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_submission_availability_cd
    ON camdecmps.qa_cert_event USING btree
    (submission_availability_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_submission_id
    ON camdecmps.qa_cert_event USING btree
    (submission_id ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.sorbent_trap_supp_data
    ADD CONSTRAINT pk_st_supp_data PRIMARY KEY (trap_id),
    ADD CONSTRAINT fk_sorbent_trap_supp_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_sorbent_trap_supp_data_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_st_supp_data_aps_cd FOREIGN KEY (sorbent_trap_aps_cd)
        REFERENCES camdecmpsmd.sorbent_trap_aps_code (sorbent_trap_aps_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_st_supp_data_modc_cd FOREIGN KEY (modc_cd)
        REFERENCES camdecmpsmd.modc_code (modc_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_st_supp_data_rpt_period_id FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_sorbent_trap_supp_data_modc_cd
    ON camdecmps.sorbent_trap_supp_data USING btree
    (modc_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sorbent_trap_supp_data_mon_loc_id
    ON camdecmps.sorbent_trap_supp_data USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sorbent_trap_supp_data_mon_sys_id
    ON camdecmps.sorbent_trap_supp_data USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sorbent_trap_supp_data_rpt_period_id
    ON camdecmps.sorbent_trap_supp_data USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sorbent_trap_supp_data_rpt_period_id_mon_loc_id
    ON camdecmps.sorbent_trap_supp_data USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.sorbent_trap
    ADD CONSTRAINT pk_sorbent_trap PRIMARY KEY (trap_id),
    ADD CONSTRAINT fk_sorbent_trap_modc_code FOREIGN KEY (modc_cd)
        REFERENCES camdecmpsmd.modc_code (modc_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_sorbent_trap_modc_code_calc FOREIGN KEY (calc_modc_cd)
        REFERENCES camdecmpsmd.modc_code (modc_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_sorbent_trap_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_sorbent_trap_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_sorbent_trap_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_sorbent_trap_sorbent_trap_aps_code FOREIGN KEY (sorbent_trap_aps_cd)
        REFERENCES camdecmpsmd.sorbent_trap_aps_code (sorbent_trap_aps_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_sorbent_trap_mon_loc_id
    ON camdecmps.sorbent_trap USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sorbent_trap_rpt_period_id
    ON camdecmps.sorbent_trap USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sorbent_trap_modc_cd
    ON camdecmps.sorbent_trap USING btree
    (modc_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sorbent_trap_sorbent_trap_aps_cd
    ON camdecmps.sorbent_trap USING btree
    (sorbent_trap_aps_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sorbent_trap_mon_sys_id
    ON camdecmps.sorbent_trap USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sorbent_trap_rpt_period_id_mon_loc_id
    ON camdecmps.sorbent_trap USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.system_fuel_flow
    ADD CONSTRAINT pk_system_fuel_flow PRIMARY KEY (sys_fuel_id),
    ADD CONSTRAINT fk_system_fuel_flow_max_rate_source_code FOREIGN KEY (max_rate_source_cd)
        REFERENCES camdecmpsmd.max_rate_source_code (max_rate_source_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_system_fuel_flow_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_system_fuel_flow_units_of_measure_code FOREIGN KEY (sys_fuel_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_system_fuel_flow_max_rate_source_cd
    ON camdecmps.system_fuel_flow USING btree
    (max_rate_source_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_system_fuel_flow_mon_sys_id
    ON camdecmps.system_fuel_flow USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_system_fuel_flow_sys_fuel_uom_cd
    ON camdecmps.system_fuel_flow USING btree
    (sys_fuel_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.system_op_supp_data
	ADD CONSTRAINT pk_system_op_supp_data PRIMARY KEY (sys_op_supp_data_id),
    ADD CONSTRAINT fk_system_op_supp_data_op_supp_data_type_code FOREIGN KEY (op_supp_data_type_cd)
        REFERENCES camdecmpsmd.op_supp_data_type_code (op_supp_data_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_system_op_supp_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_system_op_supp_data_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_system_op_supp_data_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_system_op_supp_data_op_supp_data_type_cd
    ON camdecmps.system_op_supp_data USING btree
    (op_supp_data_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_system_op_supp_data_mon_loc_id
    ON camdecmps.system_op_supp_data USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_system_op_supp_data_rpt_period_id
    ON camdecmps.system_op_supp_data USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_system_op_supp_data_mon_sys_id
    ON camdecmps.system_op_supp_data USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_system_op_supp_data_rpt_period_id_mon_loc_id
    ON camdecmps.system_op_supp_data USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.test_extension_exemption
    ADD CONSTRAINT pk_test_extension_exemption PRIMARY KEY (test_extension_exemption_id),
    ADD CONSTRAINT fk_test_extension_exemption_component FOREIGN KEY (component_id)
        REFERENCES camdecmps.component (component_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_test_extension_exemption_extension_exemption_code FOREIGN KEY (extens_exempt_cd)
        REFERENCES camdecmpsmd.extension_exemption_code (extens_exempt_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_test_extension_exemption_fuel_code FOREIGN KEY (fuel_cd)
        REFERENCES camdecmpsmd.fuel_code (fuel_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_test_extension_exemption_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_test_extension_exemption_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_test_extension_exemption_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_test_extension_exemption_span_scale_code FOREIGN KEY (span_scale_cd)
        REFERENCES camdecmpsmd.span_scale_code (span_scale_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_test_extension_exemption_submission_availability_code FOREIGN KEY (submission_availability_cd)
        REFERENCES camdecmpsmd.submission_availability_code (submission_availability_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_test_extension_exemption_chk_session_id
    ON camdecmps.test_extension_exemption USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_test_extension_exemption_submission_id
    ON camdecmps.test_extension_exemption USING btree
    (submission_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_test_extension_exemption_component_id
    ON camdecmps.test_extension_exemption USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_test_extension_exemption_extens_exempt_cd
    ON camdecmps.test_extension_exemption USING btree
    (extens_exempt_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_test_extension_exemption_fuel_cd
    ON camdecmps.test_extension_exemption USING btree
    (fuel_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_test_extension_exemption_mon_loc_id
    ON camdecmps.test_extension_exemption USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_test_extension_exemption_mon_sys_id
    ON camdecmps.test_extension_exemption USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_test_extension_exemption_span_scale_cd
    ON camdecmps.test_extension_exemption USING btree
    (span_scale_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_test_extension_exemption_submission_availability_cd
    ON camdecmps.test_extension_exemption USING btree
    (submission_availability_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_test_extension_exemption_rpt_period_id
    ON camdecmps.test_extension_exemption USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_test_extension_exemption_rpt_period_id_mon_loc_id
    ON camdecmps.test_extension_exemption USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.test_summary
	ADD CONSTRAINT pk_test_summary PRIMARY KEY (test_sum_id),
    ADD CONSTRAINT uq_test_summary UNIQUE (mon_loc_id, test_num, test_type_cd),
    ADD CONSTRAINT fk_test_summary_component FOREIGN KEY (component_id)
        REFERENCES camdecmps.component (component_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_test_summary_injection_protocol_code FOREIGN KEY (injection_protocol_cd)
        REFERENCES camdecmpsmd.injection_protocol_code (injection_protocol_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_test_summary_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_test_summary_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_test_summary_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_test_summary_span_scale_code FOREIGN KEY (span_scale_cd)
        REFERENCES camdecmpsmd.span_scale_code (span_scale_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_test_summary_test_reason_code FOREIGN KEY (test_reason_cd)
        REFERENCES camdecmpsmd.test_reason_code (test_reason_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_test_summary_test_result_code FOREIGN KEY (test_result_cd)
        REFERENCES camdecmpsmd.test_result_code (test_result_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_test_summary_test_type_code FOREIGN KEY (test_type_cd)
        REFERENCES camdecmpsmd.test_type_code (test_type_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_test_summary_chk_session_id
    ON camdecmps.test_summary USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_test_summary_component_id
    ON camdecmps.test_summary USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_test_summary_mon_loc_id
    ON camdecmps.test_summary USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_test_summary_mon_sys_id
    ON camdecmps.test_summary USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_test_summary_rpt_period_id
    ON camdecmps.test_summary USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_test_summary_span_scale_cd
    ON camdecmps.test_summary USING btree
    (span_scale_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_test_summary_test_reason_cd
    ON camdecmps.test_summary USING btree
    (test_reason_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_test_summary_test_result_cd
    ON camdecmps.test_summary USING btree
    (test_result_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_test_summary_test_type_cd
    ON camdecmps.test_summary USING btree
    (test_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_test_summary_injection_protocol_cd
    ON camdecmps.test_summary USING btree
    (injection_protocol_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_test_summary_rpt_period_id_mon_loc_id
    ON camdecmps.test_summary USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.weekly_test_summary
    ADD CONSTRAINT pk_weekly_test_summary PRIMARY KEY (weekly_test_sum_id),
    ADD CONSTRAINT fk_weekly_test_summary_component FOREIGN KEY (component_id)
        REFERENCES camdecmps.component (component_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_weekly_test_summary_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_weekly_test_summary_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_weekly_test_summary_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_weekly_test_summary_span_scale_code FOREIGN KEY (span_scale_cd)
        REFERENCES camdecmpsmd.span_scale_code (span_scale_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_weekly_test_summary_test_result_code FOREIGN KEY (test_result_cd)
        REFERENCES camdecmpsmd.test_result_code (test_result_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_weekly_test_summary_test_type_code FOREIGN KEY (test_type_cd)
        REFERENCES camdecmpsmd.test_type_code (test_type_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_weekly_test_summary_component_id
    ON camdecmps.weekly_test_summary USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_weekly_test_summary_mon_loc_id
    ON camdecmps.weekly_test_summary USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_weekly_test_summary_span_scale_cd
    ON camdecmps.weekly_test_summary USING btree
    (span_scale_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_weekly_test_summary_mon_sys_id
    ON camdecmps.weekly_test_summary USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_weekly_test_summary_test_result_cd
    ON camdecmps.weekly_test_summary USING btree
    (test_result_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_weekly_test_summary_test_type_cd
    ON camdecmps.weekly_test_summary USING btree
    (test_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_weekly_test_summary_rpt_period_id
    ON camdecmps.weekly_test_summary USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_weekly_test_summary_rpt_period_id_mon_loc_id
    ON camdecmps.weekly_test_summary USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.ae_correlation_test_sum
    ADD CONSTRAINT pk_ae_correlation_test_sum PRIMARY KEY (ae_corr_test_sum_id),
    ADD CONSTRAINT fk_ae_correlation_test_sum_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmps.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_ae_correlation_test_sum_test_sum_id
    ON camdecmps.ae_correlation_test_sum USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.air_emission_testing
    ADD CONSTRAINT pk_air_emission_testing PRIMARY KEY (air_emission_test_id),
    ADD CONSTRAINT fk_air_emission_testing_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmps.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_air_emission_testing_test_sum_id
    ON camdecmps.air_emission_testing USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.calibration_injection
    ADD CONSTRAINT pk_calibration_injection PRIMARY KEY (cal_inj_id),
    ADD CONSTRAINT fk_calibration_injection_gas_level_code FOREIGN KEY (upscale_gas_level_cd)
        REFERENCES camdecmpsmd.gas_level_code (gas_level_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_calibration_injection_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmps.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_calibration_injection_upscale_gas_level_cd
    ON camdecmps.calibration_injection USING btree
    (upscale_gas_level_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_calibration_injection_test_sum_id
    ON camdecmps.calibration_injection USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.cycle_time_summary
    ADD CONSTRAINT pk_cycle_time_summary PRIMARY KEY (cycle_time_sum_id),
    ADD CONSTRAINT fk_cycle_time_summary_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmps.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_cycle_time_summary_test_sum_id
    ON camdecmps.cycle_time_summary USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.daily_calibration
    ADD CONSTRAINT pk_daily_calibration PRIMARY KEY (cal_inj_id),
    ADD CONSTRAINT fk_daily_calibration_daily_test_summary FOREIGN KEY (daily_test_sum_id)
        REFERENCES camdecmps.daily_test_summary (daily_test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_daily_calibration_gas_level_code FOREIGN KEY (upscale_gas_level_cd)
        REFERENCES camdecmpsmd.gas_level_code (gas_level_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_daily_calibration_injection_protocol_code FOREIGN KEY (injection_protocol_cd)
        REFERENCES camdecmpsmd.injection_protocol_code (injection_protocol_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_daily_calibration_protocol_gas_vendor FOREIGN KEY (vendor_id)
        REFERENCES camdecmps.protocol_gas_vendor (vendor_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_daily_calibration_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_daily_calibration_rpt_period_id
    ON camdecmps.daily_calibration USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_calibrati_daily_test_sum_id
    ON camdecmps.daily_calibration USING btree
    (daily_test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_calibration_vendor_id
    ON camdecmps.daily_calibration USING btree
    (vendor_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_calibration_upscale_gas_level_cd
    ON camdecmps.daily_calibration USING btree
    (upscale_gas_level_cd ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_calibration_injection_protocol_cd
    ON camdecmps.daily_calibration USING btree
    (injection_protocol_cd ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.daily_test_supp_data
    ADD CONSTRAINT pk_daily_test_supp_data PRIMARY KEY (daily_test_supp_data_id),
    ADD CONSTRAINT fk_daily_test_supp_data_component FOREIGN KEY (component_id)
        REFERENCES camdecmps.component (component_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_daily_test_supp_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_daily_test_supp_data_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_daily_test_supp_data_test_result_code FOREIGN KEY (test_result_cd)
        REFERENCES camdecmpsmd.test_result_code (test_result_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_daily_test_supp_data_test_type_code FOREIGN KEY (test_type_cd)
        REFERENCES camdecmpsmd.test_type_code (test_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT ck_daily_test_supp_data_cmp CHECK (COALESCE(delete_ind, 0::numeric) <> 1::numeric AND component_id IS NOT NULL OR COALESCE(delete_ind, 0::numeric) = 1::numeric AND component_id IS NULL),
    ADD CONSTRAINT ck_daily_test_supp_data_dti CHECK (COALESCE(delete_ind, 0::numeric) <> 1::numeric AND daily_test_sum_id IS NOT NULL OR COALESCE(delete_ind, 0::numeric) = 1::numeric AND daily_test_sum_id IS NULL),
    ADD CONSTRAINT ck_daily_test_supp_data_dtt CHECK (COALESCE(delete_ind, 0::numeric) <> 1::numeric AND daily_test_datehourmin IS NOT NULL OR COALESCE(delete_ind, 0::numeric) = 1::numeric AND daily_test_datehourmin IS NULL),
    ADD CONSTRAINT ck_daily_test_supp_data_ohc CHECK (COALESCE(delete_ind, 0::numeric) <> 1::numeric AND op_hour_cnt IS NOT NULL OR COALESCE(delete_ind, 0::numeric) = 1::numeric AND op_hour_cnt IS NULL),
    ADD CONSTRAINT ck_daily_test_supp_data_ssc CHECK (span_scale_cd::text = ANY (ARRAY['H'::character varying, 'L'::character varying, 'N'::character varying]::text[])),
    ADD CONSTRAINT ck_daily_test_supp_data_stt CHECK (COALESCE(delete_ind, 0::numeric) <> 1::numeric AND sort_daily_test_datehourmin IS NOT NULL OR COALESCE(delete_ind, 0::numeric) = 1::numeric AND sort_daily_test_datehourmin IS NULL),
    ADD CONSTRAINT ck_daily_test_supp_data_trs CHECK (COALESCE(delete_ind, 0::numeric) <> 1::numeric AND test_result_cd IS NOT NULL OR COALESCE(delete_ind, 0::numeric) = 1::numeric AND test_result_cd IS NULL)

CREATE INDEX IF NOT EXISTS idx_daily_test_supp_data_component_id
    ON camdecmps.daily_test_supp_data USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_supp_data_daily_test_sum_id
    ON camdecmps.daily_test_supp_data USING btree
    (daily_test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_supp_data_key_online_ind
    ON camdecmps.daily_test_supp_data USING btree
    (key_online_ind ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_supp_data_key_valid_ind
    ON camdecmps.daily_test_supp_data USING btree
    (key_valid_ind ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_supp_data_online_offline_ind
    ON camdecmps.daily_test_supp_data USING btree
    (online_offline_ind ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_supp_data_rpt_period_id
    ON camdecmps.daily_test_supp_data USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_supp_data_span_scale_cd
    ON camdecmps.daily_test_supp_data USING btree
    (span_scale_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_supp_data_test_result_cd
    ON camdecmps.daily_test_supp_data USING btree
    (test_result_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_supp_data_test_type_cd
    ON camdecmps.daily_test_supp_data USING btree
    (test_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_supp_data_mon_loc_id
    ON camdecmps.daily_test_supp_data USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_supp_data_rpt_period_id_mon_loc_id
    ON camdecmps.daily_test_supp_data USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.flow_to_load_check
    ADD CONSTRAINT pk_flow_to_load_check PRIMARY KEY (flow_load_check_id),
    ADD CONSTRAINT fk_flow_to_load_check_operating_level_code FOREIGN KEY (op_level_cd)
        REFERENCES camdecmpsmd.operating_level_code (op_level_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_flow_to_load_check_test_basis_code FOREIGN KEY (test_basis_cd)
        REFERENCES camdecmpsmd.test_basis_code (test_basis_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_flow_to_load_check_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmps.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_flow_to_load_check_op_level_cd
    ON camdecmps.flow_to_load_check USING btree
    (op_level_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_flow_to_load_check_test_basis_cd
    ON camdecmps.flow_to_load_check USING btree
    (test_basis_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_flow_to_load_check_test_sum_id
    ON camdecmps.flow_to_load_check USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.flow_to_load_reference
    ADD CONSTRAINT pk_flow_to_load_reference PRIMARY KEY (flow_load_ref_id),
    ADD CONSTRAINT fk_flow_to_load_reference_operating_level_code FOREIGN KEY (op_level_cd)
        REFERENCES camdecmpsmd.operating_level_code (op_level_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_flow_to_load_reference_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmps.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_flow_to_load_reference_op_level_cd
    ON camdecmps.flow_to_load_reference USING btree
    (op_level_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_flow_to_load_reference_test_sum_id
    ON camdecmps.flow_to_load_reference USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.fuel_flow_to_load_baseline
    ADD CONSTRAINT pk_fuel_flow_to_load_baseline PRIMARY KEY (fuel_flow_baseline_id),
    ADD CONSTRAINT fk_fuel_flow_to_load_baseline_fuel_flow_load_uom FOREIGN KEY (fuel_flow_load_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_fuel_flow_to_load_baseline_ghr_uom FOREIGN KEY (ghr_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_fuel_flow_to_load_baseline_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmps.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_fuel_flow_to_load_baseline_test_sum_id
    ON camdecmps.fuel_flow_to_load_baseline USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_fuel_flow_to_load_baseline_fuel_flow_load_uom_cd
    ON camdecmps.fuel_flow_to_load_baseline USING btree
    (fuel_flow_load_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_fuel_flow_to_load_baseline_ghr_uom_cd
    ON camdecmps.fuel_flow_to_load_baseline USING btree
    (ghr_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.fuel_flow_to_load_check
    ADD CONSTRAINT pk_fuel_flow_to_load_check PRIMARY KEY (fuel_flow_load_id),
    ADD CONSTRAINT fk_fuel_flow_to_load_check_test_basis_code FOREIGN KEY (test_basis_cd)
        REFERENCES camdecmpsmd.test_basis_code (test_basis_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_fuel_flow_to_load_check_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmps.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_fuel_flow_to_load_check_test_sum_id
    ON camdecmps.fuel_flow_to_load_check USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_fuel_flow_to_load_check_test_basis_cd
    ON camdecmps.fuel_flow_to_load_check USING btree
    (test_basis_cd COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.fuel_flowmeter_accuracy
    ADD CONSTRAINT pk_fuel_flowmeter_accuracy PRIMARY KEY (fuel_flow_acc_id),
    ADD CONSTRAINT fk_fuel_flowmeter_accuracy_accuracy_test_method_code FOREIGN KEY (acc_test_method_cd)
        REFERENCES camdecmpsmd.accuracy_test_method_code (acc_test_method_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_fuel_flowmeter_accuracy_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmps.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_fuel_flowmeter_accuracy_test_sum_id
    ON camdecmps.fuel_flowmeter_accuracy USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_fuel_flowmeter_accuracy_acc_test_method_cd
    ON camdecmps.fuel_flowmeter_accuracy USING btree
    (acc_test_method_cd COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.hg_test_summary
    ADD CONSTRAINT pk_hg_test_summary PRIMARY KEY (hg_test_sum_id),
    ADD CONSTRAINT fk_hg_test_summary_gas_level_code FOREIGN KEY (gas_level_cd)
        REFERENCES camdecmpsmd.gas_level_code (gas_level_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_hg_test_summary_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmps.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_hg_test_summary_test_sum_id
    ON camdecmps.hg_test_summary USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hg_test_summary_gas_level_cd
    ON camdecmps.hg_test_summary USING btree
    (gas_level_cd COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.hrly_param_fuel_flow
    ADD CONSTRAINT pk_hrly_param_fuel_flow PRIMARY KEY (hrly_param_ff_id),
    ADD CONSTRAINT fk_hrly_param_fuel_flow_hrly_fuel_flow FOREIGN KEY (hrly_fuel_flow_id)
        REFERENCES camdecmps.hrly_fuel_flow (hrly_fuel_flow_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_hrly_param_fuel_flow_monitor_formula FOREIGN KEY (mon_form_id)
        REFERENCES camdecmps.monitor_formula (mon_form_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_hrly_param_fuel_flow_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_hrly_param_fuel_flow_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_hrly_param_fuel_flow_operating_condition_code FOREIGN KEY (operating_condition_cd)
        REFERENCES camdecmpsmd.operating_condition_code (operating_condition_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_hrly_param_fuel_flow_parameter_code FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_hrly_param_fuel_flow_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_hrly_param_fuel_flow_sample_type_code FOREIGN KEY (sample_type_cd)
        REFERENCES camdecmpsmd.sample_type_code (sample_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_hrly_param_fuel_flow_units_of_measure_code FOREIGN KEY (parameter_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_hrly_param_fuel_flow_hrly_fuel_flow_id
    ON camdecmps.hrly_param_fuel_flow USING btree
    (hrly_fuel_flow_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_param_fuel_flow_mon_form_id
    ON camdecmps.hrly_param_fuel_flow USING btree
    (mon_form_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_param_fuel_flow_mon_loc_id
    ON camdecmps.hrly_param_fuel_flow USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_param_fuel_flow_mon_sys_id
    ON camdecmps.hrly_param_fuel_flow USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_param_fuel_flow_operating_condition_cd
    ON camdecmps.hrly_param_fuel_flow USING btree
    (operating_condition_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_param_fuel_flow_parameter_cd
    ON camdecmps.hrly_param_fuel_flow USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_param_fuel_flow_rpt_period_id
    ON camdecmps.hrly_param_fuel_flow USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_param_fuel_flow_sample_type_cd
    ON camdecmps.hrly_param_fuel_flow USING btree
    (sample_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_param_fuel_flow_parameter_uom_cd
    ON camdecmps.hrly_param_fuel_flow USING btree
    (parameter_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_param_fuel_flow_rpt_period_id_mon_loc_id
    ON camdecmps.hrly_param_fuel_flow USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.linearity_summary
    ADD CONSTRAINT pk_linearity_summary PRIMARY KEY (lin_sum_id),
    ADD CONSTRAINT fk_linearity_summary_gas_level_code FOREIGN KEY (gas_level_cd)
        REFERENCES camdecmpsmd.gas_level_code (gas_level_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_linearity_summary_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmps.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_linearity_summary_gas_level_cd
    ON camdecmps.linearity_summary USING btree
    (gas_level_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_linearity_summary_test_sum_id
    ON camdecmps.linearity_summary USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.on_off_cal
    ADD CONSTRAINT pk_on_off_cal PRIMARY KEY (on_off_cal_id),
    ADD CONSTRAINT fk_on_off_cal_gas_level_code FOREIGN KEY (upscale_gas_level_cd)
        REFERENCES camdecmpsmd.gas_level_code (gas_level_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_on_off_cal_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmps.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_on_off_cal_test_sum_id
    ON camdecmps.on_off_cal USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_on_off_cal_upscale_gas_level_cd
    ON camdecmps.on_off_cal USING btree
    (upscale_gas_level_cd COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.protocol_gas
    ADD CONSTRAINT pk_protocol_gas PRIMARY KEY (protocol_gas_id),
    ADD CONSTRAINT fk_protocol_gas_gas_level_code FOREIGN KEY (gas_level_cd)
        REFERENCES camdecmpsmd.gas_level_code (gas_level_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_protocol_gas_gas_type_code FOREIGN KEY (gas_type_cd)
        REFERENCES camdecmpsmd.gas_type_code (gas_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_protocol_gas_protocol_gas_vendor FOREIGN KEY (vendor_id)
        REFERENCES camdecmpsmd.protocol_gas_vendor (vendor_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_protocol_gas_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmps.test_summary (test_sum_id) MATCH SIMPLE;
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_protocol_gas_test_sum_id
    ON camdecmps.protocol_gas USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_protocol_gas_gas_level_cd
    ON camdecmps.protocol_gas USING btree
    (gas_level_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_protocol_gas_gas_type_cd
    ON camdecmps.protocol_gas USING btree
    (gas_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_protocol_gas_vendor_id
    ON camdecmps.protocol_gas USING btree
    (vendor_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.qa_cert_event_supp_data
    ADD CONSTRAINT pk_qa_cert_event_supp_data PRIMARY KEY (qa_cert_event_supp_data_id),
    ADD CONSTRAINT fk_qa_cert_event_supp_data_data_cd FOREIGN KEY (qa_cert_event_supp_data_cd)
        REFERENCES camdecmpsmd.qa_cert_event_supp_data_code (qa_cert_event_supp_data_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_qa_cert_event_supp_data_date_cd FOREIGN KEY (qa_cert_event_supp_date_cd)
        REFERENCES camdecmpsmd.qa_cert_event_supp_date_code (qa_cert_event_supp_date_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_qa_cert_event_supp_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_qa_cert_event_supp_data_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmps.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_qa_cert_event_supp_data_qa_cert_event FOREIGN KEY (qa_cert_event_id)
        REFERENCES camdecmps.qa_cert_event (qa_cert_event_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_supp_data_qa_cert_event_id
    ON camdecmps.qa_cert_event_supp_data USING btree
    (qa_cert_event_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_supp_data_qa_cert_event_supp_data_cd
    ON camdecmps.qa_cert_event_supp_data USING btree
    (qa_cert_event_supp_data_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_supp_data_qa_cert_event_supp_date_cd
    ON camdecmps.qa_cert_event_supp_data USING btree
    (qa_cert_event_supp_date_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_supp_data_mon_loc_id
    ON camdecmps.qa_cert_event_supp_data USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_supp_data_rpt_period_id
    ON camdecmps.qa_cert_event_supp_data USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_supp_data_rpt_period_id_mon_loc_id
    ON camdecmps.qa_cert_event_supp_data USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.qa_supp_data
    ADD CONSTRAINT pk_qa_supp_data PRIMARY KEY (qa_supp_data_id),
    ADD CONSTRAINT fk_qa_supp_data_component FOREIGN KEY (component_id)
        REFERENCES camdecmps.component (component_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_qa_supp_data_fuel_code FOREIGN KEY (fuel_cd)
        REFERENCES camdecmpsmd.fuel_code (fuel_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_qa_supp_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_qa_supp_data_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_qa_supp_data_operating_condition_code FOREIGN KEY (operating_condition_cd)
        REFERENCES camdecmpsmd.operating_condition_code (operating_condition_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_qa_supp_data_operating_level_code FOREIGN KEY (op_level_cd)
        REFERENCES camdecmpsmd.operating_level_code (op_level_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_qa_supp_data_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_qa_supp_data_submission_availability_code FOREIGN KEY (submission_availability_cd)
        REFERENCES camdecmpsmd.submission_availability_code (submission_availability_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_qa_supp_data_submission_test_reason_code FOREIGN KEY (test_reason_cd)
        REFERENCES camdecmpsmd.test_reason_code (test_reason_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_qa_supp_data_submission_test_result_code FOREIGN KEY (test_result_cd)
        REFERENCES camdecmpsmd.test_result_code (test_result_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_qa_supp_data_submission_test_type_code FOREIGN KEY (test_type_cd)
        REFERENCES camdecmpsmd.test_type_code (test_type_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_qa_supp_data_test_sum_id
    ON camdecmps.qa_supp_data USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_supp_data_chk_session_id
    ON camdecmps.qa_supp_data USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_supp_data_component_id
    ON camdecmps.qa_supp_data USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_supp_data_fuel_cd
    ON camdecmps.qa_supp_data USING btree
    (fuel_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_supp_data_mon_loc_id
    ON camdecmps.qa_supp_data USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_supp_data_mon_sys_id
    ON camdecmps.qa_supp_data USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_supp_data_op_level_cd
    ON camdecmps.qa_supp_data USING btree
    (op_level_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_supp_data_operating_condition_cd
    ON camdecmps.qa_supp_data USING btree
    (operating_condition_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_supp_data_submission_availability_cd
    ON camdecmps.qa_supp_data USING btree
    (submission_availability_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_supp_data_submission_id
    ON camdecmps.qa_supp_data USING btree
    (submission_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_supp_data_test_reason_cd
    ON camdecmps.qa_supp_data USING btree
    (test_reason_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_supp_data_test_result_cd
    ON camdecmps.qa_supp_data USING btree
    (test_result_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_supp_data_test_type_cd
    ON camdecmps.qa_supp_data USING btree
    (test_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_supp_data_rpt_period_id
    ON camdecmps.qa_supp_data USING btree
    (rpt_period_id ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.rata
	ADD CONSTRAINT pk_rata PRIMARY KEY (rata_id),
    ADD CONSTRAINT fk_rata_rata_frequency_code FOREIGN KEY (rata_frequency_cd)
        REFERENCES camdecmpsmd.rata_frequency_code (rata_frequency_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_rata_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmps.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_rata_test_sum_id
    ON camdecmps.rata USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_rata_rata_frequency_cd
    ON camdecmps.rata USING btree
    (rata_frequency_cd COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.sampling_train_supp_data
	ADD CONSTRAINT pk_sampling_train_supp_data PRIMARY KEY (trap_train_id),
    ADD CONSTRAINT fk_sampling_train_supp_data_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_sampling_train_supp_data_test_result_code FOREIGN KEY (sampling_ratio_test_result_cd)
        REFERENCES camdecmpsmd.test_result_code (test_result_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_sampling_train_supp_data_train_qa_status_code FOREIGN KEY (train_qa_status_cd)
        REFERENCES camdecmpsmd.train_qa_status_code (train_qa_status_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_sampling_train_supp_data_component FOREIGN KEY (component_id)
        REFERENCES camdecmps.component (component_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_sampling_train_supp_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_sampling_train_supp_data_sorbent_trap_supp_data FOREIGN KEY (trap_id)
        REFERENCES camdecmps.sorbent_trap_supp_data (trap_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_sampling_train_supp_data_trap_id
    ON camdecmps.sampling_train_supp_data USING btree
    (trap_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sampling_train_supp_data_component_id
    ON camdecmps.sampling_train_supp_data USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sampling_train_supp_data_mon_loc_id
    ON camdecmps.sampling_train_supp_data USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sampling_train_supp_data_rpt_period_id
    ON camdecmps.sampling_train_supp_data USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sampling_train_supp_data_sampling_ratio_test_result_cd
    ON camdecmps.sampling_train_supp_data USING btree
    (sampling_ratio_test_result_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sampling_train_supp_data_train_qa_status_cd
    ON camdecmps.sampling_train_supp_data USING btree
    (train_qa_status_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sampling_train_supp_data_rpt_period_id_mon_loc_id
    ON camdecmps.sampling_train_supp_data USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.sampling_train
    ADD CONSTRAINT pk_sampling_train PRIMARY KEY (trap_train_id),
    ADD CONSTRAINT fk_sampling_train_component FOREIGN KEY (component_id)
        REFERENCES camdecmps.component (component_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_sampling_train_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_sampling_train_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_sampling_train_sorbent_trap FOREIGN KEY (trap_id)
        REFERENCES camdecmps.sorbent_trap (trap_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_sampling_train_test_result_code_post_leak FOREIGN KEY (post_leak_test_result_cd)
        REFERENCES camdecmpsmd.test_result_code (test_result_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_sampling_train_test_result_code_sampling_ratio FOREIGN KEY (sampling_ratio_test_result_cd)
        REFERENCES camdecmpsmd.test_result_code (test_result_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_sampling_train_train_qa_status_code FOREIGN KEY (train_qa_status_cd)
        REFERENCES camdecmpsmd.train_qa_status_code (train_qa_status_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_sampling_train_trap_id
    ON camdecmps.sampling_train USING btree
    (trap_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sampling_train_mon_loc_id
    ON camdecmps.sampling_train USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sampling_train_rpt_period_id
    ON camdecmps.sampling_train USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sampling_train_component_id
    ON camdecmps.sampling_train USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sampling_train_sampling_ratio_test_result_cd
    ON camdecmps.sampling_train USING btree
    (sampling_ratio_test_result_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sampling_train_post_leak_test_result_cd
    ON camdecmps.sampling_train USING btree
    (post_leak_test_result_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sampling_train_train_qa_status_cd
    ON camdecmps.sampling_train USING btree
    (train_qa_status_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sampling_train_rpt_period_id_mon_loc_id
    ON camdecmps.sampling_train USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.test_qualification
    ADD CONSTRAINT pk_test_qualification PRIMARY KEY (test_qualification_id),
    ADD CONSTRAINT fk_test_qualification_test_claim_code FOREIGN KEY (test_claim_cd)
        REFERENCES camdecmpsmd.test_claim_code (test_claim_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_test_qualification_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmps.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_test_qualification_test_claim_cd
    ON camdecmps.test_qualification USING btree
    (test_claim_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_test_qualification_test_sum_id
    ON camdecmps.test_qualification USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.trans_accuracy
    ADD CONSTRAINT pk_trans_accuracy PRIMARY KEY (trans_ac_id),
    ADD CONSTRAINT fk_trans_accuracy_accuracy_spec_code_high FOREIGN KEY (high_level_accuracy_spec_cd)
        REFERENCES camdecmpsmd.accuracy_spec_code (accuracy_spec_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_trans_accuracy_accuracy_spec_code_low FOREIGN KEY (low_level_accuracy_spec_cd)
        REFERENCES camdecmpsmd.accuracy_spec_code (accuracy_spec_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_trans_accuracy_accuracy_spec_code_mid FOREIGN KEY (mid_level_accuracy_spec_cd)
        REFERENCES camdecmpsmd.accuracy_spec_code (accuracy_spec_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_trans_accuracy_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmps.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_trans_accuracy_test_sum_id
    ON camdecmps.trans_accuracy USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_trans_accuracy_high_level_accuracy_spec_cd
    ON camdecmps.trans_accuracy USING btree
    (high_level_accuracy_spec_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_trans_accuracy_low_level_accuracy_spec_cd
    ON camdecmps.trans_accuracy USING btree
    (low_level_accuracy_spec_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_trans_accuracy_mid_level_accuracy_spec_cd
    ON camdecmps.trans_accuracy USING btree
    (mid_level_accuracy_spec_cd COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.unit_default_test
    ADD CONSTRAINT pk_unt_default_test PRIMARY KEY (unit_default_test_sum_id),
    ADD CONSTRAINT fk_unt_default_test_fuel_code FOREIGN KEY (fuel_cd)
        REFERENCES camdecmpsmd.fuel_code (fuel_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_unt_default_test_operating_condition_code FOREIGN KEY (operating_condition_cd)
        REFERENCES camdecmpsmd.operating_condition_code (operating_condition_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_unt_default_test_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmps.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_unit_default_test_fuel_cd
    ON camdecmps.unit_default_test USING btree
    (fuel_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_unit_default_test_operating_condition_cd
    ON camdecmps.unit_default_test USING btree
    (operating_condition_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_unit_default_test_test_sum_id
    ON camdecmps.unit_default_test USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.weekly_system_integrity
    ADD CONSTRAINT pk_weekly_system_integrity PRIMARY KEY (weekly_sys_integrity_id),
    ADD CONSTRAINT fk_weekly_system_integrity_gas_level_code FOREIGN KEY (gas_level_cd)
        REFERENCES camdecmpsmd.gas_level_code (gas_level_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_weekly_system_integrity_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_weekly_system_integrity_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_weekly_system_integrity_weekly_test_summary FOREIGN KEY (weekly_test_sum_id)
        REFERENCES camdecmps.weekly_test_summary (weekly_test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_weekly_system_integrity_gas_level_cd
    ON camdecmps.weekly_system_integrity USING btree
    (gas_level_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_weekly_system_integrity_mon_loc_id
    ON camdecmps.weekly_system_integrity USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_weekly_system_integrity_rpt_period_id
    ON camdecmps.weekly_system_integrity USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_weekly_system_integrity_weekly_test_sum_id
    ON camdecmps.weekly_system_integrity USING btree
    (weekly_test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_weekly_system_integrity_rpt_period_id_mon_loc_id
    ON camdecmps.weekly_system_integrity USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.ae_correlation_test_run
    ADD CONSTRAINT pk_ae_correlation_test_run PRIMARY KEY (ae_corr_test_run_id),
    ADD CONSTRAINT fk_ae_correlation_test_run_ae_correlation_test_sum FOREIGN KEY (ae_corr_test_sum_id)
        REFERENCES camdecmps.ae_correlation_test_sum (ae_corr_test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_ae_correlation_test_run_ae_corr_test_sum_id
    ON camdecmps.ae_correlation_test_run USING btree
    (ae_corr_test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.cycle_time_injection
    ADD CONSTRAINT pk_cycle_time_injection PRIMARY KEY (cycle_time_inj_id),
    ADD CONSTRAINT fk_cycle_time_injection_cycle_time_summary FOREIGN KEY (cycle_time_sum_id)
        REFERENCES camdecmps.cycle_time_summary (cycle_time_sum_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_cycle_time_injection_gas_level_code FOREIGN KEY (gas_level_cd)
        REFERENCES camdecmpsmd.gas_level_code (gas_level_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_cycle_time_injection_cycle_time_sum_id
    ON camdecmps.cycle_time_injection USING btree
    (cycle_time_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_cycle_time_injection_gas_level_cd
    ON camdecmps.cycle_time_injection USING btree
    (gas_level_cd COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.daily_test_system_supp_data
	ADD CONSTRAINT pk_daily_test_system_supp_data PRIMARY KEY (daily_test_system_supp_data_id),
    ADD CONSTRAINT fk_daily_test_system_sup_data_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_daily_test_system_supp_data_daily_test_supp_data FOREIGN KEY (daily_test_supp_data_id)
        REFERENCES camdecmps.daily_test_supp_data (daily_test_supp_data_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_daily_test_system_supp_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_daily_test_system_supp_data_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_daily_test_system_supp_data_daily_test_supp_data_id
    ON camdecmps.daily_test_system_supp_data USING btree
    (daily_test_supp_data_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_system_supp_data_mon_loc_id
    ON camdecmps.daily_test_system_supp_data USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_system_supp_data_mon_sys_id
    ON camdecmps.daily_test_system_supp_data USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_system_supp_data_rpt_period_id
    ON camdecmps.daily_test_system_supp_data USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_system_supp_data_rpt_period_id_mon_loc_id
    ON camdecmps.daily_test_system_supp_data USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.hg_test_injection
    ADD CONSTRAINT pk_hg_test_injection PRIMARY KEY (hg_test_inj_id),
    ADD CONSTRAINT fk_hg_test_injection_hg_test_summary FOREIGN KEY (hg_test_sum_id)
        REFERENCES camdecmps.hg_test_summary (hg_test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_hg_test_injection_hg_test_sum_id
    ON camdecmps.hg_test_injection USING btree
    (hg_test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.linearity_injection
    ADD CONSTRAINT pk_linearity_injection PRIMARY KEY (lin_inj_id),
    ADD CONSTRAINT fk_linearity_injection_linearity_summary FOREIGN KEY (lin_sum_id)
        REFERENCES camdecmps.linearity_summary (lin_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_linearity_injection_lin_sum_id
    ON camdecmps.linearity_injection USING btree
    (lin_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.qa_supp_attribute
    ADD CONSTRAINT pk_qa_supp_attribute PRIMARY KEY (qa_supp_attribute_id),
    ADD CONSTRAINT fk_qa_supp_attribute_qa_supp_data FOREIGN KEY (qa_supp_data_id)
        REFERENCES camdecmps.qa_supp_data (qa_supp_data_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_qa_supp_attribute_qa_supp_data_id
    ON camdecmps.qa_supp_attribute USING btree
    (qa_supp_data_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.rata_summary
    ADD CONSTRAINT pk_rata_summary PRIMARY KEY (rata_sum_id),
    ADD CONSTRAINT fk_rata_summary_aps_code FOREIGN KEY (aps_cd)
        REFERENCES camdecmpsmd.aps_code (aps_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_rata_summary_operating_level_code FOREIGN KEY (op_level_cd)
        REFERENCES camdecmpsmd.operating_level_code (op_level_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_rata_summary_rata FOREIGN KEY (rata_id)
        REFERENCES camdecmps.rata (rata_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_rata_summary_ref_method_code FOREIGN KEY (ref_method_cd)
        REFERENCES camdecmpsmd.ref_method_code (ref_method_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_rata_summary_ref_method_code_co2o2 FOREIGN KEY (co2_o2_ref_method_cd)
        REFERENCES camdecmpsmd.ref_method_code (ref_method_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_rata_summary_aps_code
    ON camdecmps.rata_summary USING btree
    (aps_code COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_rata_summary_co2_o2_ref_method_cd
    ON camdecmps.rata_summary USING btree
    (co2_o2_ref_method_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_rata_summary_op_level_cd
    ON camdecmps.rata_summary USING btree
    (op_level_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_rata_summary_rata_id
    ON camdecmps.rata_summary USING btree
    (rata_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_rata_summary_ref_method_cd
    ON camdecmps.rata_summary USING btree
    (ref_method_cd COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.unit_default_test_run
    ADD CONSTRAINT pk_unit_default_test_run PRIMARY KEY (unit_default_test_run_id),
    ADD CONSTRAINT fk_unit_default_test_run_unit_default_test FOREIGN KEY (unit_default_test_sum_id)
        REFERENCES camdecmps.unit_default_test (unit_default_test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_unit_default_test_run_unit_default_test_sum_id
    ON camdecmps.unit_default_test_run USING btree
    (unit_default_test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.ae_hi_gas
    ADD CONSTRAINT pk_ae_hi_gas PRIMARY KEY (ae_hi_gas_id),
    ADD CONSTRAINT fk_ae_hi_gas_ae_correlation_test_run FOREIGN KEY (ae_corr_test_run_id)
        REFERENCES camdecmps.ae_correlation_test_run (ae_corr_test_run_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_ae_hi_gas_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_ae_hi_gas_ae_corr_test_run_id
    ON camdecmps.ae_hi_gas USING btree
    (ae_corr_test_run_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_ae_hi_gas_mon_sys_id
    ON camdecmps.ae_hi_gas USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.ae_hi_oil
    ADD CONSTRAINT pk_ae_hi_oil PRIMARY KEY (ae_hi_oil_id),
    ADD CONSTRAINT fk_ae_hi_oil_ae_correlation_test_run FOREIGN KEY (ae_corr_test_run_id)
        REFERENCES camdecmps.ae_correlation_test_run (ae_corr_test_run_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_ae_hi_oil_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_ae_hi_oil_oil_density_uom FOREIGN KEY (oil_density_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_ae_hi_oil_oil_gcv_uom FOREIGN KEY (oil_gcv_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_ae_hi_oil_oil_volume_uom FOREIGN KEY (oil_volume_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_ae_hi_oil_ae_corr_test_run_id
    ON camdecmps.ae_hi_oil USING btree
    (ae_corr_test_run_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_ae_hi_oil_mon_sys_id
    ON camdecmps.ae_hi_oil USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_ae_hi_oil_oil_density_uom_cd
    ON camdecmps.ae_hi_oil USING btree
    (oil_density_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_ae_hi_oil_oil_gcv_uom_cd
    ON camdecmps.ae_hi_oil USING btree
    (oil_gcv_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_ae_hi_oil_oil_volume_uom_cd
    ON camdecmps.ae_hi_oil USING btree
    (oil_volume_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.rata_run
    ADD CONSTRAINT pk_rata_run PRIMARY KEY (rata_run_id),
    ADD CONSTRAINT fk_rata_run_rata_summary FOREIGN KEY (rata_sum_id)
        REFERENCES camdecmps.rata_summary (rata_sum_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_rata_run_run_status_code FOREIGN KEY (run_status_cd)
        REFERENCES camdecmpsmd.run_status_code (run_status_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_rata_run_run_status_cd
    ON camdecmps.rata_run USING btree
    (run_status_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_rata_run_rata_sum_id
    ON camdecmps.rata_run USING btree
    (rata_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.flow_rata_run
    ADD CONSTRAINT pk_flow_rata_run PRIMARY KEY (flow_rata_run_id),
    ADD CONSTRAINT fk_flow_rata_run_rata_run FOREIGN KEY (rata_run_id)
        REFERENCES camdecmps.rata_run (rata_run_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_flow_rata_run_rata_run_id
    ON camdecmps.flow_rata_run USING btree
    (rata_run_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.rata_traverse
    ADD CONSTRAINT pk_rata_traverse PRIMARY KEY (rata_traverse_id),
    ADD CONSTRAINT fk_rata_traverse_flow_rata_run FOREIGN KEY (flow_rata_run_id)
        REFERENCES camdecmps.flow_rata_run (flow_rata_run_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_rata_traverse_pressure_measure_code FOREIGN KEY (pressure_meas_cd)
        REFERENCES camdecmpsmd.pressure_measure_code (pressure_meas_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_rata_traverse_probe_type_code FOREIGN KEY (probe_type_cd)
        REFERENCES camdecmpsmd.probe_type_code (probe_type_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_rata_traverse_flow_rata_run_id
    ON camdecmps.rata_traverse USING btree
    (flow_rata_run_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_rata_traverse_pressure_meas_cd
    ON camdecmps.rata_traverse USING btree
    (pressure_meas_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_rata_traverse_probe_type_cd
    ON camdecmps.rata_traverse USING btree
    (probe_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
/* CAMDECMPSAUX */
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpsaux.apportionment
	ADD CONSTRAINT pk_apportionment PRIMARY KEY (apport_id),
    ADD CONSTRAINT fk_apportionment_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmps.monitor_plan (mon_plan_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_apportionment_begin_rpt_period_id FOREIGN KEY (begin_rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_apportionment_end_rpt_period_id FOREIGN KEY (end_rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_apportionment_mon_plan_id
    ON camdecmpsaux.apportionment USING btree
    (mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_apportionment_begin_rpt_period_id
    ON camdecmpsaux.apportionment USING btree
    (begin_rpt_period_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_apportionment_end_rpt_period_id
    ON camdecmpsaux.apportionment USING btree
    (end_rpt_period_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpsaux.check_session
	ADD CONSTRAINT pk_check_session PRIMARY KEY (chk_session_id),
    ADD CONSTRAINT fk_check_session_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_check_session_category_code FOREIGN KEY (category_cd)
        REFERENCES camdecmpsmd.category_code (category_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_check_session_process_code FOREIGN KEY (process_cd)
        REFERENCES camdecmpsmd.process_code (process_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_check_session_severity_code FOREIGN KEY (severity_cd)
        REFERENCES camdecmpsmd.severity_code (severity_cd) MATCH SIMPLE,
    ADD CONSTRAINT chk_check_session_begin_date_lte_end_date CHECK (session_begin_date <= session_end_date);

CREATE INDEX IF NOT EXISTS idx_check_session_test_extension_exemption_id
    ON camdecmpsaux.check_session USING btree
    (test_extension_exemption_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_session_qa_cert_event_id
    ON camdecmpsaux.check_session USING btree
    (qa_cert_event_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_session_mon_plan_id
    ON camdecmpsaux.check_session USING btree
    (mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_session_test_sum_id
    ON camdecmpsaux.check_session USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_session_rpt_period_id
    ON camdecmpsaux.check_session USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_session_submission_id
    ON camdecmpsaux.check_session USING btree
    (submission_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_session_category_cd
    ON camdecmpsaux.check_session USING btree
    (category_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_session_process_cd
    ON camdecmpsaux.check_session USING btree
    (process_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_session_severity_cd
    ON camdecmpsaux.check_session USING btree
    (severity_cd COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpsaux.em_submission_access
	ADD CONSTRAINT pk_em_submission_access PRIMARY KEY (em_sub_access_id),
    ADD CONSTRAINT uq_em_submission_access UNIQUE (mon_plan_id, rpt_period_id, access_begin_date, access_end_date),
    ADD CONSTRAINT fk_em_submission_access_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmps.monitor_plan (mon_plan_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_em_submission_access_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_em_submission_access_em_status_code FOREIGN KEY (em_status_cd)
        REFERENCES camdecmpsmd.em_status_code (em_status_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_em_submission_access_em_sub_type_code FOREIGN KEY (em_sub_type_cd)
        REFERENCES camdecmpsmd.em_sub_type_code (em_sub_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_em_submission_access_submission_availability_code FOREIGN KEY (sub_availability_cd)
        REFERENCES camdecmpsmd.submission_availability_code (sub_availability_cd) MATCH SIMPLE,
    ADD CONSTRAINT chk_em_submission_access_begin_date_lte_end_date CHECK (access_begin_date <= access_end_date);

CREATE INDEX IF NOT EXISTS idx_em_submission_access_mon_plan_id
    ON camdecmpsaux.em_submission_access USING btree
    (mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_em_submission_access_em_status_cd
    ON camdecmpsaux.em_submission_access USING btree
    (em_status_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_em_submission_access_em_sub_type_cd
    ON camdecmpsaux.em_submission_access USING btree
    (em_sub_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_em_submission_access_rpt_period_id
    ON camdecmpsaux.em_submission_access USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_em_submission_access_sub_availability_cd
    ON camdecmpsaux.em_submission_access USING btree
    (sub_availability_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_em_submission_access_rpt_period_id_mon_plan_id
    ON camdecmpsaux.em_submission_access USING btree
    (rpt_period_id ASC NULLS LAST, mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpsaux.es_spec
	ADD CONSTRAINT pk_es_spec PRIMARY KEY (es_spec_id),
    ADD CONSTRAINT fk_es_spec_check_catalog_result FOREIGN KEY (check_catalog_result_id)
        REFERENCES camdecmpsmd.check_catalog_result (check_catalog_result_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_es_spec_es_match_data_type_code FOREIGN KEY (es_match_data_type_cd)
        REFERENCES camdecmpsmd.es_match_data_type_code (es_match_data_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_es_spec_plant FOREIGN KEY (fac_id)
        REFERENCES camd.plant (fac_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_es_spec_es_reason_code FOREIGN KEY (es_reason_cd)
        REFERENCES camdecmpsmd.es_reason_code (es_reason_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_es_spec_severity_code FOREIGN KEY (severity_cd)
        REFERENCES camdecmpsmd.severity_code (severity_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_es_spec_es_match_time_type_code FOREIGN KEY (es_match_time_type_cd)
        REFERENCES camdecmpsmd.es_match_time_type_code (es_match_time_type_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_es_spec_check_catalog_result_id
    ON camdecmpsaux.es_spec USING btree
    (check_catalog_result_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_es_spec_severity_cd
    ON camdecmpsaux.es_spec USING btree
    (severity_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_es_spec_fac_id
    ON camdecmpsaux.es_spec USING btree
    (fac_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_es_spec_es_match_data_type_cd
    ON camdecmpsaux.es_spec USING btree
    (es_match_data_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_es_spec_es_match_time_type_cd
    ON camdecmpsaux.es_spec USING btree
    (es_match_time_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_es_spec_es_reason_cd
    ON camdecmpsaux.es_spec USING btree
    (es_reason_cd COLLATE pg_catalog."default" ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpsaux.evaluation_set
	ADD CONSTRAINT pk_evaluation_set PRIMARY KEY (evaluation_set_id),
    ADD CONSTRAINT fk_evaluation_set_plant FOREIGN KEY (fac_id)
        REFERENCES camd.plant (fac_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_evaluation_set_mon_plan_id
    ON camdecmpsaux.evaluation_set USING btree
    (mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_evaluation_set_fac_id
    ON camdecmpsaux.evaluation_set USING btree
    (fac_id ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpsaux.program_parameter
	ADD CONSTRAINT pk_program_parameter PRIMARY KEY (prg_param_id),
    ADD CONSTRAINT uq_program_parameter UNIQUE (prg_id, parameter_cd, begin_rpt_period_id),
    ADD CONSTRAINT fk_program_parameter_begin_rpt_period FOREIGN KEY (begin_rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_program_parameter_end_rpt_period FOREIGN KEY (end_rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_program_parameter_parameter_code FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_program_parameter_program FOREIGN KEY (prg_id)
        REFERENCES camd.program (prg_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_program_parameter_begin_rpt_period_id
    ON camdecmpsaux.program_parameter USING btree
    (begin_rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_program_parameter_end_rpt_period_id
    ON camdecmpsaux.program_parameter USING btree
    (end_rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_program_parameter_parameter_cd
    ON camdecmpsaux.program_parameter USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_program_parameter_prg_id
    ON camdecmpsaux.program_parameter USING btree
    (prg_id ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpsaux.submission_set
    ADD CONSTRAINT pk_submission_set PRIMARY KEY (submission_set_id),
    ADD CONSTRAINT fk_submission_set_plant FOREIGN KEY (fac_id)
        REFERENCES camd.plant (mon_plan_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_submission_set_mon_plan_id
    ON camdecmpsaux.submission_set USING btree
    (mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_submission_set_status_cd
    ON camdecmpsaux.submission_set USING btree
    (status_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_submission_set_fac_id
    ON camdecmpsaux.submission_set USING btree
    (fac_id ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpsaux.apportionment_range
	ADD CONSTRAINT pk_apportionment_range PRIMARY KEY (apport_range_id),
    ADD CONSTRAINT fk_apportionment_range_apportionment FOREIGN KEY (apport_id)
        REFERENCES camdecmpsaux.apportionment (apport_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_apportionment_range_apport_id
    ON camdecmpsaux.apportionment_range USING btree
    (apport_id ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpsaux.check_log
	ADD CONSTRAINT pk_check_log PRIMARY KEY (chk_log_id),
    ADD CONSTRAINT fk_check_log_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpsaux.check_session (chk_session_id) MATCH SIMPLE
		ON DELETE CASCADE,
    ADD CONSTRAINT fk_check_log_rule_check FOREIGN KEY (rule_check_id)
        REFERENCES camdecmpsmd.rule_check (rule_check_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_check_log_check_catalog_result FOREIGN KEY (check_catalog_result_id)
        REFERENCES camdecmpsmd.check_catalog_result (check_catalog_result_id) MATCH SIMPLE,
	ADD CONSTRAINT fk_check_log_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
		ON DELETE CASCADE,
	ADD CONSTRAINT fk_check_log_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmps.test_summary (test_sum_id) MATCH SIMPLE
		ON DELETE CASCADE,
    ADD CONSTRAINT fk_check_log_severity_code FOREIGN KEY (severity_cd)
        REFERENCES camdecmpsmd.severity_code (severity_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_check_log_severity_code_suppressed FOREIGN KEY (suppressed_severity_cd)
        REFERENCES camdecmpsmd.severity_code (severity_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_check_log_es_spec FOREIGN KEY (error_suppress_id)
        REFERENCES camdecmpsaux.es_spec (es_spec_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_check_log_chk_session_id
    ON camdecmpsaux.check_log USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_log_rule_check_id
    ON camdecmpsaux.check_log USING btree
    (rule_check_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_log_check_catalog_result_id
    ON camdecmpsaux.check_log USING btree
    (check_catalog_result_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_log_mon_loc_id
    ON camdecmpsaux.check_log USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_log_test_sum_id
    ON camdecmpsaux.check_log USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_log_check_result
    ON camdecmpsaux.check_log USING btree
    (check_result COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_log_severity_cd
    ON camdecmpsaux.check_log USING btree
    (severity_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_log_suppressed_severity_cd
    ON camdecmpsaux.check_log USING btree
    (suppressed_severity_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_log_check_cd
    ON camdecmpsaux.check_log USING btree
    (check_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_log_error_suppress_id
    ON camdecmpsaux.check_log USING btree
    (error_suppress_id ASC NULLS LAST);
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpsaux.email_to_process
	ADD CONSTRAINT pk_email_to_process PRIMARY KEY (to_process_id),
    ADD CONSTRAINT fk_email_to_process_em_sub_access FOREIGN KEY (em_sub_access_id)
        REFERENCES camdecmpsaux.em_submission_access (em_sub_access_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_email_to_process_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmps.monitor_plan (mon_plan_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_email_to_process_plant FOREIGN KEY (fac_id)
        REFERENCES camd.plant (fac_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_email_to_process_rpt_period_id FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_email_to_process_fac_id
    ON camdecmpsaux.email_to_process USING btree
    (fac_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_email_to_process_email_type
    ON camdecmpsaux.email_to_process USING btree
    (email_type COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_email_to_process_event_code
    ON camdecmpsaux.email_to_process USING btree
    (event_code COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_email_to_process_mon_plan_id
    ON camdecmpsaux.email_to_process USING btree
    (mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_email_to_process_rpt_period_id
    ON camdecmpsaux.email_to_process USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_email_to_process_em_sub_access_id
    ON camdecmpsaux.email_to_process USING btree
    (em_sub_access_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_email_to_process_submission_type
    ON camdecmpsaux.email_to_process USING btree
    (submission_type COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_email_to_process_status_cd
    ON camdecmpsaux.email_to_process USING btree
    (status_cd COLLATE pg_catalog."default" ASC NULLS LAST);
---------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpsaux.email_to_send
	ADD CONSTRAINT pk_email_to_send PRIMARY KEY (to_send_id),
    ADD CONSTRAINT fk_email_to_send_email_template FOREIGN KEY (template_id)
        REFERENCES camdecmpsaux.email_template (template_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_email_to_send_template_id
    ON camdecmpsaux.email_to_send USING btree
    (template_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_email_to_send_status_cd
    ON camdecmpsaux.email_to_send USING btree
    (status_cd COLLATE pg_catalog."default" ASC NULLS LAST);
---------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpsaux.evaluation_queue
	ADD CONSTRAINT pk_evaluation_queue PRIMARY KEY (evaluation_id),
    ADD CONSTRAINT fk_evaluation_queue_evaluation_set FOREIGN KEY (evaluation_set_id)
        REFERENCES camdecmpsaux.evaluation_set (evaluation_set_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_evaluation_queue_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_evaluation_queue_severity_code FOREIGN KEY (severity_cd)
        REFERENCES camdecmpsmd.severity_code (severity_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_evaluation_queue_evaluation_set_id
    ON camdecmpsaux.evaluation_queue USING btree
    (evaluation_set_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_evaluation_queue_process_cd
    ON camdecmpsaux.evaluation_queue USING btree
    (process_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_evaluation_queue_test_sum_id
    ON camdecmpsaux.evaluation_queue USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_evaluation_queue_qa_cert_event_id
    ON camdecmpsaux.evaluation_queue USING btree
    (qa_cert_event_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_evaluation_queue_test_extension_exemption_id
    ON camdecmpsaux.evaluation_queue USING btree
    (test_extension_exemption_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_evaluation_queue_rpt_period_id
    ON camdecmpsaux.evaluation_queue USING btree
    (rpt_period_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_evaluation_queue_severity_cd
    ON camdecmpsaux.evaluation_queue USING btree
    (severity_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_evaluation_queue_status_cd
    ON camdecmpsaux.evaluation_queue USING btree
    (status_cd COLLATE pg_catalog."default" ASC NULLS LAST);
---------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpsaux.submission_queue
    ADD CONSTRAINT pk_submission_queue PRIMARY KEY (submission_id),
    ADD CONSTRAINT fk_submission_queue_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_submission_queue_severity_code FOREIGN KEY (severity_cd)
        REFERENCES camdecmpsmd.severity_code (severity_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_submission_queue_submission_set FOREIGN KEY (submission_set_id)
        REFERENCES camdecmpsaux.submission_set (submission_set_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_submission_queue_submission_set_id
    ON camdecmps.submission_queue USING btree
    (submission_set_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_submission_queue_process_cd
    ON camdecmps.submission_queue USING btree
    (process_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_submission_queue_test_sum_id
    ON camdecmps.submission_queue USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_submission_queue_qa_cert_event_id
    ON camdecmps.submission_queue USING btree
    (qa_cert_event_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_submission_queue_test_extension_exemption_id
    ON camdecmps.submission_queue USING btree
    (test_extension_exemption_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_submission_queue_rpt_period_id
    ON camdecmps.submission_queue USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_submission_queue_mats_bulk_file_id
    ON camdecmps.submission_queue USING btree
    (mats_bulk_file_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_submission_queue_severity_cd
    ON camdecmps.submission_queue USING btree
    (severity_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_submission_queue_status_cd
    ON camdecmps.submission_queue USING btree
    (status_cd COLLATE pg_catalog."default" ASC NULLS LAST);
---------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpsaux.apportionment_data
	ADD CONSTRAINT pk_apportionment_data PRIMARY KEY (apport_data_id),
    ADD CONSTRAINT fk_apportionment_data_apportionment_range FOREIGN KEY (apport_range_id)
        REFERENCES camdecmpsaux.apportionment_range (apport_range_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_apportionment_data_apport_range_id
    ON camdecmpsaux.apportionment_data USING btree
    (apport_range_id ASC NULLS LAST);
---------------------------------------------------------------------------------------------------------------------------------
