ALTER TABLE camd.annual_generator
        ADD CONSTRAINT fk_ann_gen FOREIGN KEY (gen_id) 
            REFERENCES camd.generator (gen_id);

CREATE UNIQUE INDEX IF NOT EXISTS pk_anngen 
  ON camd.annual_generator (gen_id,eia_yr);