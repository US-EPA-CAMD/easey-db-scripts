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
