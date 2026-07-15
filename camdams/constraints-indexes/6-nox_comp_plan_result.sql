CREATE INDEX IF NOT EXISTS idx_nox_comp_plan_result_final 
  ON camdams.nox_comp_plan_result (final_ind);
CREATE UNIQUE INDEX IF NOT EXISTS pk_nox_comp_plan_result 
  ON camdams.nox_comp_plan_result (comp_plan_id,comp_period_id);

ALTER TABLE camdams.nox_comp_plan_result
        ADD CONSTRAINT fk_comp_plan_result_comp_plan FOREIGN KEY (comp_plan_id) 
            REFERENCES camdams.nox_comp_plan (comp_plan_id);
ALTER TABLE camdams.nox_comp_plan_result
        ADD CONSTRAINT fk_nox_comp_pln_res_comp_perid FOREIGN KEY (comp_period_id) 
            REFERENCES camdams.compliance_period (comp_period_id);