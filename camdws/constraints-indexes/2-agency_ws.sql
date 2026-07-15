CREATE INDEX IF NOT EXISTS idx_agency_agency_type 
  ON camdws.agency_ws (agency_type_cd);
CREATE INDEX IF NOT EXISTS idx_agency_state 
  ON camdws.agency_ws (state_cd);
CREATE INDEX IF NOT EXISTS idx_agency_tribal_land 
  ON camdws.agency_ws (tribal_land_cd);
CREATE INDEX IF NOT EXISTS idx_agency_ws_ws 
  ON camdws.agency_ws (workspace_session_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_agency_ws 
  ON camdws.agency_ws (agency_ws_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_agency_ws_agency 
  ON camdws.agency_ws (workspace_session_id,agency_id);

ALTER TABLE camdws.agency_ws
        ADD CONSTRAINT fk_agency_agency_type FOREIGN KEY (agency_type_cd) 
            REFERENCES camdmd.agency_type_code (agency_type_cd);
ALTER TABLE camdws.agency_ws
        ADD CONSTRAINT fk_agency_state FOREIGN KEY (state_cd) 
            REFERENCES camdmd.state_code (state_cd);
ALTER TABLE camdws.agency_ws
        ADD CONSTRAINT fk_agency_tribal_land FOREIGN KEY (tribal_land_cd) 
            REFERENCES camdmd.tribal_land_code (tribal_land_cd);
ALTER TABLE camdws.agency_ws
        ADD CONSTRAINT fk_agency_ws_ws FOREIGN KEY (workspace_session_id) 
            REFERENCES camdws.workspace_session (workspace_session_id)
             ON DELETE CASCADE;