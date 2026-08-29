CREATE INDEX IF NOT EXISTS idx_trans_account_comp 
  ON camdams.transaction (account_comp_id);
CREATE INDEX IF NOT EXISTS idx_trans_buy_account 
  ON camdams.transaction (buy_account_id);
CREATE INDEX IF NOT EXISTS idx_trans_buy_ppl_id 
  ON camdams.transaction (buy_ppl_id);
CREATE INDEX IF NOT EXISTS idx_trans_prg_cd 
  ON camdams.transaction (prg_cd);
CREATE INDEX IF NOT EXISTS idx_trans_sell_account 
  ON camdams.transaction (sell_account_id);
CREATE INDEX IF NOT EXISTS idx_trans_sell_ppl_id 
  ON camdams.transaction (sell_ppl_id);
CREATE INDEX IF NOT EXISTS idx_trans_trans_changed_trans 
  ON camdams.transaction (changed_trans_id);
CREATE INDEX IF NOT EXISTS idx_trans_trans_number 
  ON camdams.transaction (trans_number);
CREATE INDEX IF NOT EXISTS idx_trans_trans_status_cd 
  ON camdams.transaction (trans_status_cd);
CREATE INDEX IF NOT EXISTS idx_trans_trans_type 
  ON camdams.transaction (trans_type_cd);
CREATE INDEX IF NOT EXISTS idx_trans_unit_id 
  ON camdams.transaction (unit_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_transaction 
  ON camdams.transaction (trans_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq1_transaction_prg_trans 
  ON camdams.transaction (prg_cd,trans_number);

ALTER TABLE camdams.transaction
        ADD CONSTRAINT fk_idx_trans_trans_type FOREIGN KEY (trans_type_cd) 
            REFERENCES camdmd.transaction_type_code (trans_type_cd);
ALTER TABLE camdams.transaction
        ADD CONSTRAINT fk_trans_account_comp FOREIGN KEY (account_comp_id) 
            REFERENCES camdams.account_compliance (account_comp_id);
ALTER TABLE camdams.transaction
        ADD CONSTRAINT fk_trans_buy_account FOREIGN KEY (buy_account_id) 
            REFERENCES camdams.account (account_id);
ALTER TABLE camdams.transaction
        ADD CONSTRAINT fk_trans_prg_cd FOREIGN KEY (prg_cd) 
            REFERENCES camdmd.program_code (prg_cd);
ALTER TABLE camdams.transaction
        ADD CONSTRAINT fk_trans_sell_account FOREIGN KEY (sell_account_id) 
            REFERENCES camdams.account (account_id);
ALTER TABLE camdams.transaction
        ADD CONSTRAINT fk_trans_sell_ppl_id FOREIGN KEY (sell_ppl_id) 
            REFERENCES camd.person (ppl_id);
ALTER TABLE camdams.transaction
        ADD CONSTRAINT fk_trans_trans_changed_trans FOREIGN KEY (changed_trans_id) 
            REFERENCES camdams.transaction (trans_id);
ALTER TABLE camdams.transaction
        ADD CONSTRAINT fk_trans_trans_status_cd FOREIGN KEY (trans_status_cd) 
            REFERENCES camdmd.transaction_status_code (trans_status_cd);
ALTER TABLE camdams.transaction
        ADD CONSTRAINT fk_trans_unit_id FOREIGN KEY (unit_id) 
            REFERENCES camd.unit (unit_id);