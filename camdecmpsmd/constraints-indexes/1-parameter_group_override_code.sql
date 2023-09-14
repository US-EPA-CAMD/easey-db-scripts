ALTER TABLE IF EXISTS camdecmpsmd.parameter_group_override_code
    ADD CONSTRAINT pk_parameter_group_override_code PRIMARY KEY (parameter_group_override_cd),
    ADD CONSTRAINT uq_parameter_group_override_code_description UNIQUE (parameter_group_override_description);
