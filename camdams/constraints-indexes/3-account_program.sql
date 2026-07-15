CREATE INDEX IF NOT EXISTS idx_account_prg 
  ON camdams.account_program (prg_cd);
CREATE INDEX IF NOT EXISTS idx_account_prg_acct_status_cd 
  ON camdams.account_program (account_status_cd);
CREATE INDEX IF NOT EXISTS idx_account_program_account_id 
  ON camdams.account_program (account_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_account_program 
  ON camdams.account_program (account_prg_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_account_program 
  ON camdams.account_program (account_id,prg_cd);

ALTER TABLE camdams.account_program
        ADD CONSTRAINT fk_acct_prg_acct FOREIGN KEY (account_id) 
            REFERENCES camdams.account (account_id);
ALTER TABLE camdams.account_program
        ADD CONSTRAINT fk_acct_prg_acct_stat_cd FOREIGN KEY (account_status_cd) 
            REFERENCES camdmd.account_status_code (account_status_cd);
ALTER TABLE camdams.account_program
        ADD CONSTRAINT fk_acct_prg_program FOREIGN KEY (prg_cd) 
            REFERENCES camdmd.program_code (prg_cd);