ALTER TABLE camdaux.compliance_emission_log
        ADD CONSTRAINT compliance_emission_log_cp_fk FOREIGN KEY (comp_period_id) 
            REFERENCES camdams.compliance_period (comp_period_id);
ALTER TABLE camdaux.compliance_emission_log
        ADD CONSTRAINT compliance_emission_log_fac_fk FOREIGN KEY (fac_id) 
            REFERENCES camd.plant (fac_id);
ALTER TABLE camdaux.compliance_emission_log
        ADD CONSTRAINT compliance_emission_log_prg_fk FOREIGN KEY (prg_cd) 
            REFERENCES camdmd.program_code (prg_cd);
ALTER TABLE camdaux.compliance_emission_log
        ADD CONSTRAINT compliance_emission_log_unt_fk FOREIGN KEY (unit_id) 
            REFERENCES camd.unit (unit_id);

CREATE INDEX IF NOT EXISTS compliance_emission_log_mth_ix 
  ON camdaux.compliance_emission_log (package_name,method_name);
CREATE UNIQUE INDEX IF NOT EXISTS compliance_emission_log_pk 
  ON camdaux.compliance_emission_log (comp_emiss_log_id);
CREATE INDEX IF NOT EXISTS compliance_emission_log_rpt_ix 
  ON camdaux.compliance_emission_log (mon_plan_id,rpt_period_id,package_name);