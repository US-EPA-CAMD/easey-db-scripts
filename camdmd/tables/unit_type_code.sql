CREATE TABLE IF NOT EXISTS camdmd.unit_type_code
(
    unit_type_cd varchar(7) NOT NULL,
    unit_type_description varchar(1000) NOT NULL,
    sort_order numeric(1,0),
    PRIMARY KEY (unit_type_cd)
);
COMMENT ON TABLE camdmd.unit_type_code
    IS 'Lookup table of boiler types';
COMMENT ON COLUMN camdmd.unit_type_code.unit_type_cd
    IS 'The type of UNIT or boiler.';
COMMENT ON COLUMN camdmd.unit_type_code.unit_type_description
    IS 'Description of UNIT TYPE.';
COMMENT ON COLUMN camdmd.unit_type_code.sort_order
    IS 'Sort order of list.';