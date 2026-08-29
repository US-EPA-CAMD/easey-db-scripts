CREATE UNIQUE INDEX IF NOT EXISTS pk_csapr_ozone_deduction 
  ON camdams.csapr_ozone_deduction (csapr_ozone_deduction_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_csapr_ozone_deduction 
  ON camdams.csapr_ozone_deduction (trans_id,account_comp_id);

ALTER TABLE camdams.csapr_ozone_deduction
        ADD CONSTRAINT idx_csapr_ozone_deduction_acp FOREIGN KEY (account_comp_id) 
            REFERENCES camdams.account_compliance (account_comp_id);
ALTER TABLE camdams.csapr_ozone_deduction
        ADD CONSTRAINT idx_csapr_ozone_deduction_trn FOREIGN KEY (trans_id) 
            REFERENCES camdams.transaction (trans_id);