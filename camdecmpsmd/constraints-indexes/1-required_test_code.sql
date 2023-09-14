ALTER TABLE IF EXISTS camdecmpsmd.required_test_code
    ADD CONSTRAINT pk_required_test_code PRIMARY KEY (required_test_cd),
    ADD CONSTRAINT uq_required_test_code_description UNIQUE (required_test_cd_description);
