CREATE INDEX IF NOT EXISTS idx_compliance_emission_arpnox 
  ON camdams.compliance_emission (unit_id,comp_period_id,parameter_cd);
CREATE INDEX IF NOT EXISTS idx_compliance_emission_dat 
  ON camdams.compliance_emission (data_source_cd);
CREATE INDEX IF NOT EXISTS idx_compliance_emission_fac 
  ON camdams.compliance_emission (fac_id);
CREATE INDEX IF NOT EXISTS idx_compliance_emission_par 
  ON camdams.compliance_emission (parameter_cd);
CREATE INDEX IF NOT EXISTS idx_compliance_emission_prd 
  ON camdams.compliance_emission (comp_period_id);
CREATE INDEX IF NOT EXISTS idx_compliance_emission_unt 
  ON camdams.compliance_emission (unit_id);
CREATE INDEX IF NOT EXISTS idx_compliance_emission_val 
  ON camdams.compliance_emission (value_source_cd);
CREATE UNIQUE INDEX IF NOT EXISTS pk_compliance_emission 
  ON camdams.compliance_emission (comp_emiss_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_compliance_emission 
  ON camdams.compliance_emission (fac_id,unit_id,stack_name,comp_period_id,parameter_cd);

ALTER TABLE camdams.compliance_emission
        ADD CONSTRAINT fk_compliance_emission_dat FOREIGN KEY (data_source_cd) 
            REFERENCES camdmd.data_source_code (data_source_cd);
ALTER TABLE camdams.compliance_emission
        ADD CONSTRAINT fk_compliance_emission_fac FOREIGN KEY (fac_id) 
            REFERENCES camd.plant (fac_id);
ALTER TABLE camdams.compliance_emission
        ADD CONSTRAINT fk_compliance_emission_prd FOREIGN KEY (comp_period_id) 
            REFERENCES camdams.compliance_period (comp_period_id);
ALTER TABLE camdams.compliance_emission
        ADD CONSTRAINT fk_compliance_emission_unt FOREIGN KEY (unit_id) 
            REFERENCES camd.unit (unit_id);
ALTER TABLE camdams.compliance_emission
        ADD CONSTRAINT fk_compliance_emission_val FOREIGN KEY (value_source_cd) 
            REFERENCES camdmd.value_source_code (value_source_cd);