ALTER TABLE IF EXISTS camdecmpsmd.plugin_type_code
    ADD CONSTRAINT pk_plugin_type_code PRIMARY KEY (plugin_type_cd),
    ADD CONSTRAINT uq_plugin_type_code_description UNIQUE (plugin_type_cd_description);
