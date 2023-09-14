ALTER TABLE IF EXISTS camdecmpsmd.extension_exemption_code
    ADD CONSTRAINT pk_extension_exemption_code PRIMARY KEY (extens_exempt_cd),
    ADD CONSTRAINT uq_extension_exemption_code_description UNIQUE (extens_exemp_cd_description);
