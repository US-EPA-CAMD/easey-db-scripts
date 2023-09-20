ALTER TABLE IF EXISTS camd.generator
    ADD CONSTRAINT pk_generator PRIMARY KEY (gen_id),
    ADD CONSTRAINT uq_generator UNIQUE (fac_id, genid),
    ADD CONSTRAINT fk_generator_generator_source_code FOREIGN KEY (gen_source_cd)
        REFERENCES camdmd.generator_source_code (gen_source_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_generator_plant FOREIGN KEY (fac_id)
        REFERENCES camd.plant (fac_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_generator_prime_mover_type_code FOREIGN KEY (prime_mover_type_cd)
        REFERENCES camdmd.prime_mover_type_code (prime_mover_type_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_generator_fac_id
    ON camd.generator USING btree
    (fac_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_generator_genid
    ON camd.generator USING btree
    (genid COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_generator_gen_source_cd
    ON camd.generator USING btree
    (gen_source_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_generator_prime_mover_type_cd
    ON camd.generator USING btree
    (prime_mover_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);
