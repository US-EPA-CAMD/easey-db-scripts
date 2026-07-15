CREATE TABLE IF NOT EXISTS camdmd.tribal_land_code
(
    tribal_land_cd varchar(7) NOT NULL,
    tribal_land_description varchar(1000) NOT NULL,
    PRIMARY KEY (tribal_land_cd)
);
COMMENT ON TABLE camdmd.tribal_land_code
    IS 'Lookup table containing codes for tribal lands.';
COMMENT ON COLUMN camdmd.tribal_land_code.tribal_land_cd
    IS 'The code that indicates the tribal land.';
COMMENT ON COLUMN camdmd.tribal_land_code.tribal_land_description
    IS 'The description of the tribal land.';