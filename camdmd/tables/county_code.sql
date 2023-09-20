CREATE TABLE IF NOT EXISTS camdmd.county_code
(
    county_cd character varying(8) COLLATE pg_catalog."default" NOT NULL,
    county_number character varying(3) COLLATE pg_catalog."default" NOT NULL,
    county_name character varying(45) COLLATE pg_catalog."default" NOT NULL,
    state_cd character varying(2) COLLATE pg_catalog."default" NOT NULL
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
