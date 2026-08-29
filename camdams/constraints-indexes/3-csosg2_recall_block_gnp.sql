CREATE UNIQUE INDEX IF NOT EXISTS pk_csosg2_recall_block_gnp 
  ON camdams.csosg2_recall_block_gnp (csosg2_recall_block_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_csosg2_recall_block_gnp 
  ON camdams.csosg2_recall_block_gnp (account_id,prg_vintage_id,begin_number);

ALTER TABLE camdams.csosg2_recall_block_gnp
        ADD CONSTRAINT fk_csosg2_rec_block_recall_gnp FOREIGN KEY (account_id) 
            REFERENCES camdams.account (account_id);