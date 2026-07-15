CREATE TABLE IF NOT EXISTS camdmd.county_code
(
    county_cd varchar(8) NOT NULL,
    county_number varchar(3) NOT NULL,
    county_name varchar(45) NOT NULL,
    state_cd varchar(2) NOT NULL,
    PRIMARY KEY (county_cd)
);
COMMENT ON TABLE camdmd.county_code
    IS 'Look up table for county codes.';
COMMENT ON COLUMN camdmd.county_code.county_cd
    IS 'Concatenation of State and county number.';
COMMENT ON COLUMN camdmd.county_code.county_number
    IS 'The FIPS county code/number for the county in which the facility is located.';
COMMENT ON COLUMN camdmd.county_code.county_name
    IS 'Full description of county code.';
COMMENT ON COLUMN camdmd.county_code.state_cd
    IS 'State abbreviation for state in which FACILITY, CONTACT, AGENCY, ACCOUNT REQUEST, PROGRAM, or STAFF is located.';