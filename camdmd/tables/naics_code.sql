CREATE TABLE IF NOT EXISTS camdmd.naics_code
(
    naics_cd numeric(6,0) NOT NULL,
    naics_description varchar(1000),
    PRIMARY KEY (naics_cd)
);
COMMENT ON COLUMN camdmd.naics_code.naics_description
    IS 'Description of NAICS code.';