ALTER TABLE IF EXISTS camdecmpsmd.check_parameter_usage_code
    ADD CONSTRAINT pk_check_parameter_usage_code PRIMARY KEY (check_param_usage_cd),
    ADD CONSTRAINT uq_check_parameter_usage_code_name UNIQUE (check_param_usage_cd_name);

