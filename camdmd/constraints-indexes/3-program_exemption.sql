ALTER TABLE IF EXISTS camdmd.program_exemption
    ADD CONSTRAINT pk_program_exemption PRIMARY KEY (prg_cd, exemption_type_cd),
    ADD CONSTRAINT fk_program_exemption_program_code FOREIGN KEY (prg_cd)
        REFERENCES camdmd.program_code (prg_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_program_exemption_exemption_type_code FOREIGN KEY (exemption_type_cd)
        REFERENCES camdmd.exemption_type_code (exemption_type_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_program_exemption_prg_cd
    ON camdmd.program_exemption USING btree
    (prg_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_program_exemption_exemption_type_cd
    ON camdmd.program_exemption USING btree
    (exemption_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);
