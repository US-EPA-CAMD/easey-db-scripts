CREATE INDEX IF NOT EXISTS idx_account_comp_liability_acp 
  ON camdams.account_compliance_liability (account_comp_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_account_comp_liability 
  ON camdams.account_compliance_liability (account_comp_liability_id);

ALTER TABLE camdams.account_compliance_liability
        ADD CONSTRAINT fk_account_comp_liability_acp FOREIGN KEY (account_comp_id) 
            REFERENCES camdams.account_compliance (account_comp_id);