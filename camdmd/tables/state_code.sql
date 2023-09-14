CREATE TABLE IF NOT EXISTS camdmd.state_code
(
    state_cd character varying(2) COLLATE pg_catalog."default" NOT NULL,
    state_name character varying(20) COLLATE pg_catalog."default" NOT NULL,
    domestic_ind numeric(1,0) NOT NULL DEFAULT 0,
    indian_country_ind numeric(1,0) NOT NULL DEFAULT 0,
    epa_region numeric(2,0)
);

COMMENT ON TABLE camdmd.state_code
    IS 'List of state abbreviations and their EPA region.';

COMMENT ON COLUMN camdmd.state_code.state_cd
    IS 'Abbreviation for the state.';

COMMENT ON COLUMN camdmd.state_code.state_name
    IS 'Name of the State for which FACILITY, CONTACT, AGENCY, ACCOUNT REQUEST, PROGRAM, or STAFF is located.';

COMMENT ON COLUMN camdmd.state_code.domestic_ind
    IS 'Indicator that state is in the continental U.S.';

COMMENT ON COLUMN camdmd.state_code.indian_country_ind
    IS 'Indicator that state has Indian Country land.';

COMMENT ON COLUMN camdmd.state_code.epa_region
    IS 'EPA Region in which the state is located.';
