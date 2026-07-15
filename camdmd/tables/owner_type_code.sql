CREATE TABLE IF NOT EXISTS camdmd.owner_type_code
(
    owner_type_cd varchar(7) NOT NULL,
    owner_type_description varchar(1000),
    PRIMARY KEY (owner_type_cd)
);
COMMENT ON TABLE camdmd.owner_type_code
    IS 'Lookup table of owner types.';
COMMENT ON COLUMN camdmd.owner_type_code.owner_type_cd
    IS 'Indicates type of owner, operator or both.';
COMMENT ON COLUMN camdmd.owner_type_code.owner_type_description
    IS 'Long description of owner type.';