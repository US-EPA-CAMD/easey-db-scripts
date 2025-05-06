CREATE TABLE IF NOT EXISTS camdecmpsmd.mats_pollutant_code (
    mats_pollutant_cd varchar(7) COLLATE pg_catalog."default" NOT NULL,
    mats_pollutant_description varchar(100) COLLATE pg_catalog."default" NOT NULL,
    metadata_pollutant_cd varchar(9) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.mats_pollutant_code IS 'Lookup table of MATS pollutants.';

COMMENT ON COLUMN camdecmpsmd.mats_pollutant_code.mats_pollutant_cd IS 'Pollutant code.';

COMMENT ON COLUMN camdecmpsmd.mats_pollutant_code.mats_pollutant_description IS 'Pollutant description.';

COMMENT ON COLUMN camdecmpsmd.mats_pollutant_code.metadata_pollutant_cd IS 'Pollutant code to use in the metadata XML.';

