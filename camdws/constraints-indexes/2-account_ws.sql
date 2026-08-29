CREATE INDEX IF NOT EXISTS idx_account_ws_state 
  ON camdws.account_ws (state_cd);
CREATE INDEX IF NOT EXISTS idx_account_ws_tribal_land 
  ON camdws.account_ws (tribal_land_cd);
CREATE INDEX IF NOT EXISTS idx_account_ws_type 
  ON camdws.account_ws (account_type_cd);
CREATE INDEX IF NOT EXISTS idx_account_ws_ws 
  ON camdws.account_ws (workspace_session_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_account_ws 
  ON camdws.account_ws (account_ws_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_account_ws_account 
  ON camdws.account_ws (workspace_session_id,account_id);

ALTER TABLE camdws.account_ws
        ADD CONSTRAINT fk_account_ws_state FOREIGN KEY (state_cd) 
            REFERENCES camdmd.state_code (state_cd);
ALTER TABLE camdws.account_ws
        ADD CONSTRAINT fk_account_ws_tribal_land FOREIGN KEY (tribal_land_cd) 
            REFERENCES camdmd.tribal_land_code (tribal_land_cd);
ALTER TABLE camdws.account_ws
        ADD CONSTRAINT fk_account_ws_type FOREIGN KEY (account_type_cd) 
            REFERENCES camdmd.account_type_code (account_type_cd);
ALTER TABLE camdws.account_ws
        ADD CONSTRAINT fk_account_ws_ws FOREIGN KEY (workspace_session_id) 
            REFERENCES camdws.workspace_session (workspace_session_id)
             ON DELETE CASCADE;