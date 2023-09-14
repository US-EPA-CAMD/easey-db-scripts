ALTER TABLE IF EXISTS camdecmpsmd.default_source_code
    ADD CONSTRAINT pk_default_source_code PRIMARY KEY (default_source_cd),
    ADD CONSTRAINT uq_default_source_code_description UNIQUE (default_source_cd_description);
