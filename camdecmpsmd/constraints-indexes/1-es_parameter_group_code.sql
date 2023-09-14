ALTER TABLE IF EXISTS camdecmpsmd.es_parameter_group_code
    ADD CONSTRAINT pk_es_parameter_group_code PRIMARY KEY (es_parameter_group_cd),
    ADD CONSTRAINT uq_es_parameter_group_code_description UNIQUE (es_parameter_group_description);
