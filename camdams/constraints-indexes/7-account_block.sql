CREATE INDEX IF NOT EXISTS idx_account_block_account 
  ON camdams.account_block (account_id);
CREATE UNIQUE INDEX IF NOT EXISTS idx_account_block_allow_block 
  ON camdams.account_block (allow_block_id);
CREATE INDEX IF NOT EXISTS idx_acct_block_trans 
  ON camdams.account_block (trans_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_account_block 
  ON camdams.account_block (account_block_id);

ALTER TABLE camdams.account_block
        ADD CONSTRAINT fk_acct_block_acct FOREIGN KEY (account_id) 
            REFERENCES camdams.account (account_id);
ALTER TABLE camdams.account_block
        ADD CONSTRAINT fk_acct_block_allow_block FOREIGN KEY (allow_block_id) 
            REFERENCES camdams.allowance_block (allow_block_id);
ALTER TABLE camdams.account_block
        ADD CONSTRAINT fk_acct_block_trans FOREIGN KEY (trans_id) 
            REFERENCES camdams.transaction (trans_id);