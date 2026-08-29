CREATE INDEX IF NOT EXISTS idx_csosg2_recall_account_gnp 
  ON camdams.csosg2_recall_gnp (account_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_csosg2_recall_gnp 
  ON camdams.csosg2_recall_gnp (csosg2_recall_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_csosg2_recall_gnp 
  ON camdams.csosg2_recall_gnp (account_id,vintage_year);

ALTER TABLE camdams.csosg2_recall_gnp
        ADD CONSTRAINT fk_csosg2_recall_gnp_acct FOREIGN KEY (account_id) 
            REFERENCES camdams.account (account_id);