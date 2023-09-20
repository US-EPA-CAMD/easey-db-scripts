ALTER TABLE IF EXISTS camdmd.naics_code
    ADD CONSTRAINT pk_naics_code PRIMARY KEY (naics_cd),
    ADD CONSTRAINT uq_naics_code_description UNIQUE (naics_description);
