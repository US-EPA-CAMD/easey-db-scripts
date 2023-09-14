ALTER TABLE IF EXISTS camdmd.program_code
    ADD CONSTRAINT pk_program_code PRIMARY KEY (prg_cd),
    ADD CONSTRAINT uq_program_code_description UNIQUE (prg_description),
    ADD CONSTRAINT fk_program_code_program_group_code FOREIGN KEY (prg_group_cd)
        REFERENCES camdmd.program_group_code (prg_group_cd) MATCH SIMPLE

CREATE INDEX IF NOT EXISTS idx_program_code_prg_group_cd
    ON camdmd.program_code USING btree
    (prg_group_cd ASC NULLS LAST);
