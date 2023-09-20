ALTER TABLE IF EXISTS camdecmpsmd.em_sub_type_code
    ADD CONSTRAINT pk_em_sub_type_code PRIMARY KEY (em_sub_type_cd),
    ADD CONSTRAINT uq_em_sub_type_code_description UNIQUE (em_sub_type_cd_description);
