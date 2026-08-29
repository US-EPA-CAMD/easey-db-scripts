CREATE INDEX IF NOT EXISTS idx_plant_ws_county 
  ON camdws.plant_ws (county_cd);
CREATE INDEX IF NOT EXISTS idx_plant_ws_epa_region 
  ON camdws.plant_ws (epa_region);
CREATE INDEX IF NOT EXISTS idx_plant_ws_nerc 
  ON camdws.plant_ws (nerc_region);
CREATE INDEX IF NOT EXISTS idx_plant_ws_sic 
  ON camdws.plant_ws (sic_code);
CREATE INDEX IF NOT EXISTS idx_plant_ws_state 
  ON camdws.plant_ws (state);
CREATE INDEX IF NOT EXISTS idx_plant_ws_tribal_land 
  ON camdws.plant_ws (tribal_land_cd);
CREATE INDEX IF NOT EXISTS idx_plant_ws_workspace 
  ON camdws.plant_ws (workspace_session_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_plant_ws 
  ON camdws.plant_ws (plant_ws_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_plant_ws 
  ON camdws.plant_ws (fac_id,workspace_session_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_plant_ws_name_state 
  ON camdws.plant_ws (workspace_session_id,facility_name,state);

ALTER TABLE camdws.plant_ws
        ADD CONSTRAINT fk_plant_ws_county FOREIGN KEY (county_cd) 
            REFERENCES camdmd.county_code (county_cd);
ALTER TABLE camdws.plant_ws
        ADD CONSTRAINT fk_plant_ws_epa_region FOREIGN KEY (epa_region) 
            REFERENCES camdmd.epa_region_code (epa_region_cd);
ALTER TABLE camdws.plant_ws
        ADD CONSTRAINT fk_plant_ws_nerc FOREIGN KEY (nerc_region) 
            REFERENCES camdmd.nerc_region_code (nerc_region_cd);
ALTER TABLE camdws.plant_ws
        ADD CONSTRAINT fk_plant_ws_sic FOREIGN KEY (sic_code) 
            REFERENCES camdmd.sic_code (sic_code);
ALTER TABLE camdws.plant_ws
        ADD CONSTRAINT fk_plant_ws_state FOREIGN KEY (state) 
            REFERENCES camdmd.state_code (state_cd);
ALTER TABLE camdws.plant_ws
        ADD CONSTRAINT fk_plant_ws_tribal_land FOREIGN KEY (tribal_land_cd) 
            REFERENCES camdmd.tribal_land_code (tribal_land_cd);
ALTER TABLE camdws.plant_ws
        ADD CONSTRAINT fk_plant_ws_workspace FOREIGN KEY (workspace_session_id) 
            REFERENCES camdws.workspace_session (workspace_session_id)
             ON DELETE CASCADE;