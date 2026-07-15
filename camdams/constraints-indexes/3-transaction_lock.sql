CREATE UNIQUE INDEX IF NOT EXISTS pk_transaction_lock 
  ON camdams.transaction_lock (account_id);

ALTER TABLE camdams.transaction_lock
        ADD CONSTRAINT fk_trans_lock_account FOREIGN KEY (account_id) 
            REFERENCES camdams.account (account_id);