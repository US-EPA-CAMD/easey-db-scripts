CREATE INDEX IF NOT EXISTS idx_plant_alias_type 
  ON camdws.plant_alias_ws (alias_type);
CREATE INDEX IF NOT EXISTS idx_plant_alias_ws_ws 
  ON camdws.plant_alias_ws (workspace_session_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_plant_alias_ws 
  ON camdws.plant_alias_ws (plant_alias_ws_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_plant_alias_ws_key 
  ON camdws.plant_alias_ws (plant_alias_id,workspace_session_id);

ALTER TABLE camdws.plant_alias_ws
        ADD CONSTRAINT fk_plant_alias_ws_ws FOREIGN KEY (workspace_session_id) 
            REFERENCES camdws.workspace_session (workspace_session_id)
             ON DELETE CASCADE;