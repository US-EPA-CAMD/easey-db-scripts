ALTER TABLE IF EXISTS camdecmpsmd.modc_code
    ADD CONSTRAINT pk_modc_code PRIMARY KEY (modc_cd),
    ADD CONSTRAINT uq_modc_code_description UNIQUE (modc_description);
