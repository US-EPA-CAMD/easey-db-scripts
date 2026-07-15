CREATE INDEX IF NOT EXISTS idx_workspace_load_workspace 
  ON camdws.workspace_load (workspace_session_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_workspace_load 
  ON camdws.workspace_load (ws_load_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_workspace_load 
  ON camdws.workspace_load (workspace_session_id,id,key_type);

ALTER TABLE camdws.workspace_load
        ADD CONSTRAINT fk_workspace_load_workspace FOREIGN KEY (workspace_session_id) 
            REFERENCES camdws.workspace_session (workspace_session_id)
             ON DELETE CASCADE;