CREATE INDEX IF NOT EXISTS idx_account_comp_hist_acp 
  ON camdams.account_compliance_history (account_comp_id);
CREATE INDEX IF NOT EXISTS idx_account_comp_hist_bal 
  ON camdams.account_compliance_history (balance_cd);
CREATE INDEX IF NOT EXISTS idx_account_comp_hist_prv 
  ON camdams.account_compliance_history (prg_vintage_id);

ALTER TABLE camdams.account_compliance_history
        ADD CONSTRAINT fk_account_comp_hist_acp FOREIGN KEY (account_comp_id) 
            REFERENCES camdams.account_compliance (account_comp_id);
ALTER TABLE camdams.account_compliance_history
        ADD CONSTRAINT fk_account_comp_hist_bal FOREIGN KEY (balance_cd) 
            REFERENCES camdmd.balance_code (balance_cd);
ALTER TABLE camdams.account_compliance_history
        ADD CONSTRAINT fk_account_comp_hist_prv FOREIGN KEY (prg_vintage_id) 
            REFERENCES camdams.program_vintage (prg_vintage_id);