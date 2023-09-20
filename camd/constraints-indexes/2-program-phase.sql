ALTER TABLE IF EXISTS camd.program_phase
    ADD CONSTRAINT pk_program_phase PRIMARY KEY (program_phase_id),
    ADD CONSTRAINT fk_program_phase_program FOREIGN KEY (prg_id)
        REFERENCES camd.program (prg_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_program_phase_phase
    ON camd.program_phase USING btree
    (phase COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_program_phase_prg_id
    ON camd.program_phase USING btree
    (prg_id ASC NULLS LAST);