CREATE TABLE IF NOT EXISTS camdmd.source_category_code
(
    source_category_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    source_category_description character varying(1000) COLLATE pg_catalog."default"
);

COMMENT ON TABLE camdmd.source_category_code
    IS 'General description of UNIT.';

COMMENT ON COLUMN camdmd.source_category_code.source_category_cd
    IS 'Abbreviation for general description of UNIT type.';

COMMENT ON COLUMN camdmd.source_category_code.source_category_description
    IS 'Description for UNIT types.';
