CREATE INDEX IF NOT EXISTS idx_acct_comp_bal_acct_comp 
  ON camdams.account_compliance_balance (account_comp_id);
CREATE INDEX IF NOT EXISTS idx_acct_comp_bal_bal_cd 
  ON camdams.account_compliance_balance (balance_cd);
CREATE INDEX IF NOT EXISTS idx_acct_comp_bal_prg_vint 
  ON camdams.account_compliance_balance (prg_vintage_id);
CREATE UNIQUE INDEX IF NOT EXISTS idx_acct_comp_prg_vint 
  ON camdams.account_compliance_balance (account_comp_id,prg_vintage_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_account_compliance_balance 
  ON camdams.account_compliance_balance (account_comp_bal_id);

ALTER TABLE camdams.account_compliance_balance
        ADD CONSTRAINT fk_acct_comp_bal_acct_comp FOREIGN KEY (account_comp_id) 
            REFERENCES camdams.account_compliance (account_comp_id);
ALTER TABLE camdams.account_compliance_balance
        ADD CONSTRAINT fk_acct_comp_bal_bal_cd FOREIGN KEY (balance_cd) 
            REFERENCES camdmd.balance_code (balance_cd);
ALTER TABLE camdams.account_compliance_balance
        ADD CONSTRAINT fk_acct_comp_bal_prg_vint FOREIGN KEY (prg_vintage_id) 
            REFERENCES camdams.program_vintage (prg_vintage_id);