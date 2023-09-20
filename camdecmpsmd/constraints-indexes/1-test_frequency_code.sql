ALTER TABLE IF EXISTS camdecmpsmd.test_frequency_code
    ADD CONSTRAINT pk_test_frequency_code PRIMARY KEY (test_frequency_cd),
    ADD CONSTRAINT uq_test_frequency_code_description UNIQUE (test_frequency_cd_description);
