ALTER TABLE IF EXISTS camdecmpsmd.operating_type_code
    ADD CONSTRAINT pk_operating_type_code PRIMARY KEY (op_type_cd),
    ADD CONSTRAINT uq_operating_type_code_description UNIQUE (op_type_cd_description);
