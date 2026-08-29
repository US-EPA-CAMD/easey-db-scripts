CREATE UNIQUE INDEX IF NOT EXISTS pk_locked_units_failed 
  ON camdeasey.locked_units_failed (locked_units_fail_id);

ALTER TABLE camdeasey.locked_units_failed
        ADD CONSTRAINT fk_locked_units_failed_unit FOREIGN KEY (unit_id) 
            REFERENCES camd.unit (unit_id);