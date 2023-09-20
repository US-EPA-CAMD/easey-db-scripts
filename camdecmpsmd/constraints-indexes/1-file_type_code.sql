ALTER TABLE IF EXISTS camdecmpsmd.file_type_code
    ADD CONSTRAINT pk_file_type_code PRIMARY KEY (file_type_cd),
    ADD CONSTRAINT uq_file_type_code_description UNIQUE (file_type_cd_description);
