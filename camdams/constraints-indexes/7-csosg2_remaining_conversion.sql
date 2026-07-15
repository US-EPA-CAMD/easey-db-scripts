CREATE INDEX IF NOT EXISTS idx_csosg2_remain_conv_account 
  ON camdams.csosg2_remaining_conversion (account_id);
CREATE INDEX IF NOT EXISTS idx_csosg2_remain_conv_ga 
  ON camdams.csosg2_remaining_conversion (general_account_id);
CREATE INDEX IF NOT EXISTS idx_csosg2_remain_conv_trans 
  ON camdams.csosg2_remaining_conversion (trans_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_csosg2_remaining_conv 
  ON camdams.csosg2_remaining_conversion (csosg2_remaining_conv_id);

ALTER TABLE camdams.csosg2_remaining_conversion
        ADD CONSTRAINT fk_csosg2_remain_conv_account FOREIGN KEY (account_id) 
            REFERENCES camdams.account (account_id);
ALTER TABLE camdams.csosg2_remaining_conversion
        ADD CONSTRAINT fk_csosg2_remain_conv_ga FOREIGN KEY (general_account_id) 
            REFERENCES camdams.account (account_id);
ALTER TABLE camdams.csosg2_remaining_conversion
        ADD CONSTRAINT fk_csosg2_remain_conv_trans FOREIGN KEY (trans_id) 
            REFERENCES camdams.transaction (trans_id);