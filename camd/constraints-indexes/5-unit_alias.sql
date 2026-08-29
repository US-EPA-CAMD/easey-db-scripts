ALTER TABLE camd.unit_alias
        ADD CONSTRAINT fk_unit_alias_unit FOREIGN KEY (unit_id) 
            REFERENCES camd.unit (unit_id);

CREATE INDEX IF NOT EXISTS idx_unit_alias_unit 
  ON camd.unit_alias (unit_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_unit_alias 
  ON camd.unit_alias (unit_alias_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_unit_date 
  ON camd.unit_alias (unit_id,alias_date);