CREATE INDEX IF NOT EXISTS idx_temp_account_block_acp 
  ON camdams.temp_account_block (account_comp_id);
CREATE INDEX IF NOT EXISTS idx_temp_account_block_prv 
  ON camdams.temp_account_block (prg_vintage_id);
CREATE INDEX IF NOT EXISTS idx_temp_account_block_typ 
  ON camdams.temp_account_block (trans_type_cd);

ALTER TABLE camdams.temp_account_block
        ADD CONSTRAINT fk_temp_account_block_acp FOREIGN KEY (account_comp_id) 
            REFERENCES camdams.account_compliance (account_comp_id);
ALTER TABLE camdams.temp_account_block
        ADD CONSTRAINT fk_temp_account_block_prv FOREIGN KEY (prg_vintage_id) 
            REFERENCES camdams.program_vintage (prg_vintage_id);
ALTER TABLE camdams.temp_account_block
        ADD CONSTRAINT fk_temp_account_block_typ FOREIGN KEY (trans_type_cd) 
            REFERENCES camdmd.transaction_type_code (trans_type_cd);