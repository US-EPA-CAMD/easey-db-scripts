ALTER TABLE IF EXISTS camdecmpsmd.exemption_type_code
    ADD CONSTRAINT pk_exemption_type_code PRIMARY KEY (exempt_type_cd),
    ADD CONSTRAINT uq_exemption_type_code_description UNIQUE (exempt_type_cd_description);
