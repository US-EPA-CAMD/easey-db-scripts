ALTER TABLE IF EXISTS camdecmpsmd.response_type_code
    ADD CONSTRAINT pk_response_type_code PRIMARY KEY (response_type_cd),
    ADD CONSTRAINT uq_response_type_code_description UNIQUE (response_type_cd_description);
