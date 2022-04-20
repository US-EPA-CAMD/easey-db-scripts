-- Table: camdmd.nonstandard_code

-- DROP TABLE camdmd.nonstandard_code;

CREATE TABLE camdmd.nonstandard_code
(
    nonstandard_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    nonstandard_description character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT pk_nonstandard_code PRIMARY KEY (nonstandard_cd),
    CONSTRAINT uq_nonstandard_desc UNIQUE (nonstandard_description)
);

COMMENT ON TABLE camdmd.nonstandard_code
    IS 'Lookup code values for nonstandard unit program situations.';

COMMENT ON COLUMN camdmd.nonstandard_code.nonstandard_cd
    IS 'Code used to identify type of nonstandard unit program situation.';

COMMENT ON COLUMN camdmd.nonstandard_code.nonstandard_description
    IS 'Description of code for nonstandard unit program situation.';