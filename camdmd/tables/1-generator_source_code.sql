-- Table: camdmd.generator_source_code

-- DROP TABLE camdmd.generator_source_code;

CREATE TABLE camdmd.generator_source_code
(
    gen_source_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    gen_source_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_generator_source_code PRIMARY KEY (gen_source_cd),
    CONSTRAINT uq_generator_source_code_desc UNIQUE (gen_source_description)
);

COMMENT ON TABLE camdmd.generator_source_code
    IS 'Lookup table that identifies the source of generator data.';

COMMENT ON COLUMN camdmd.generator_source_code.gen_source_cd
    IS 'Source of generator data.';

COMMENT ON COLUMN camdmd.generator_source_code.gen_source_description
    IS 'Full description of source of generator data.';