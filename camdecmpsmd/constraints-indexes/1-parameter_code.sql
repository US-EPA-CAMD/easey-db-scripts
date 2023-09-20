ALTER TABLE IF EXISTS camdecmpsmd.parameter_code
    ADD CONSTRAINT pk_parameter_code PRIMARY KEY (parameter_cd),
    ADD CONSTRAINT uq_parameter_code_description UNIQUE (parameter_cd_description);
