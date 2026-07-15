CREATE UNIQUE INDEX IF NOT EXISTS pk_csosg2_recall_block 
  ON camdams.csosg2_recall_block (csosg2_recall_block_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_csosg2_recall_block 
  ON camdams.csosg2_recall_block (account_id,prg_vintage_id,begin_number);

ALTER TABLE camdams.csosg2_recall_block
        ADD CONSTRAINT fk_csosg2_recall_block_recall FOREIGN KEY (account_id) 
            REFERENCES camdams.account (account_id);