ALTER TABLE IF EXISTS camdecmpsmd.test_claim_code
    ADD CONSTRAINT pk_test_claim_code PRIMARY KEY (test_claim_cd),
    ADD CONSTRAINT uq_test_claim_code_description UNIQUE (test_claim_cd_description);
