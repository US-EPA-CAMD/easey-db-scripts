ALTER TABLE IF EXISTS camdecmpsmd.probe_type_code
    ADD CONSTRAINT pk_probe_type_code PRIMARY KEY (probe_type_cd),
    ADD CONSTRAINT uq_probe_type_code_description UNIQUE (probe_type_cd_description);
