ALTER TABLE IF EXISTS camdecmpsmd.system_parameter_name
    ADD CONSTRAINT pk_system_parameter_name PRIMARY KEY (sys_param_name),
    ADD CONSTRAINT uq_system_parameter_name_description UNIQUE (sys_param_description);
