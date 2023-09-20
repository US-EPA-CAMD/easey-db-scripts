ALTER TABLE IF EXISTS camdecmps.unit_capacity
    ADD CONSTRAINT pk_unit_capacity PRIMARY KEY (unit_cap_id),
    ADD CONSTRAINT fk_unit_capacity_unit FOREIGN KEY (unit_id)
        REFERENCES camd.unit (unit_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_unit_capacity_unit
    ON camdecmps.unit_capacity USING btree
    (unit_id ASC NULLS LAST);