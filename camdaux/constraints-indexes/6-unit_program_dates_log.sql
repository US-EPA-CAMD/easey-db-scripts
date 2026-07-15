ALTER TABLE camdaux.unit_program_dates_log
        ADD CONSTRAINT fk_up_dates_log_up_id FOREIGN KEY (up_id) 
            REFERENCES camd.unit_program (up_id);

CREATE UNIQUE INDEX IF NOT EXISTS pk_up_dates_log 
  ON camdaux.unit_program_dates_log (up_dates_log_id);