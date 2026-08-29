CREATE TABLE IF NOT EXISTS camdmd.nonstandard_code
(
    nonstandard_cd varchar(7) NOT NULL,
    nonstandard_description varchar(1000),
    PRIMARY KEY (nonstandard_cd)
);
COMMENT ON TABLE camdmd.nonstandard_code
    IS 'Lookup code values for nonstandard unit program situations.';
COMMENT ON COLUMN camdmd.nonstandard_code.nonstandard_cd
    IS 'Code used to identify type of nonstandard unit program situation.';
COMMENT ON COLUMN camdmd.nonstandard_code.nonstandard_description
    IS 'Description of code for nonstandard unit program situation.';