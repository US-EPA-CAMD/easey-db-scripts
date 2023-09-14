ALTER TABLE IF EXISTS camdecmpsmd.max_rate_source_code
    ADD CONSTRAINT pk_max_rate_source_code PRIMARY KEY (max_rate_source_cd),
    ADD CONSTRAINT uq_max_rate_source_code_description UNIQUE (max_rate_source_cd_description);
