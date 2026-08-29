ALTER TABLE camd.rep_agent_account
        ADD CONSTRAINT fk_rep_agent_account_account_id FOREIGN KEY (account_id) 
            REFERENCES camdams.account (account_id);
ALTER TABLE camd.rep_agent_account
        ADD CONSTRAINT fk_rep_agent_account_cnt_rel FOREIGN KEY (cnt_rel_id) 
            REFERENCES camd.contact_relation (cnt_rel_id);

CREATE INDEX IF NOT EXISTS idx_rep_agent_account_active 
  ON camd.rep_agent_account (cnt_rel_id,account_id,begin_date,end_date);
CREATE INDEX IF NOT EXISTS idx_rep_agent_account_cnt_rel 
  ON camd.rep_agent_account (cnt_rel_id);
CREATE INDEX IF NOT EXISTS idx_rep_agent_account_id 
  ON camd.rep_agent_account (account_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_rep_agent_account 
  ON camd.rep_agent_account (rep_agent_account_id);