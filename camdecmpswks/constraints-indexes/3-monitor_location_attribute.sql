ALTER TABLE IF EXISTS camdecmpswks.monitor_location_attribute
    ADD CONSTRAINT pk_monitor_location_attribute PRIMARY KEY (mon_loc_attrib_id),
    ADD CONSTRAINT fk_monitor_location_attribute_material_code FOREIGN KEY (material_cd)
        REFERENCES camdecmpsmd.material_code (material_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_location_attribute_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_location_attribute_shape_code FOREIGN KEY (shape_cd)
        REFERENCES camdecmpsmd.shape_code (shape_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_monitor_location_material_cd
    ON camdecmpswks.monitor_location_attribute USING btree
    (material_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_location_mon_loc_id
    ON camdecmpswks.monitor_location_attribute USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_location_shape_cd
    ON camdecmpswks.monitor_location_attribute USING btree
    (shape_cd COLLATE pg_catalog."default" ASC NULLS LAST);
