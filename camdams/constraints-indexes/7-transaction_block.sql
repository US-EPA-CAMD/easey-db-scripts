CREATE INDEX IF NOT EXISTS idx_trans_block_allow_vint 
  ON camdams.transaction_block (prg_vintage_id);
CREATE INDEX IF NOT EXISTS idx_trans_block_trans 
  ON camdams.transaction_block (trans_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_transaction_block 
  ON camdams.transaction_block (trans_block_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_trans_blk_trns_beg_end_prg 
  ON camdams.transaction_block (trans_id,begin_number,end_number,prg_vintage_id);

ALTER TABLE camdams.transaction_block
        ADD CONSTRAINT fk_trans_block_allow_vint FOREIGN KEY (prg_vintage_id) 
            REFERENCES camdams.program_vintage (prg_vintage_id);
ALTER TABLE camdams.transaction_block
        ADD CONSTRAINT fk_trans_block_trans FOREIGN KEY (trans_id) 
            REFERENCES camdams.transaction (trans_id);