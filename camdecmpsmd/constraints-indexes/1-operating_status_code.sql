ALTER TABLE IF EXISTS camdecmpsmd.operating_status_code
    ADD CONSTRAINT pk_operating_status_code PRIMARY KEY (op_status_cd),
    ADD CONSTRAINT uq_operating_status_code_description UNIQUE (op_status_cd_description);
