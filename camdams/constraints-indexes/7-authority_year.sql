CREATE INDEX IF NOT EXISTS idx_auth_year_allow_vint 
  ON camdams.authority_year (prg_vintage_id);
CREATE INDEX IF NOT EXISTS idx_auth_year_auth 
  ON camdams.authority_year (authority_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_authority_year 
  ON camdams.authority_year (authority_year_id);

ALTER TABLE camdams.authority_year
        ADD CONSTRAINT fk_auth_year_allow_vint FOREIGN KEY (prg_vintage_id) 
            REFERENCES camdams.program_vintage (prg_vintage_id);
ALTER TABLE camdams.authority_year
        ADD CONSTRAINT fk_auth_year_auth FOREIGN KEY (authority_id) 
            REFERENCES camdams.authority (authority_id);