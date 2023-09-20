ALTER TABLE IF EXISTS camdecmpsmd.configuration_type_code
    ADD CONSTRAINT pk_configuration_type_code PRIMARY KEY (config_type_cd),
    ADD CONSTRAINT uq_configuration_type_code_description UNIQUE (config_type_cd_description);
