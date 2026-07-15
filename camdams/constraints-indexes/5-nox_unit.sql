CREATE UNIQUE INDEX IF NOT EXISTS pk_nox_unit 
  ON camdams.nox_unit (unit_id);

ALTER TABLE camdams.nox_unit
        ADD CONSTRAINT fk_nox_unit_unit FOREIGN KEY (unit_id) 
            REFERENCES camd.unit (unit_id);