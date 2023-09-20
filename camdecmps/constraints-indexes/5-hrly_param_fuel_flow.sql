SELECT '5-hrly_param_fuel_flow.sql';

ALTER TABLE IF EXISTS camdecmps.hrly_param_fuel_flow
    ADD CONSTRAINT pk_hrly_param_fuel_flow PRIMARY KEY (hrly_param_ff_id),
    ADD CONSTRAINT fk_hrly_param_fuel_flow_hrly_fuel_flow FOREIGN KEY (hrly_fuel_flow_id)
        REFERENCES camdecmps.hrly_fuel_flow (hrly_fuel_flow_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_hrly_param_fuel_flow_monitor_formula FOREIGN KEY (mon_form_id)
        REFERENCES camdecmps.monitor_formula (mon_form_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_hrly_param_fuel_flow_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_hrly_param_fuel_flow_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE
        ON DELETE CASCADE,
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
