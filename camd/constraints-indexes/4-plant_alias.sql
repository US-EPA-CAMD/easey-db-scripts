ALTER TABLE camd.plant_alias
        ADD CONSTRAINT fk_plant_alias_plant FOREIGN KEY (fac_id) 
            REFERENCES camd.plant (fac_id);

CREATE INDEX IF NOT EXISTS idx_plant_alias_plant 
  ON camd.plant_alias (fac_id);
CREATE INDEX IF NOT EXISTS idx_plant_alias_type 
  ON camd.plant_alias (alias_type);
CREATE UNIQUE INDEX IF NOT EXISTS pk_plant_alias 
  ON camd.plant_alias (plant_alias_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_plant_alias_type_date 
  ON camd.plant_alias (fac_id,alias_type,alias_date);