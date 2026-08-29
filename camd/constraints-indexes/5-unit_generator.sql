ALTER TABLE camd.unit_generator
        ADD CONSTRAINT fk_unit_generator_gen_id FOREIGN KEY (gen_id) 
            REFERENCES camd.generator (gen_id);
ALTER TABLE camd.unit_generator
        ADD CONSTRAINT fk_unit_generator_unit_id FOREIGN KEY (unit_id) 
            REFERENCES camd.unit (unit_id);

CREATE UNIQUE INDEX IF NOT EXISTS pk_unit_generator 
  ON camd.unit_generator (unit_gen_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_unit_generator 
  ON camd.unit_generator (unit_id,gen_id,begin_date);