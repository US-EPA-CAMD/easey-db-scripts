ALTER TABLE IF EXISTS camd.unit_generator
    ADD CONSTRAINT pk_unit_generator PRIMARY KEY (unit_gen_id),
    ADD CONSTRAINT uq_unit_generator UNIQUE (unit_id, gen_id, begin_date),
    ADD CONSTRAINT fk_unit_generator_generator FOREIGN KEY (gen_id)
        REFERENCES camd.generator (gen_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_unit_generator_unit FOREIGN KEY (unit_id)
        REFERENCES camd.unit (unit_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_unit_generator_gen_id
    ON camd.unit_generator USING btree
    (gen_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_unit_generator_unit_id
    ON camd.unit_generator USING btree
    (unit_id ASC NULLS LAST);