ALTER TABLE IF EXISTS camdecmpsmd.check_parameter_type_code
    ADD CONSTRAINT pk_check_parameter_type_code PRIMARY KEY (chk_param_type_cd),
    ADD CONSTRAINT uq_check_parameter_type_code_description UNIQUE (chk_param_type_cd_description);
