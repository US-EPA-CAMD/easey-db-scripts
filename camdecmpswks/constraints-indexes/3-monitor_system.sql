ALTER TABLE IF EXISTS camdecmpswks.monitor_system
    ADD CONSTRAINT pk_monitor_system PRIMARY KEY (mon_sys_id),
    ADD CONSTRAINT fk_monitor_system_fuel_code FOREIGN KEY (fuel_cd)
        REFERENCES camdecmpsmd.fuel_code (fuel_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_system_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_system_system_designation_code FOREIGN KEY (sys_designation_cd)
        REFERENCES camdecmpsmd.system_designation_code (sys_designation_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_system_system_type_code FOREIGN KEY (sys_type_cd)
        REFERENCES camdecmpsmd.system_type_code (sys_type_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_monitor_system_fuel_cd
    ON camdecmpswks.monitor_system USING btree
    (fuel_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_system_mon_loc_id
    ON camdecmpswks.monitor_system USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_system_system_identifier
    ON camdecmpswks.monitor_system USING btree
    (system_identifier COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_system_sys_designation_cd
    ON camdecmpswks.monitor_system USING btree
    (sys_designation_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_system_sys_type_cd
    ON camdecmpswks.monitor_system USING btree
    (sys_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

/* WHY ???
CREATE UNIQUE INDEX IF NOT EXISTS udx_monitor_system_mon_loc_id_mon_sys_id_system_identifier
    ON camdecmpswks.monitor_system USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST, mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST, system_identifier COLLATE pg_catalog."default" ASC NULLS LAST);
*/