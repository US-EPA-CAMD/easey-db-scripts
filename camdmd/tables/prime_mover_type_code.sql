CREATE TABLE IF NOT EXISTS camdmd.prime_mover_type_code
(
    prime_mover_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    prime_mover_type_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdmd.prime_mover_type_code
    IS 'Lookup table containing the generator type list and descriptions.';

COMMENT ON COLUMN camdmd.prime_mover_type_code.prime_mover_type_cd
    IS 'Type of a generator, such as combined cycle, steam turbine, etc.';

COMMENT ON COLUMN camdmd.prime_mover_type_code.prime_mover_type_description
    IS 'Full description of prime mover type.';
