CREATE INDEX IF NOT EXISTS idx_csosg2_rem_conv_acct_gnp 
  ON camdams.csosg2_remaining_conv_gnp (account_id);
CREATE INDEX IF NOT EXISTS idx_csosg2_rem_conv_ga_gnp 
  ON camdams.csosg2_remaining_conv_gnp (general_account_id);
CREATE INDEX IF NOT EXISTS idx_csosg2_rem_conv_trans_gnp 
  ON camdams.csosg2_remaining_conv_gnp (trans_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_csosg2_rem_conv_gnp 
  ON camdams.csosg2_remaining_conv_gnp (csosg2_remaining_conv_id);

ALTER TABLE camdams.csosg2_remaining_conv_gnp
        ADD CONSTRAINT fk_csosg2_rem_conv_account_gnp FOREIGN KEY (account_id) 
            REFERENCES camdams.account (account_id);
ALTER TABLE camdams.csosg2_remaining_conv_gnp
        ADD CONSTRAINT fk_csosg2_rem_conv_ga_gnp FOREIGN KEY (general_account_id) 
            REFERENCES camdams.account (account_id);
ALTER TABLE camdams.csosg2_remaining_conv_gnp
        ADD CONSTRAINT fk_csosg2_rem_conv_trans_gnp FOREIGN KEY (trans_id) 
            REFERENCES camdams.transaction (trans_id);