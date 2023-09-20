ALTER TABLE IF EXISTS camdecmpsmd.analyzer_range_code
    ADD CONSTRAINT pk_analyzer_range_code PRIMARY KEY (analyzer_range_cd),
    ADD CONSTRAINT uq_analyzer_range_code_description UNIQUE (analyzer_range_cd_description);
