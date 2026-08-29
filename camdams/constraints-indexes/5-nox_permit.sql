CREATE INDEX IF NOT EXISTS idx_nox_permit_unit_id 
  ON camdams.nox_permit (unit_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_nox_permit_id 
  ON camdams.nox_permit (permit_id);

ALTER TABLE camdams.nox_permit
        ADD CONSTRAINT fk_nox_permit_unit FOREIGN KEY (unit_id) 
            REFERENCES camd.unit (unit_id);