CREATE INDEX IF NOT EXISTS idx_unit_owner_ws_ws 
  ON camdws.unit_owner_ws (workspace_session_id);
CREATE INDEX IF NOT EXISTS idx_unit_ws_owner_type 
  ON camdws.unit_owner_ws (owner_type_cd);
CREATE UNIQUE INDEX IF NOT EXISTS pk_unit_owner_ws 
  ON camdws.unit_owner_ws (unit_owner_ws_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_unit_owner_ws_key 
  ON camdws.unit_owner_ws (unit_owner_id,workspace_session_id);

ALTER TABLE camdws.unit_owner_ws
        ADD CONSTRAINT fk_unit_owner_ws_owner_type FOREIGN KEY (owner_type_cd) 
            REFERENCES camdmd.owner_type_code (owner_type_cd);
ALTER TABLE camdws.unit_owner_ws
        ADD CONSTRAINT fk_unit_owner_ws_ws FOREIGN KEY (workspace_session_id) 
            REFERENCES camdws.workspace_session (workspace_session_id)
             ON DELETE CASCADE;