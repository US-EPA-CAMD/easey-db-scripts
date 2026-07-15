CREATE INDEX IF NOT EXISTS idx_unit_alias_ws_ws 
  ON camdws.unit_alias_ws (workspace_session_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_unit_alias_ws 
  ON camdws.unit_alias_ws (unit_alias_ws_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_unit_alias_ws_key 
  ON camdws.unit_alias_ws (unit_alias_id,workspace_session_id);

ALTER TABLE camdws.unit_alias_ws
        ADD CONSTRAINT fk_unit_alias_ws_ws FOREIGN KEY (workspace_session_id) 
            REFERENCES camdws.workspace_session (workspace_session_id)
             ON DELETE CASCADE;