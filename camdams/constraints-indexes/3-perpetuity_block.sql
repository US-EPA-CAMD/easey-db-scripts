CREATE INDEX IF NOT EXISTS idx_perpetuity_block_account 
  ON camdams.perpetuity_block (account_id);
CREATE INDEX IF NOT EXISTS idx_perpetuity_block_orig_acct 
  ON camdams.perpetuity_block (original_account_id);
CREATE INDEX IF NOT EXISTS idx_perpetuity_block_prg_cd 
  ON camdams.perpetuity_block (prg_cd);
CREATE UNIQUE INDEX IF NOT EXISTS pk_perpetuity_block 
  ON camdams.perpetuity_block (perpetuity_block_id);

ALTER TABLE camdams.perpetuity_block
        ADD CONSTRAINT fk_perpetuity_block_account FOREIGN KEY (account_id) 
            REFERENCES camdams.account (account_id);
ALTER TABLE camdams.perpetuity_block
        ADD CONSTRAINT fk_perpetuity_block_orig_acct FOREIGN KEY (original_account_id) 
            REFERENCES camdams.account (account_id);
ALTER TABLE camdams.perpetuity_block
        ADD CONSTRAINT fk_perpetuity_block_prg_cd FOREIGN KEY (prg_cd) 
            REFERENCES camdmd.program_code (prg_cd);