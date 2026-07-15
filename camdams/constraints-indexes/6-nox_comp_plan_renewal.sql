CREATE INDEX IF NOT EXISTS idx_comp_plan_renew_comp_plan 
  ON camdams.nox_comp_plan_renewal (comp_plan_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_nox_comp_plan_renewal 
  ON camdams.nox_comp_plan_renewal (comp_plan_renewal_id);
CREATE UNIQUE INDEX IF NOT EXISTS unq_nox_comp_plan_renewal 
  ON camdams.nox_comp_plan_renewal (comp_plan_id,renewal_date);

ALTER TABLE camdams.nox_comp_plan_renewal
        ADD CONSTRAINT fk_comp_plan_renew_comp_plan FOREIGN KEY (comp_plan_id) 
            REFERENCES camdams.nox_comp_plan (comp_plan_id);