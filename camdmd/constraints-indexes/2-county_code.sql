ALTER TABLE camdmd.county_code
        ADD CONSTRAINT fk_county_code_state FOREIGN KEY (state_cd) 
            REFERENCES camdmd.state_code (state_cd);

CREATE INDEX IF NOT EXISTS idx_county_code_state 
  ON camdmd.county_code (state_cd);
CREATE UNIQUE INDEX IF NOT EXISTS pk_county_code 
  ON camdmd.county_code (county_cd);