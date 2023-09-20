ALTER TABLE IF EXISTS camdecmpsmd.test_reason_code
    ADD CONSTRAINT pk_test_reason_code PRIMARY KEY (test_reason_cd),
    ADD CONSTRAINT uq_test_reason_code_description UNIQUE (test_reason_cd_description);
