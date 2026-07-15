CREATE INDEX IF NOT EXISTS comp_emission_detail_cmploc_ix 
  ON camdams.compliance_emission_detail (comp_period_id,parameter_cd,mon_loc_id);
CREATE UNIQUE INDEX IF NOT EXISTS comp_emission_detail_pk 
  ON camdams.compliance_emission_detail (comp_emiss_detail_id);
CREATE INDEX IF NOT EXISTS idx_comp_emiss_det_comp_value 
  ON camdams.compliance_emission_detail (comp_period_id,value_source_cd);

ALTER TABLE camdams.compliance_emission_detail
        ADD CONSTRAINT comp_emission_detail_cmp_fk FOREIGN KEY (comp_period_id) 
            REFERENCES camdams.compliance_period (comp_period_id);
ALTER TABLE camdams.compliance_emission_detail
        ADD CONSTRAINT comp_emission_detail_src_fk FOREIGN KEY (value_source_cd) 
            REFERENCES camdmd.value_source_code (value_source_cd);