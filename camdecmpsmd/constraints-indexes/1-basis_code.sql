ALTER TABLE IF EXISTS camdecmpsmd.basis_code
    ADD CONSTRAINT pk_basis_code PRIMARY KEY (basis_cd),
    ADD CONSTRAINT uq_basis_code_description UNIQUE (basis_cd_description);
