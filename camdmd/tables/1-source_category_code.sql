-- Table: camdmd.source_category_code

-- DROP TABLE camdmd.source_category_code;

CREATE TABLE IF NOT EXISTS camdmd.source_category_code
(
    source_category_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    source_category_description character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT pk_source_category_code PRIMARY KEY (source_category_cd),
    CONSTRAINT uq_source_category_desc UNIQUE (source_category_description)
);

COMMENT ON TABLE camdmd.source_category_code
    IS 'General description of UNIT.';

COMMENT ON COLUMN camdmd.source_category_code.source_category_cd
    IS 'Abbreviation for general description of UNIT type.';

COMMENT ON COLUMN camdmd.source_category_code.source_category_description
    IS 'Description for UNIT types.';