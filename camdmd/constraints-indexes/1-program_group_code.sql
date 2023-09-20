ALTER TABLE IF EXISTS camdmd.program_group_code
    ADD CONSTRAINT pk_program_group_code PRIMARY KEY (prg_group_cd),
    ADD CONSTRAINT uq_program_group_code_description UNIQUE (prg_group_description);
