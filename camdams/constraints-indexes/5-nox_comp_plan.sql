CREATE INDEX IF NOT EXISTS idx_nox_comp_plan_type 
  ON camdams.nox_comp_plan (comp_plan_type_cd);
CREATE UNIQUE INDEX IF NOT EXISTS pk_nox_comp_plan 
  ON camdams.nox_comp_plan (comp_plan_id);
CREATE UNIQUE INDEX IF NOT EXISTS unq_nox_comp_plan_unit_begin 
  ON camdams.nox_comp_plan (unit_id,begin_date);

ALTER TABLE camdams.nox_comp_plan
        ADD CONSTRAINT fk_nox_comp_plan_type FOREIGN KEY (comp_plan_type_cd) 
            REFERENCES camdmd.nox_comp_plan_type_code (comp_plan_type_cd);
ALTER TABLE camdams.nox_comp_plan
        ADD CONSTRAINT fk_nox_comp_plan_unit FOREIGN KEY (unit_id) 
            REFERENCES camd.unit (unit_id);