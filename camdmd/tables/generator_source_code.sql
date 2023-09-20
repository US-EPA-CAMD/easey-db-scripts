CREATE TABLE IF NOT EXISTS camdmd.generator_source_code
(
    gen_source_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    gen_source_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdmd.generator_source_code
    IS 'Lookup table that identifies the source of generator data.';

COMMENT ON COLUMN camdmd.generator_source_code.gen_source_cd
    IS 'Source of generator data.';

COMMENT ON COLUMN camdmd.generator_source_code.gen_source_description
    IS 'Full description of source of generator data.';
