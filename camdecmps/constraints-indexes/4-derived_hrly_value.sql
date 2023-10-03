ALTER TABLE IF EXISTS camdecmps.derived_hrly_value
    ADD CONSTRAINT pk_derived_hrly_value PRIMARY KEY (derv_id, rpt_period_id),
    ADD CONSTRAINT fk_derived_hrly_value_fuel_code FOREIGN KEY (fuel_cd)
        REFERENCES camdecmpsmd.fuel_code (fuel_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_derived_hrly_value_hrly_op_data FOREIGN KEY (hour_id, rpt_period_id)
        REFERENCES camdecmps.hrly_op_data (hour_id, rpt_period_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_derived_hrly_value_modc_code FOREIGN KEY (modc_cd)
        REFERENCES camdecmpsmd.modc_code (modc_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_derived_hrly_value_monitor_formula FOREIGN KEY (mon_form_id)
        REFERENCES camdecmps.monitor_formula (mon_form_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_derived_hrly_value_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_derived_hrly_value_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE
        ON DELETE CASCADE,
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
