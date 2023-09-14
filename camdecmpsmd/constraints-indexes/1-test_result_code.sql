ALTER TABLE IF EXISTS camdecmpsmd.test_result_code
    ADD CONSTRAINT pk_test_result_code PRIMARY KEY (test_result_cd),
    ADD CONSTRAINT uq_test_result_code_description UNIQUE (test_result_cd_description);
