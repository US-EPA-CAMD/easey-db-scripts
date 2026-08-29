CREATE TABLE IF NOT EXISTS camdmd.generator_source_code
(
    gen_source_cd varchar(7) NOT NULL,
    gen_source_description varchar(1000) NOT NULL,
    PRIMARY KEY (gen_source_cd)
);
COMMENT ON TABLE camdmd.generator_source_code
    IS 'Lookup table that identifies the source of generator data.';
COMMENT ON COLUMN camdmd.generator_source_code.gen_source_cd
    IS 'Source of generator data.';
COMMENT ON COLUMN camdmd.generator_source_code.gen_source_description
    IS 'Full description of source of generator data.';