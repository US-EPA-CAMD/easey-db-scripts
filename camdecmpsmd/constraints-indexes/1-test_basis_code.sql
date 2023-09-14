ALTER TABLE IF EXISTS camdecmpsmd.test_basis_code
    ADD CONSTRAINT pk_test_basis_code PRIMARY KEY (test_basis_cd),
    ADD CONSTRAINT uq_test_basis_code_description UNIQUE (test_basis_description);
