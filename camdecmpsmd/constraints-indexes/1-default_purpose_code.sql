ALTER TABLE IF EXISTS camdecmpsmd.default_purpose_code
    ADD CONSTRAINT pk_default_purpose_code PRIMARY KEY (default_purpose_cd),
    ADD CONSTRAINT uq_default_purpose_code_description UNIQUE (def_purpose_cd_description);
