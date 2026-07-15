CREATE TABLE IF NOT EXISTS camdmd.source_category_code
(
    source_category_cd varchar(7) NOT NULL,
    source_category_description varchar(1000),
    PRIMARY KEY (source_category_cd)
);
COMMENT ON TABLE camdmd.source_category_code
    IS 'General description of UNIT.';
COMMENT ON COLUMN camdmd.source_category_code.source_category_cd
    IS 'Abbreviation for general description of UNIT type.';
COMMENT ON COLUMN camdmd.source_category_code.source_category_description
    IS 'Description for UNIT types.';