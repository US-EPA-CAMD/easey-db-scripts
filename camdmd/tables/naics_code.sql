CREATE TABLE IF NOT EXISTS camdmd.naics_code
(
    naics_cd numeric(6,0) NOT NULL,
    naics_description character varying(1000) COLLATE pg_catalog."default"
);

COMMENT ON TABLE camdmd.naics_code
    IS 'North American Industry Classification System code.  Provides information about the economic sector and specific industry, on a facility level.';

COMMENT ON COLUMN camdmd.naics_code.naics_cd
    IS 'North American Industry Classification System code.  Provides information about the economic sector and specific industry, on a facility level.';

COMMENT ON COLUMN camdmd.naics_code.naics_description
    IS 'Description of NAICS code.';
