ALTER TABLE camd.unit
        ADD CONSTRAINT fk_unit_naics FOREIGN KEY (naics_cd) 
            REFERENCES camdmd.naics_code (naics_cd);
ALTER TABLE camd.unit
        ADD CONSTRAINT fk_unit_plant FOREIGN KEY (fac_id) 
            REFERENCES camd.plant (fac_id);
ALTER TABLE camd.unit
        ADD CONSTRAINT fk_unit_source_category FOREIGN KEY (source_category_cd) 
            REFERENCES camdmd.source_category_code (source_category_cd);

CREATE INDEX IF NOT EXISTS idx_unit_naics 
  ON camd.unit (naics_cd);
CREATE INDEX IF NOT EXISTS idx_unit_plant 
  ON camd.unit (fac_id);
CREATE INDEX IF NOT EXISTS idx_unit_source_category 
  ON camd.unit (source_category_cd);
CREATE UNIQUE INDEX IF NOT EXISTS pk_unit 
  ON camd.unit (unit_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_unit 
  ON camd.unit (fac_id,unitid);