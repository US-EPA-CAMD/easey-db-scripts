CREATE INDEX IF NOT EXISTS idx_account_comp_block_acp 
  ON camdams.account_compliance_block (account_comp_id);
CREATE INDEX IF NOT EXISTS idx_account_comp_block_bal 
  ON camdams.account_compliance_block (balance_cd);
CREATE INDEX IF NOT EXISTS idx_account_comp_block_prv 
  ON camdams.account_compliance_block (prg_vintage_id);
CREATE INDEX IF NOT EXISTS idx_account_comp_block_typ 
  ON camdams.account_compliance_block (trans_type_cd);
CREATE UNIQUE INDEX IF NOT EXISTS pk_account_comp_block 
  ON camdams.account_compliance_block (account_comp_block_id);

ALTER TABLE camdams.account_compliance_block
        ADD CONSTRAINT fk_account_comp_block_acp FOREIGN KEY (account_comp_id) 
            REFERENCES camdams.account_compliance (account_comp_id);
ALTER TABLE camdams.account_compliance_block
        ADD CONSTRAINT fk_account_comp_block_bal FOREIGN KEY (balance_cd) 
            REFERENCES camdmd.balance_code (balance_cd);
ALTER TABLE camdams.account_compliance_block
        ADD CONSTRAINT fk_account_comp_block_prv FOREIGN KEY (prg_vintage_id) 
            REFERENCES camdams.program_vintage (prg_vintage_id);
ALTER TABLE camdams.account_compliance_block
        ADD CONSTRAINT fk_account_comp_block_typ FOREIGN KEY (trans_type_cd) 
            REFERENCES camdmd.transaction_type_code (trans_type_cd);