ALTER TABLE IF EXISTS camdmd.program_class
    ADD CONSTRAINT pk_program_class PRIMARY KEY (prg_cd, class_cd),
    ADD CONSTRAINT fk_program_class_class_code FOREIGN KEY (class_cd)
        REFERENCES camdmd.class_code (class_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_program_class_program_code FOREIGN KEY (prg_cd)
        REFERENCES camdmd.program_code (prg_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_program_class_prg_cd
    ON camdmd.program_class USING btree
    (prg_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_program_class_class_cd
    ON camdmd.program_class USING btree
    (class_cd COLLATE pg_catalog."default" ASC NULLS LAST);
