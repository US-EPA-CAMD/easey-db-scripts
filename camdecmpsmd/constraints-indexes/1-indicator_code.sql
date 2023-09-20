ALTER TABLE IF EXISTS camdecmpsmd.indicator_code
    ADD CONSTRAINT pk_indicator_code PRIMARY KEY (indicator_cd),
    ADD CONSTRAINT uq_indicator_code_description UNIQUE (indicator_cd_description);
