ALTER TABLE IF EXISTS camdmd.unit_type_group_code
    ADD CONSTRAINT pk_unit_type_group_code PRIMARY KEY (unit_type_group_cd),
    ADD CONSTRAINT uq_unit_type_group_code_description UNIQUE (unit_type_group_description);
