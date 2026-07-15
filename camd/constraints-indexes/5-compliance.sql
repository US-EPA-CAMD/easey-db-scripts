ALTER TABLE camd.compliance
        ADD CONSTRAINT fk_compliance_unit FOREIGN KEY (unit_id) 
            REFERENCES camd.unit (unit_id);

CREATE INDEX IF NOT EXISTS compliance_idx001 
  ON camd.compliance (unit_id,comp_year);
CREATE UNIQUE INDEX IF NOT EXISTS pk_ac 
  ON camd.compliance (unit_id,prg_code,comp_year);