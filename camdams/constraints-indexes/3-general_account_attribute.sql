CREATE UNIQUE INDEX IF NOT EXISTS pk_general_account_attr 
  ON camdams.general_account_attribute (account_id);

ALTER TABLE camdams.general_account_attribute
        ADD CONSTRAINT fk_general_account_attr_acct FOREIGN KEY (account_id) 
            REFERENCES camdams.account (account_id);