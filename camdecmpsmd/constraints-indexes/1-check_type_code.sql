ALTER TABLE IF EXISTS camdecmpsmd.check_type_code
    ADD CONSTRAINT pk_check_type_code PRIMARY KEY (check_type_cd),
    ADD CONSTRAINT uq_check_type_code_description UNIQUE (check_type_cd_description);
