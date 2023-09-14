ALTER TABLE IF EXISTS camdecmpsmd.equation_code
    ADD CONSTRAINT pk_equation_code PRIMARY KEY (equation_cd),
    ADD CONSTRAINT uq_equation_code_description UNIQUE (equation_cd_description);
