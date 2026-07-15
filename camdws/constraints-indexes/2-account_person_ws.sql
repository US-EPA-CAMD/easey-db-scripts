CREATE INDEX IF NOT EXISTS idx_account_person_ws_ws 
  ON camdws.account_person_ws (workspace_session_id);
CREATE INDEX IF NOT EXISTS idx_acct_person_ws_responsib 
  ON camdws.account_person_ws (responsibility_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_account_person_ws 
  ON camdws.account_person_ws (account_ppl_ws_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_account_person_ws_account 
  ON camdws.account_person_ws (workspace_session_id,account_ppl_id);

ALTER TABLE camdws.account_person_ws
        ADD CONSTRAINT fk_account_person_ws_ws FOREIGN KEY (workspace_session_id) 
            REFERENCES camdws.workspace_session (workspace_session_id)
             ON DELETE CASCADE;
ALTER TABLE camdws.account_person_ws
        ADD CONSTRAINT fk_acct_person_ws_responsib FOREIGN KEY (responsibility_id) 
            REFERENCES camdmd.responsibility (responsibility_id);