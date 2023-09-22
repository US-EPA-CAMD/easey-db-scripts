ALTER TABLE IF EXISTS camd.unit_program
    ADD CONSTRAINT pk_unit_program PRIMARY KEY (up_id),
    ADD CONSTRAINT uq_unit_program UNIQUE (unit_id, prg_id),
    ADD CONSTRAINT fk_unit_program_applicability_status_code FOREIGN KEY (app_status_cd)
        REFERENCES camdmd.applicability_status_code (app_status_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_unit_program_program_class FOREIGN KEY (prg_cd, class_cd)
        REFERENCES camdmd.program_class (prg_cd, class_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_unit_program_program FOREIGN KEY (prg_id)
        REFERENCES camd.program (prg_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_unit_program_nonstandard_code FOREIGN KEY (nonstandard_cd)
        REFERENCES camdmd.nonstandard_code (nonstandard_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_unit_program_unit FOREIGN KEY (unit_id)
        REFERENCES camd.unit (unit_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_unit_program_app_status_cd
    ON camd.unit_program USING btree
    (app_status_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_unit_program_prg_id
    ON camd.unit_program USING btree
    (prg_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_unit_program_nonstandard_cd
    ON camd.unit_program USING btree
    (nonstandard_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_unit_program_unit_id
    ON camd.unit_program USING btree
    (unit_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_unit_program_unit_id_class_cd
    ON camd.unit_program USING btree
    (unit_id ASC NULLS LAST, class_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_unit_program_unit_id_prg_cd
    ON camd.unit_program USING btree
    (unit_id ASC NULLS LAST, prg_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_unit_program_prg_cd_class_cd
    ON camd.unit_program USING btree
    (prg_cd COLLATE pg_catalog."default" ASC NULLS LAST, class_cd COLLATE pg_catalog."default" ASC NULLS LAST);