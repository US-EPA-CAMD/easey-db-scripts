ALTER TABLE camd.unit_owner
        ADD CONSTRAINT fk_unit_owner_company FOREIGN KEY (comp_id) 
            REFERENCES camd.company (company_id);
ALTER TABLE camd.unit_owner
        ADD CONSTRAINT fk_unit_owner_type FOREIGN KEY (owner_type_cd) 
            REFERENCES camdmd.owner_type_code (owner_type_cd);
ALTER TABLE camd.unit_owner
        ADD CONSTRAINT fk_unit_owner_unit FOREIGN KEY (unit_id) 
            REFERENCES camd.unit (unit_id);

CREATE INDEX IF NOT EXISTS idx_unit_owner_company 
  ON camd.unit_owner (comp_id);
CREATE INDEX IF NOT EXISTS idx_unit_owner_type 
  ON camd.unit_owner (owner_type_cd);
CREATE INDEX IF NOT EXISTS idx_unit_owner_unit 
  ON camd.unit_owner (unit_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_unit_owner 
  ON camd.unit_owner (unit_owner_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_unit_owner_comp_own_date 
  ON camd.unit_owner (unit_id,comp_id,owner_type_cd,begin_date);