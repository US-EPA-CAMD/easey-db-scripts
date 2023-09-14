ALTER TABLE IF EXISTS camdecmpsmd.substitute_data_code
    ADD CONSTRAINT pk_substitute_data_code PRIMARY KEY (sub_data_cd),
    ADD CONSTRAINT uq_substitute_data_code_description UNIQUE (sub_data_cd_description);
