CREATE UNIQUE INDEX IF NOT EXISTS pk_corrected_transaction 
  ON camdams.corrected_transaction (corrected_trans_id);

ALTER TABLE camdams.corrected_transaction
        ADD CONSTRAINT idx_corrected_trans_trans_ams FOREIGN KEY (trans_id) 
            REFERENCES camdams.transaction (trans_id);
ALTER TABLE camdams.corrected_transaction
        ADD CONSTRAINT idx_corrected_trans_trans_nats FOREIGN KEY (tranevnt_cnt) 
            REFERENCES camdnats.ttransact (tranevnt_cnt);