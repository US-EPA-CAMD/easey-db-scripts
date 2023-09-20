ALTER TABLE IF EXISTS camdecmpsmd.test_type_group_code
    ADD CONSTRAINT pk_test_type_group_code PRIMARY KEY (test_type_group_cd),
    ADD CONSTRAINT uq_test_type_group_code_description UNIQUE (test_type_group_cd_description);
