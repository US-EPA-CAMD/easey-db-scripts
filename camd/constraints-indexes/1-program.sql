ALTER TABLE IF EXISTS camd.program
    ADD CONSTRAINT pk_program PRIMARY KEY (prg_id),
    ADD CONSTRAINT uq_program_code_by_state UNIQUE (prg_cd, state_cd),
    ADD CONSTRAINT fk_program_program_code FOREIGN KEY (prg_cd)
        REFERENCES camdmd.program_code (prg_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_program_state_code FOREIGN KEY (state_cd)
        REFERENCES camdmd.state_code (state_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_program_tribal_land_code FOREIGN KEY (tribal_land_cd)
        REFERENCES camdmd.tribal_land_code (tribal_land_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_program_prg_cd
    ON camd.program USING btree
    (prg_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_program_state_cd
    ON camd.program USING btree
    (state_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_program_tribal_land_cd
    ON camd.program USING btree
    (tribal_land_cd COLLATE pg_catalog."default" ASC NULLS LAST);