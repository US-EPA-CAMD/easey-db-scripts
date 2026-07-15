ALTER TABLE camd.plant_person_program
        ADD CONSTRAINT fk_pp_prg_plant_person FOREIGN KEY (fac_ppl_id) 
            REFERENCES camd.plant_person (fac_ppl_id);

CREATE INDEX IF NOT EXISTS idx_plant_person_program_lk 
  ON camd.plant_person_program (fac_ppl_id,prg_cd);
CREATE INDEX IF NOT EXISTS idx_plant_person_to_program 
  ON camd.plant_person_program (fac_ppl_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_plant_person_program 
  ON camd.plant_person_program (fac_ppl_prg_id);