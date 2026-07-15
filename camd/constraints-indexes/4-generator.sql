ALTER TABLE camd.generator
        ADD CONSTRAINT fk_generator_gen_source_cd FOREIGN KEY (gen_source_cd) 
            REFERENCES camdmd.generator_source_code (gen_source_cd);
ALTER TABLE camd.generator
        ADD CONSTRAINT fk_generator_plant FOREIGN KEY (fac_id) 
            REFERENCES camd.plant (fac_id);
ALTER TABLE camd.generator
        ADD CONSTRAINT fk_generator_prime_mover_cd FOREIGN KEY (prime_mover_type_cd) 
            REFERENCES camdmd.prime_mover_type_code (prime_mover_type_cd);

CREATE UNIQUE INDEX IF NOT EXISTS pk_generator 
  ON camd.generator (gen_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_generator 
  ON camd.generator (fac_id,genid);