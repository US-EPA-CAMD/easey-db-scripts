ALTER TABLE IF EXISTS camdecmpsmd.check_catalog_plugin
    ADD CONSTRAINT pk_check_catalog_plugin PRIMARY KEY (check_catalog_plugin_id),
    ADD CONSTRAINT uq_check_catalog_plugin_check_catalog_plugin_name UNIQUE (check_catalog_id, plugin_name),
    ADD CONSTRAINT fk_check_catalog_plugin_check_catalog FOREIGN KEY (check_catalog_id)
        REFERENCES camdecmpsmd.check_catalog (check_catalog_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_check_catalog_plugin_plugin_type_code FOREIGN KEY (plugin_type_cd)
        REFERENCES camdecmpsmd.plugin_type_code (plugin_type_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_check_catalog_plugin_check_catalog_id
    ON camdecmpsmd.check_catalog_plugin USING btree
    (check_catalog_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_catalog_plugin_plugin_type_cd
    ON camdecmpsmd.check_catalog_plugin USING btree
    (plugin_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);