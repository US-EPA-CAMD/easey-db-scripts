ALTER TABLE camd.plant_person
        ADD CONSTRAINT fk_plant_person_person FOREIGN KEY (ppl_id) 
            REFERENCES camd.person (ppl_id);
ALTER TABLE camd.plant_person
        ADD CONSTRAINT fk_plant_person_plant FOREIGN KEY (fac_id) 
            REFERENCES camd.plant (fac_id);
ALTER TABLE camd.plant_person
        ADD CONSTRAINT fk_plant_person_program FOREIGN KEY (prg_cd) 
            REFERENCES camdmd.program_code (prg_cd);
ALTER TABLE camd.plant_person
        ADD CONSTRAINT fk_plant_person_responsib FOREIGN KEY (responsibility_id) 
            REFERENCES camdmd.responsibility (responsibility_id);

CREATE INDEX IF NOT EXISTS idx_plant_person_lk 
  ON camd.plant_person (<td>);
CREATE INDEX IF NOT EXISTS idx_plant_person_person 
  ON camd.plant_person (ppl_id);
CREATE INDEX IF NOT EXISTS idx_plant_person_plant 
  ON camd.plant_person (fac_id);
CREATE INDEX IF NOT EXISTS idx_plant_person_pp_end_date 
  ON camd.plant_person (fac_id,ppl_id,end_date);
CREATE INDEX IF NOT EXISTS idx_plant_person_program 
  ON camd.plant_person (prg_cd);
CREATE INDEX IF NOT EXISTS idx_plant_person_responsib 
  ON camd.plant_person (responsibility_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_plant_person 
  ON camd.plant_person (fac_ppl_id);