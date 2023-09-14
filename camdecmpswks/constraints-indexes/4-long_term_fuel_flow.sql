ALTER TABLE IF EXISTS camdecmpswks.long_term_fuel_flow
    ADD CONSTRAINT pk_long_term_fuel_flow PRIMARY KEY (ltff_id),
    ADD CONSTRAINT fk_long_term_fuel_flow_fuel_flow_period_code FOREIGN KEY (fuel_flow_period_cd)
        REFERENCES camdecmpsmd.fuel_flow_period_code (fuel_flow_period_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_long_term_fuel_flow_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_long_term_fuel_flow_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmpswks.monitor_system (mon_sys_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_long_term_fuel_flow_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_long_term_fuel_flow_units_of_measure_code_gcv FOREIGN KEY (gcv_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_long_term_fuel_flow_units_of_measure_code_ltff FOREIGN KEY (ltff_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_long_term_fuel_fuel_flow_fuel_flow_period_cd
    ON camdecmpswks.long_term_fuel_flow USING btree
    (fuel_flow_period_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_long_term_fuel_fuel_flow_gcv_uom_cd
    ON camdecmpswks.long_term_fuel_flow USING btree
    (gcv_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_long_term_fuel_fuel_flow_ltff_uom_cd
    ON camdecmpswks.long_term_fuel_flow USING btree
    (ltff_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_long_term_fuel_fuel_flow_mon_loc_id
    ON camdecmpswks.long_term_fuel_flow USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_long_term_fuel_fuel_flow_mon_sys_id
    ON camdecmpswks.long_term_fuel_flow USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_long_term_fuel_flow_rpt_period_id
    ON camdecmpswks.long_term_fuel_flow USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_long_term_fuel_flow_rpt_period_id_mon_loc_id
    ON camdecmpswks.long_term_fuel_flow USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
