CREATE INDEX IF NOT EXISTS idx_acct_comp_acct 
  ON camdams.account_compliance (account_id);
CREATE UNIQUE INDEX IF NOT EXISTS idx_acct_comp_acct_comp 
  ON camdams.account_compliance (account_id,comp_period_id);
CREATE INDEX IF NOT EXISTS idx_acct_comp_comp_period 
  ON camdams.account_compliance (comp_period_id);
CREATE INDEX IF NOT EXISTS idx_acct_comp_comp_period_stat 
  ON camdams.account_compliance (comp_period_id,comp_status_cd);
CREATE INDEX IF NOT EXISTS idx_acct_comp_comp_status 
  ON camdams.account_compliance (comp_status_cd);
CREATE UNIQUE INDEX IF NOT EXISTS pk_account_compliance 
  ON camdams.account_compliance (account_comp_id);

ALTER TABLE camdams.account_compliance
        ADD CONSTRAINT fk_acct_comp_acct FOREIGN KEY (account_id) 
            REFERENCES camdams.account (account_id);
ALTER TABLE camdams.account_compliance
        ADD CONSTRAINT fk_acct_comp_comp_period FOREIGN KEY (comp_period_id) 
            REFERENCES camdams.compliance_period (comp_period_id);
ALTER TABLE camdams.account_compliance
        ADD CONSTRAINT fk_acct_comp_comp_stat_cd FOREIGN KEY (comp_status_cd) 
            REFERENCES camdmd.compliance_status_code (comp_status_cd);