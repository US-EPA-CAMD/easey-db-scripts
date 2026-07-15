CREATE INDEX IF NOT EXISTS idx_auth_acct_prg 
  ON camdams.authority (account_prg_id);
CREATE INDEX IF NOT EXISTS idx_auth_auth_type_cd 
  ON camdams.authority (authority_type_cd);
CREATE INDEX IF NOT EXISTS idx_auth_limit_type_cd 
  ON camdams.authority (limit_type_cd);
CREATE INDEX IF NOT EXISTS idx_auth_parent_auth 
  ON camdams.authority (parent_authority_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_authority 
  ON camdams.authority (authority_id);

ALTER TABLE camdams.authority
        ADD CONSTRAINT fk_auth_acct_prg FOREIGN KEY (account_prg_id) 
            REFERENCES camdams.account_program (account_prg_id);
ALTER TABLE camdams.authority
        ADD CONSTRAINT fk_auth_auth FOREIGN KEY (parent_authority_id) 
            REFERENCES camdams.authority (authority_id);
ALTER TABLE camdams.authority
        ADD CONSTRAINT fk_auth_auth_type_cd FOREIGN KEY (authority_type_cd) 
            REFERENCES camdmd.authority_type_code (authority_type_cd);
ALTER TABLE camdams.authority
        ADD CONSTRAINT fk_auth_limit_type_cd FOREIGN KEY (limit_type_cd) 
            REFERENCES camdmd.limit_type_code (limit_type_cd);