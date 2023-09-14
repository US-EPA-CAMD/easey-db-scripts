ALTER TABLE IF EXISTS camdecmpsmd.operating_level_code
    ADD CONSTRAINT pk_operating_level_code PRIMARY KEY (op_level_cd),
    ADD CONSTRAINT uq_operating_level_code_description UNIQUE (op_level_cd_description);
