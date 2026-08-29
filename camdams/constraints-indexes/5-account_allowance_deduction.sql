CREATE INDEX IF NOT EXISTS idx_account_allow_ded_acct 
  ON camdams.account_allowance_deduction (account_id);
CREATE INDEX IF NOT EXISTS idx_account_allow_ded_comp_per 
  ON camdams.account_allowance_deduction (comp_period_id);
CREATE INDEX IF NOT EXISTS idx_account_allow_ded_ded_type 
  ON camdams.account_allowance_deduction (deduction_type_cd);
CREATE INDEX IF NOT EXISTS idx_acct_allow_deduct_acctcomp 
  ON camdams.account_allowance_deduction (account_id,comp_period_id);
CREATE INDEX IF NOT EXISTS idx_acct_allow_deduct_prg_vint 
  ON camdams.account_allowance_deduction (prg_vintage_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_account_allowance_deduction 
  ON camdams.account_allowance_deduction (account_allow_deduction_id);

ALTER TABLE camdams.account_allowance_deduction
        ADD CONSTRAINT fk_acct_allow_ded_acct FOREIGN KEY (account_id) 
            REFERENCES camdams.account (account_id);
ALTER TABLE camdams.account_allowance_deduction
        ADD CONSTRAINT fk_acct_allow_ded_comp_period FOREIGN KEY (comp_period_id) 
            REFERENCES camdams.compliance_period (comp_period_id);
ALTER TABLE camdams.account_allowance_deduction
        ADD CONSTRAINT fk_acct_allow_ded_prg_vintage FOREIGN KEY (prg_vintage_id) 
            REFERENCES camdams.program_vintage (prg_vintage_id);
ALTER TABLE camdams.account_allowance_deduction
        ADD CONSTRAINT fk_acct_allw_ded_ded_type FOREIGN KEY (deduction_type_cd) 
            REFERENCES camdmd.deduction_type_code (deduction_type_cd);