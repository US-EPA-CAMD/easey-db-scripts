CREATE UNIQUE INDEX IF NOT EXISTS pk_compliance_problem_tr 
  ON camdams.compliance_problem_transaction (comp_prob_trans_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_compliance_problem_tr 
  ON camdams.compliance_problem_transaction (trans_id,account_comp_id);

ALTER TABLE camdams.compliance_problem_transaction
        ADD CONSTRAINT idx_compliance_problem_tr_acp FOREIGN KEY (account_comp_id) 
            REFERENCES camdams.account_compliance (account_comp_id);
ALTER TABLE camdams.compliance_problem_transaction
        ADD CONSTRAINT idx_compliance_problem_tr_trn FOREIGN KEY (trans_id) 
            REFERENCES camdams.transaction (trans_id);