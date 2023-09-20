ALTER TABLE IF EXISTS camdmd.unit_type_code
    ADD CONSTRAINT pk_unit_type_code PRIMARY KEY (unit_type_cd),
    ADD CONSTRAINT uq_unit_type_code_description UNIQUE (unit_type_description),
    ADD CONSTRAINT fk_unit_type_code_unit_type_group_code FOREIGN KEY (unit_type_group_cd)
        REFERENCES camdmd.unit_type_group_code (unit_type_group_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_unit_type_code_unit_type_group_cd
    ON camdmd.unit_type_code USING btree
    (unit_type_group_cd COLLATE pg_catalog."default" ASC NULLS LAST);
