CREATE TABLE IF NOT EXISTS camdmd.authority_type_code
(
    authority_type_cd varchar(7) NOT NULL,
    authority_type_description varchar(1000) NOT NULL,
    PRIMARY KEY (authority_type_cd)
);
COMMENT ON TABLE camdmd.authority_type_code
    IS 'Lookup table for authority type cd.';
COMMENT ON COLUMN camdmd.authority_type_code.authority_type_cd
    IS 'Indicates if the authority is tracked by year.';
COMMENT ON COLUMN camdmd.authority_type_code.authority_type_description
    IS 'Full description of the authority type.';