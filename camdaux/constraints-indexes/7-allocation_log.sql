ALTER TABLE camdaux.allocation_log
        ADD CONSTRAINT fk_alloc_log_auth_year FOREIGN KEY (authority_year_id) 
            REFERENCES camdams.authority_year (authority_year_id);

CREATE UNIQUE INDEX IF NOT EXISTS allocation_log_pk 
  ON camdaux.allocation_log (allocation_log_id);
CREATE INDEX IF NOT EXISTS idx_alloc_log_auth_year 
  ON camdaux.allocation_log (authority_year_id);