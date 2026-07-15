CREATE TABLE IF NOT EXISTS camdmd.state_code
(
    state_cd varchar(2) NOT NULL,
    state_name varchar(20) NOT NULL,
    domestic_ind numeric(1,0) NOT NULL DEFAULT 0,
    indian_country_ind numeric(1,0) NOT NULL DEFAULT 0,
    epa_region numeric(2,0),
    PRIMARY KEY (state_cd)
);
COMMENT ON TABLE camdmd.state_code
    IS 'List of state abbreviations and their EPA region.';
COMMENT ON COLUMN camdmd.state_code.state_cd
    IS 'Abbreviation for the state.';
COMMENT ON COLUMN camdmd.state_code.state_name
    IS 'Full name of the state.';
COMMENT ON COLUMN camdmd.state_code.domestic_ind
    IS 'Indicator that state is in the continental U.S.';
COMMENT ON COLUMN camdmd.state_code.indian_country_ind
    IS 'Indicator that state has Indian Country land.';
COMMENT ON COLUMN camdmd.state_code.epa_region
    IS 'EPA Region in which the state is located.';