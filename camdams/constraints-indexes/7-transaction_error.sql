CREATE INDEX IF NOT EXISTS idx_trans_error_trans 
  ON camdams.transaction_error (trans_id);
CREATE INDEX IF NOT EXISTS idx_trans_error_trans_error_cd 
  ON camdams.transaction_error (trans_error_cd);
CREATE UNIQUE INDEX IF NOT EXISTS pk_trans_error 
  ON camdams.transaction_error (trans_error_id);

ALTER TABLE camdams.transaction_error
        ADD CONSTRAINT fk_trans_error_trans FOREIGN KEY (trans_id) 
            REFERENCES camdams.transaction (trans_id);
ALTER TABLE camdams.transaction_error
        ADD CONSTRAINT fk_trans_error_trans_error_cd FOREIGN KEY (trans_error_cd) 
            REFERENCES camdmd.transaction_error_code (trans_error_cd);