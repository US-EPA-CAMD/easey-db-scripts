ALTER TABLE camd.plant
        ADD CONSTRAINT fk_plant_county FOREIGN KEY (county_cd) 
            REFERENCES camdmd.county_code (county_cd);
ALTER TABLE camd.plant
        ADD CONSTRAINT fk_plant_epa_region FOREIGN KEY (epa_region) 
            REFERENCES camdmd.epa_region_code (epa_region_cd);
ALTER TABLE camd.plant
        ADD CONSTRAINT fk_plant_nerc FOREIGN KEY (nerc_region) 
            REFERENCES camdmd.nerc_region_code (nerc_region_cd);
ALTER TABLE camd.plant
        ADD CONSTRAINT fk_plant_sic FOREIGN KEY (sic_code) 
            REFERENCES camdmd.sic_code (sic_code);
ALTER TABLE camd.plant
        ADD CONSTRAINT fk_plant_state FOREIGN KEY (state) 
            REFERENCES camdmd.state_code (state_cd);
ALTER TABLE camd.plant
        ADD CONSTRAINT fk_plant_tribal_land FOREIGN KEY (tribal_land_cd) 
            REFERENCES camdmd.tribal_land_code (tribal_land_cd);

CREATE INDEX IF NOT EXISTS idx_plant_country 
  ON camd.plant (county_cd);
CREATE INDEX IF NOT EXISTS idx_plant_epa_id_oris_name 
  ON camd.plant (epa_region,fac_id,oris_code,facility_name);
CREATE INDEX IF NOT EXISTS idx_plant_epa_region 
  ON camd.plant (epa_region);
CREATE INDEX IF NOT EXISTS idx_plant_nerc 
  ON camd.plant (nerc_region);
CREATE INDEX IF NOT EXISTS idx_plant_sic 
  ON camd.plant (sic_code);
CREATE INDEX IF NOT EXISTS idx_plant_state 
  ON camd.plant (state);
CREATE INDEX IF NOT EXISTS idx_plant_tribal_land 
  ON camd.plant (tribal_land_cd);
CREATE UNIQUE INDEX IF NOT EXISTS pk_plant 
  ON camd.plant (fac_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_plant_name_state 
  ON camd.plant (facility_name,state);
CREATE UNIQUE INDEX IF NOT EXISTS uq_plant_oris_code 
  ON camd.plant (oris_code);