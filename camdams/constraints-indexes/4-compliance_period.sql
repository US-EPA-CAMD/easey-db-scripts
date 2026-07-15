CREATE INDEX IF NOT EXISTS idx_comp_period_prg_vintage 
  ON camdams.compliance_period (prg_vintage_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_compliance_period 
  ON camdams.compliance_period (comp_period_id);

ALTER TABLE camdams.compliance_period
        ADD CONSTRAINT fk_comp_period_prg_vintage FOREIGN KEY (prg_vintage_id) 
            REFERENCES camdams.program_vintage (prg_vintage_id);