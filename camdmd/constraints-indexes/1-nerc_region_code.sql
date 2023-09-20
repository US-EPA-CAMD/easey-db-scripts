ALTER TABLE IF EXISTS camdmd.nerc_region_code
    ADD CONSTRAINT pk_nerc_region_code PRIMARY KEY (nerc_region_cd),
    ADD CONSTRAINT uq_nerc_region_code_description UNIQUE (nerc_region_description);
