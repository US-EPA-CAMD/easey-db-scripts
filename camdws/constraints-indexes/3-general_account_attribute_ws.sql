CREATE UNIQUE INDEX IF NOT EXISTS pk_gen_account_attrib_ws 
  ON camdws.general_account_attribute_ws (account_ws_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_gen_account_attrib_ws_acct 
  ON camdws.general_account_attribute_ws (workspace_session_id,account_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_gen_account_attrib_ws_ws 
  ON camdws.general_account_attribute_ws (workspace_session_id);

ALTER TABLE camdws.general_account_attribute_ws
        ADD CONSTRAINT fk_gen_account_attrib_ws_ws FOREIGN KEY (workspace_session_id) 
            REFERENCES camdws.workspace_session (workspace_session_id)
             ON DELETE CASCADE;
ALTER TABLE camdws.general_account_attribute_ws
        ADD CONSTRAINT fk_gen_acct_attrib_ws_acct_ws FOREIGN KEY (workspace_session_id, account_id) 
            REFERENCES camdws.account_ws (workspace_session_id, account_id)
             ON DELETE CASCADE;