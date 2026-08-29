CREATE UNIQUE INDEX IF NOT EXISTS idx_account_account_number 
  ON camdams.account (account_number);
CREATE INDEX IF NOT EXISTS idx_account_account_type 
  ON camdams.account (account_type_cd);
CREATE INDEX IF NOT EXISTS idx_account_acct_num_acct_type 
  ON camdams.account (account_number,account_type_cd);
CREATE INDEX IF NOT EXISTS idx_account_state_cd 
  ON camdams.account (state_cd);
CREATE INDEX IF NOT EXISTS idx_account_tribal_land_cd 
  ON camdams.account (tribal_land_cd);
CREATE UNIQUE INDEX IF NOT EXISTS pk_account 
  ON camdams.account (account_id);

ALTER TABLE camdams.account
        ADD CONSTRAINT fk_account_state_cd FOREIGN KEY (state_cd) 
            REFERENCES camdmd.state_code (state_cd);
ALTER TABLE camdams.account
        ADD CONSTRAINT fk_account_tribal_land FOREIGN KEY (tribal_land_cd) 
            REFERENCES camdmd.tribal_land_code (tribal_land_cd);
ALTER TABLE camdams.account
        ADD CONSTRAINT fk_acct_acct_type_cd FOREIGN KEY (account_type_cd) 
            REFERENCES camdmd.account_type_code (account_type_cd);