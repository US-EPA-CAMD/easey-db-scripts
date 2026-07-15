CREATE TABLE IF NOT EXISTS camdmd.agency_type_code
(
    agency_type_cd varchar(7) NOT NULL,
    agency_type_description varchar(1000) NOT NULL,
    PRIMARY KEY (agency_type_cd)
);
COMMENT ON TABLE camdmd.agency_type_code
    IS 'Lookup table containing codes that indicates the agency type for agencies.';
COMMENT ON COLUMN camdmd.agency_type_code.agency_type_cd
    IS 'The code that indicates the agency type for agencies.';
COMMENT ON COLUMN camdmd.agency_type_code.agency_type_description
    IS 'The description of the agency type.';