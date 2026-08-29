CREATE UNIQUE INDEX IF NOT EXISTS pk_account_plant 
  ON camdams.account_plant (account_plant_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_account_plant 
  ON camdams.account_plant (account_id,fac_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_acct_account_plant_acct 
  ON camdams.account_plant (account_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_acct_account_plant_plant 
  ON camdams.account_plant (fac_id);

ALTER TABLE camdams.account_plant
        ADD CONSTRAINT fk_acct_account_plant_plant FOREIGN KEY (fac_id) 
            REFERENCES camd.plant (fac_id);
ALTER TABLE camdams.account_plant
        ADD CONSTRAINT fk_acct_fac_acct FOREIGN KEY (account_id) 
            REFERENCES camdams.account (account_id);