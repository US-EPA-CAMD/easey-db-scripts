CREATE UNIQUE INDEX IF NOT EXISTS pk_g2_conv_gnp_acct_grp_acct 
  ON camdams.csosg2_conv_gnp_acct_grp_acct (g2_conv_gnp_acct_grp_acct_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_g2_conv_gnp_acct_grp_acct 
  ON camdams.csosg2_conv_gnp_acct_grp_acct (account_id);

ALTER TABLE camdams.csosg2_conv_gnp_acct_grp_acct
        ADD CONSTRAINT fk_g2_conv_gnp_acct_grp_acct FOREIGN KEY (account_id) 
            REFERENCES camdams.account (account_id);