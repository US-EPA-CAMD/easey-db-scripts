ALTER TABLE IF EXISTS camd.unit_boiler_type
    ADD CONSTRAINT pk_unit_boiler_type PRIMARY KEY (unit_boiler_type_id),
    ADD CONSTRAINT uq_unit_boiler_type UNIQUE (unit_id, unit_type_cd, begin_date),
    ADD CONSTRAINT fk_unit_boiler_type_unit FOREIGN KEY (unit_id)
        REFERENCES camd.unit (unit_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_unit_boiler_type_unit_type_code FOREIGN KEY (unit_type_cd)
        REFERENCES camdmd.unit_type_code (unit_type_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_unit_boiler_type_unit_id
    ON camd.unit_boiler_type USING btree
    (unit_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_unit_boiler_type_unit_type_cd
    ON camd.unit_boiler_type USING btree
    (unit_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);
