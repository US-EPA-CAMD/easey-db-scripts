CREATE INDEX IF NOT EXISTS idx_account_unit_unit 
  ON camdams.account_unit (unit_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_account_unit 
  ON camdams.account_unit (account_unit_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_account_unit_account 
  ON camdams.account_unit (account_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_account_unit_account_number 
  ON camdams.account_unit (account_number);
CREATE UNIQUE INDEX IF NOT EXISTS uq_account_unit_arp 
  ON camdams.account_unit (account_id,unit_id);

ALTER TABLE camdams.account_unit
        ADD CONSTRAINT fk_account_unit_account FOREIGN KEY (account_id) 
            REFERENCES camdams.account (account_id);
ALTER TABLE camdams.account_unit
        ADD CONSTRAINT fk_account_unit_unit FOREIGN KEY (unit_id) 
            REFERENCES camd.unit (unit_id);