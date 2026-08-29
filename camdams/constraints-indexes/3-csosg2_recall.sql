CREATE INDEX IF NOT EXISTS idx_csosg2_recall_account 
  ON camdams.csosg2_recall (account_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_csosg2_recall 
  ON camdams.csosg2_recall (csosg2_recall_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_csosg2_recall 
  ON camdams.csosg2_recall (account_id,vintage_year);

ALTER TABLE camdams.csosg2_recall
        ADD CONSTRAINT fk_csosg2_recall_acct FOREIGN KEY (account_id) 
            REFERENCES camdams.account (account_id);