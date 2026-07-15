CREATE INDEX IF NOT EXISTS idx_account_program_ws_status 
  ON camdws.account_program_ws (account_status_cd);
CREATE INDEX IF NOT EXISTS idx_account_program_ws_ws 
  ON camdws.account_program_ws (workspace_session_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_account_program_ws 
  ON camdws.account_program_ws (account_program_ws_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_account_program_ws_account 
  ON camdws.account_program_ws (workspace_session_id,account_prg_id);

ALTER TABLE camdws.account_program_ws
        ADD CONSTRAINT fk_account_program_ws_status FOREIGN KEY (account_status_cd) 
            REFERENCES camdmd.account_status_code (account_status_cd);
ALTER TABLE camdws.account_program_ws
        ADD CONSTRAINT fk_account_program_ws_ws FOREIGN KEY (workspace_session_id) 
            REFERENCES camdws.workspace_session (workspace_session_id)
             ON DELETE CASCADE;