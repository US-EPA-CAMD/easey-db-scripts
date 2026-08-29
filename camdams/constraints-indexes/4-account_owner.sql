CREATE INDEX IF NOT EXISTS idx_account_owner_account_id 
  ON camdams.account_owner (account_id);
CREATE INDEX IF NOT EXISTS idx_account_owner_agency 
  ON camdams.account_owner (agency_id);
CREATE INDEX IF NOT EXISTS idx_account_owner_company 
  ON camdams.account_owner (company_id);
CREATE INDEX IF NOT EXISTS idx_account_owner_person 
  ON camdams.account_owner (ppl_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_account_owner 
  ON camdams.account_owner (account_owner_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_account_owner 
  ON camdams.account_owner (account_id,company_id,ppl_id,agency_id,begin_date);

ALTER TABLE camdams.account_owner
        ADD CONSTRAINT fk_acct_owner_acct FOREIGN KEY (account_id) 
            REFERENCES camdams.account (account_id);
ALTER TABLE camdams.account_owner
        ADD CONSTRAINT fk_acct_owner_agency FOREIGN KEY (agency_id) 
            REFERENCES camd.agency (agency_id);
ALTER TABLE camdams.account_owner
        ADD CONSTRAINT fk_acct_owner_company FOREIGN KEY (company_id) 
            REFERENCES camd.company (company_id);
ALTER TABLE camdams.account_owner
        ADD CONSTRAINT fk_acct_owner_person FOREIGN KEY (ppl_id) 
            REFERENCES camd.person (ppl_id);