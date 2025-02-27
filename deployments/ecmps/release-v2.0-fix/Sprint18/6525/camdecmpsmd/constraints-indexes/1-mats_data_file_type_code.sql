ALTER TABLE IF EXISTS camdecmpsmd.mats_data_file_type_code
    ADD CONSTRAINT pk_mats_data_file_type_code PRIMARY KEY (mats_data_file_type_cd),
    ADD CONSTRAINT uq_mats_data_file_type_code UNIQUE (mats_data_file_type_description);

