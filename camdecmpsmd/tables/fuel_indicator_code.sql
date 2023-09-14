CREATE TABLE IF NOT EXISTS camdecmpsmd.fuel_indicator_code
(
    fuel_indicator_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    fuel_indicator_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.fuel_indicator_code
    IS 'Lookup table containing the fuel indicator codes.';

COMMENT ON COLUMN camdecmpsmd.fuel_indicator_code.fuel_indicator_cd
    IS 'Unique code for the fuel indicator.';

COMMENT ON COLUMN camdecmpsmd.fuel_indicator_code.fuel_indicator_description
    IS 'Full description of the indicator code.';