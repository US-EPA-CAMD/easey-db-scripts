CREATE INDEX IF NOT EXISTS idx_account_owner_ws_ws 
  ON camdws.account_owner_ws (workspace_session_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_account_owner_ws 
  ON camdws.account_owner_ws (account_owner_ws_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_account_owner_ws_account 
  ON camdws.account_owner_ws (workspace_session_id,account_owner_id);

ALTER TABLE camdws.account_owner_ws
        ADD CONSTRAINT fk_account_owner_ws_ws FOREIGN KEY (workspace_session_id) 
            REFERENCES camdws.workspace_session (workspace_session_id)
             ON DELETE CASCADE;