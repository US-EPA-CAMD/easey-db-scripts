CREATE UNIQUE INDEX IF NOT EXISTS pk_account_comp_penalty 
  ON camdams.account_compliance_penalty (account_comp_id);

ALTER TABLE camdams.account_compliance_penalty
        ADD CONSTRAINT fk_account_comp_penalty_acp FOREIGN KEY (account_comp_id) 
            REFERENCES camdams.account_compliance (account_comp_id);