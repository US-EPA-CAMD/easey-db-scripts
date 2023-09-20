ALTER TABLE IF EXISTS camdecmpsmd.injection_protocol_code
    ADD CONSTRAINT pk_injection_protocol_code PRIMARY KEY (injection_protocol_cd),
    ADD CONSTRAINT uq_injection_protocol_code_description UNIQUE (injection_protocol_description);
