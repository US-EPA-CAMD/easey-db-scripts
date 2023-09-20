ALTER TABLE IF EXISTS camdecmpsmd.method_code
    ADD CONSTRAINT pk_method_code PRIMARY KEY (method_cd),
    ADD CONSTRAINT uq_method_code_description UNIQUE (method_cd_description);
