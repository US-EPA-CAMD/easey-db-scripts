CREATE TABLE IF NOT EXISTS camdmd.prime_mover_type_code
(
    prime_mover_type_cd varchar(7) NOT NULL,
    prime_mover_type_description varchar(1000) NOT NULL,
    PRIMARY KEY (prime_mover_type_cd)
);
COMMENT ON TABLE camdmd.prime_mover_type_code
    IS 'Lookup table containing the generator type list and descriptions.';
COMMENT ON COLUMN camdmd.prime_mover_type_code.prime_mover_type_cd
    IS 'Type of a generator, such as combined cycle, steam turbine, etc.';
COMMENT ON COLUMN camdmd.prime_mover_type_code.prime_mover_type_description
    IS 'Full description of prime mover type.';