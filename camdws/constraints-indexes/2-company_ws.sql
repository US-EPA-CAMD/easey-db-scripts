CREATE INDEX IF NOT EXISTS idx_company_ws_workspace 
  ON camdws.company_ws (workspace_session_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_company_ws 
  ON camdws.company_ws (company_ws_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_company_ws_id 
  ON camdws.company_ws (company_id,workspace_session_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_company_ws_name 
  ON camdws.company_ws (company_name,workspace_session_id);

ALTER TABLE camdws.company_ws
        ADD CONSTRAINT fk_company_ws_workspace FOREIGN KEY (workspace_session_id) 
            REFERENCES camdws.workspace_session (workspace_session_id)
             ON DELETE CASCADE;