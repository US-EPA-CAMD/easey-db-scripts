ALTER TABLE IF EXISTS camdmd.prime_mover_type_code
    ADD CONSTRAINT pk_prime_mover_type_code PRIMARY KEY (prime_mover_type_cd),
    ADD CONSTRAINT uq_prime_mover_type_code_description UNIQUE (prime_mover_type_description);

