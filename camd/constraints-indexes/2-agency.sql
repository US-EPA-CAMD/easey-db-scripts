ALTER TABLE camd.agency
        ADD CONSTRAINT fk_agency_agency_type FOREIGN KEY (agency_type_cd) 
            REFERENCES camdmd.agency_type_code (agency_type_cd);
ALTER TABLE camd.agency
        ADD CONSTRAINT fk_agency_state FOREIGN KEY (state_cd) 
            REFERENCES camdmd.state_code (state_cd);
ALTER TABLE camd.agency
        ADD CONSTRAINT fk_agency_tribal_land FOREIGN KEY (tribal_land_cd) 
            REFERENCES camdmd.tribal_land_code (tribal_land_cd);

CREATE INDEX IF NOT EXISTS idx_agency_agency_type 
  ON camd.agency (agency_type_cd);
CREATE INDEX IF NOT EXISTS idx_agency_state 
  ON camd.agency (state_cd);
CREATE INDEX IF NOT EXISTS idx_agency_tribal_land 
  ON camd.agency (tribal_land_cd);
CREATE UNIQUE INDEX IF NOT EXISTS pk_agency 
  ON camd.agency (agency_id);