CREATE INDEX IF NOT EXISTS idx_nox_unit_avg_plan_avg_plan 
  ON camdams.nox_unit_avg_plan (avg_plan_id);
CREATE INDEX IF NOT EXISTS idx_nox_unit_avg_plan_unit 
  ON camdams.nox_unit_avg_plan (unit_id);
CREATE UNIQUE INDEX IF NOT EXISTS nox_unit_avg_plan_pk 
  ON camdams.nox_unit_avg_plan (unit_avg_plan_id);
CREATE UNIQUE INDEX IF NOT EXISTS unq_nox_unit_avg_plan 
  ON camdams.nox_unit_avg_plan (unit_id,avg_plan_id,begin_date,end_date);

ALTER TABLE camdams.nox_unit_avg_plan
        ADD CONSTRAINT fk_nox_unit_avg_pln_avg_pln_id FOREIGN KEY (avg_plan_id) 
            REFERENCES camdams.nox_avg_plan (avg_plan_id);
ALTER TABLE camdams.nox_unit_avg_plan
        ADD CONSTRAINT fk_nox_unit_avg_pln_avg_unt_id FOREIGN KEY (unit_id) 
            REFERENCES camd.unit (unit_id);