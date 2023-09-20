ALTER TABLE IF EXISTS camdecmpsmd.qual_data_type_code
    ADD CONSTRAINT pk_qual_data_type_code PRIMARY KEY (qual_data_type_cd),
    ADD CONSTRAINT uq_qual_data_type_code_description UNIQUE (qual_data_type_cd_description);
