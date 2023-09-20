ALTER TABLE IF EXISTS camdecmpsmd.operating_condition_code
    ADD CONSTRAINT pk_operating_condition_code PRIMARY KEY (operating_condition_cd),
    ADD CONSTRAINT uq_operating_condition_code_description UNIQUE (op_condition_cd_description);
