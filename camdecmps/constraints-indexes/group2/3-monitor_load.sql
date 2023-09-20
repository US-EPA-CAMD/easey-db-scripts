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
