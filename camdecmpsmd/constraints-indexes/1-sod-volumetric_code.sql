ALTER TABLE IF EXISTS camdecmpsmd.sod_volumetric_code
    ADD CONSTRAINT pk_sod_volumetric_code PRIMARY KEY (sod_volumetric_cd),
    ADD CONSTRAINT uq_sod_volumetric_code_description UNIQUE (sod_volumetric_cd_description);
