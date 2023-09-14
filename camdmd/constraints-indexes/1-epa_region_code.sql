ALTER TABLE IF EXISTS camdmd.epa_region_code
    ADD CONSTRAINT pk_epa_region_code PRIMARY KEY (epa_region_cd),
    ADD CONSTRAINT uq_epa_region_code_description UNIQUE (epa_region_description);
