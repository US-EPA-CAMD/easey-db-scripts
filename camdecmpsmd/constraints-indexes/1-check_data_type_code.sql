ALTER TABLE IF EXISTS camdecmpsmd.check_data_type_code
    ADD CONSTRAINT pk_check_data_type_code PRIMARY KEY (check_data_type_cd),
    ADD CONSTRAINT uq_check_data_type_code_name UNIQUE (check_data_type_cd_name);
