ALTER TABLE IF EXISTS camdecmpsmd.mats_method_parameter_code
    ADD CONSTRAINT pk_mats_method_parameter_code PRIMARY KEY (mats_method_parameter_cd),
    ADD CONSTRAINT uq_mats_method_parameter_code_description UNIQUE (mats_method_param_description);
