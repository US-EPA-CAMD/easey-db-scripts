ALTER TABLE camd.region_analyst
        ADD CONSTRAINT fk_region_analyst_epa_region FOREIGN KEY (epa_region) 
            REFERENCES camdmd.epa_region_code (epa_region_cd);
ALTER TABLE camd.region_analyst
        ADD CONSTRAINT fk_region_analyst_person FOREIGN KEY (ppl_id) 
            REFERENCES camd.person (ppl_id);

CREATE INDEX IF NOT EXISTS idx_region_analyst_person 
  ON camd.region_analyst (ppl_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_region_analyst 
  ON camd.region_analyst (region_analyst_id);