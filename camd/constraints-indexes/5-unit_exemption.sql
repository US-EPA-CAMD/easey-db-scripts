ALTER TABLE camd.unit_exemption
        ADD CONSTRAINT fk_unit_exemption_code FOREIGN KEY (exemption_type_cd) 
            REFERENCES camdmd.exemption_type_code (exemption_type_cd);
ALTER TABLE camd.unit_exemption
        ADD CONSTRAINT fk_unit_exemption_unit FOREIGN KEY (unit_id) 
            REFERENCES camd.unit (unit_id);

CREATE INDEX IF NOT EXISTS idx_unit_exemption_code 
  ON camd.unit_exemption (exemption_type_cd);
CREATE INDEX IF NOT EXISTS idx_unit_exemption_submit 
  ON camd.unit_exemption (submitter_ppl_id);
CREATE INDEX IF NOT EXISTS idx_unit_exemption_unit 
  ON camd.unit_exemption (unit_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_unit_exemption 
  ON camd.unit_exemption (unit_exempt_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_unit_exemption 
  ON camd.unit_exemption (unit_id,begin_date);