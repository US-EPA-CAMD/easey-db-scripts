CREATE INDEX IF NOT EXISTS idx_comp_freeze_bal_acct 
  ON camdams.compliance_freeze_balance (account_id);
CREATE INDEX IF NOT EXISTS idx_comp_freeze_bal_bal_cd 
  ON camdams.compliance_freeze_balance (balance_cd);
CREATE INDEX IF NOT EXISTS idx_comp_freeze_bal_comp_per 
  ON camdams.compliance_freeze_balance (comp_period_id);
CREATE INDEX IF NOT EXISTS idx_comp_freeze_bal_prg_vintag 
  ON camdams.compliance_freeze_balance (prg_vintage_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_compliance_freeze_balance 
  ON camdams.compliance_freeze_balance (comp_freeze_bal_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq1_acc_comp_vint 
  ON camdams.compliance_freeze_balance (account_id,comp_period_id,prg_vintage_id);

ALTER TABLE camdams.compliance_freeze_balance
        ADD CONSTRAINT fk_comp_freeze_bal_acct FOREIGN KEY (account_id) 
            REFERENCES camdams.account (account_id);
ALTER TABLE camdams.compliance_freeze_balance
        ADD CONSTRAINT fk_comp_freeze_bal_bal_cd FOREIGN KEY (balance_cd) 
            REFERENCES camdmd.balance_code (balance_cd);
ALTER TABLE camdams.compliance_freeze_balance
        ADD CONSTRAINT fk_comp_freeze_bal_comp_period FOREIGN KEY (comp_period_id) 
            REFERENCES camdams.compliance_period (comp_period_id);
ALTER TABLE camdams.compliance_freeze_balance
        ADD CONSTRAINT fk_comp_freeze_bal_prg_vintage FOREIGN KEY (prg_vintage_id) 
            REFERENCES camdams.program_vintage (prg_vintage_id);