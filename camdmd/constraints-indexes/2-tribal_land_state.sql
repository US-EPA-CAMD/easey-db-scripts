ALTER TABLE camdmd.tribal_land_state
        ADD CONSTRAINT fk_tribal_land_state_state FOREIGN KEY (state_cd) 
            REFERENCES camdmd.state_code (state_cd);
ALTER TABLE camdmd.tribal_land_state
        ADD CONSTRAINT fk_tribal_land_state_tribal FOREIGN KEY (tribal_land_cd) 
            REFERENCES camdmd.tribal_land_code (tribal_land_cd);

CREATE INDEX IF NOT EXISTS idx_tribal_land_state_state 
  ON camdmd.tribal_land_state (state_cd);
CREATE INDEX IF NOT EXISTS idx_tribal_land_state_tribal 
  ON camdmd.tribal_land_state (tribal_land_cd);
CREATE UNIQUE INDEX IF NOT EXISTS pk_tribal_land_state 
  ON camdmd.tribal_land_state (tribal_land_cd,state_cd);