CREATE INDEX IF NOT EXISTS idx_account_comp_assurance_acp 
  ON camdams.account_compliance_assurance (account_comp_id);
CREATE INDEX IF NOT EXISTS idx_account_comp_assurance_trn 
  ON camdams.account_compliance_assurance (trans_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_account_comp_assurance 
  ON camdams.account_compliance_assurance (account_comp_assurance_id);

ALTER TABLE camdams.account_compliance_assurance
        ADD CONSTRAINT fk_account_comp_assurance_acp FOREIGN KEY (account_comp_id) 
            REFERENCES camdams.account_compliance (account_comp_id);
ALTER TABLE camdams.account_compliance_assurance
        ADD CONSTRAINT fk_account_comp_assurance_trn FOREIGN KEY (trans_id) 
            REFERENCES camdams.transaction (trans_id);