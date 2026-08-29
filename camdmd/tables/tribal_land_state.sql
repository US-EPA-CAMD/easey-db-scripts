CREATE TABLE IF NOT EXISTS camdmd.tribal_land_state
(
    tribal_land_cd varchar(7) NOT NULL,
    state_cd varchar(7) NOT NULL,
    PRIMARY KEY (tribal_land_cd, state_cd)
);
COMMENT ON TABLE camdmd.tribal_land_state
    IS 'Lookup table containing valid combinations for tribal land and state.';
COMMENT ON COLUMN camdmd.tribal_land_state.tribal_land_cd
    IS 'The code that indicates the tribal land.';
COMMENT ON COLUMN camdmd.tribal_land_state.state_cd
    IS 'Abbreviation for the state.';