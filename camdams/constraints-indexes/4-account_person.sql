CREATE INDEX IF NOT EXISTS idx_account_ppl_account 
  ON camdams.account_person (account_id);
CREATE INDEX IF NOT EXISTS idx_account_ppl_lk 
  ON camdams.account_person (account_id,ppl_id,responsibility_id,begin_date,end_date);
CREATE INDEX IF NOT EXISTS idx_account_ppl_ppl_id 
  ON camdams.account_person (ppl_id);
CREATE INDEX IF NOT EXISTS idx_account_ppl_respons_id 
  ON camdams.account_person (responsibility_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_account_person 
  ON camdams.account_person (account_ppl_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_account_person 
  ON camdams.account_person (account_id,ppl_id,responsibility_id,begin_date);

ALTER TABLE camdams.account_person
        ADD CONSTRAINT fk_acct_ppl_acct FOREIGN KEY (account_id) 
            REFERENCES camdams.account (account_id);
ALTER TABLE camdams.account_person
        ADD CONSTRAINT fk_acct_ppl_ppl FOREIGN KEY (ppl_id) 
            REFERENCES camd.person (ppl_id);
ALTER TABLE camdams.account_person
        ADD CONSTRAINT fk_acct_ppl_respons FOREIGN KEY (responsibility_id) 
            REFERENCES camdmd.responsibility (responsibility_id);