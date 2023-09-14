ALTER TABLE IF EXISTS camdecmpsmd.sod_mass_code
    ADD CONSTRAINT pk_sod_mass_code PRIMARY KEY (sod_mass_cd),
    ADD CONSTRAINT uq_sod_mass_code_description UNIQUE (sod_mass_cd_description);
