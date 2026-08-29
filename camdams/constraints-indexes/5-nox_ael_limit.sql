CREATE UNIQUE INDEX IF NOT EXISTS pk_nox_ael_limit 
  ON camdams.nox_ael_limit (unit_id,begin_date);

ALTER TABLE camdams.nox_ael_limit
        ADD CONSTRAINT fk_nox_ael_limit_unt_id FOREIGN KEY (unit_id) 
            REFERENCES camd.unit (unit_id);