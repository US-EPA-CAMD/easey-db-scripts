ALTER TABLE IF EXISTS camdecmpsmd.analytical_principle_code
    ADD CONSTRAINT pk_analytical_principle_code PRIMARY KEY (analytical_principle_cd),
    ADD CONSTRAINT uq_analytical_principle_code_description UNIQUE (analytical_principle_cd_description);
