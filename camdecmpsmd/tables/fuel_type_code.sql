CREATE TABLE IF NOT EXISTS camdecmpsmd.fuel_type_code
(
    fuel_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    fuel_type_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    fuel_group_cd character varying(7) COLLATE pg_catalog."default"
);

COMMENT ON TABLE camdecmpsmd.fuel_type_code
    IS 'Lookup table containing codes for the fuels used by units.';

COMMENT ON COLUMN camdecmpsmd.fuel_type_code.fuel_type_cd
    IS 'The type of fuel which a UNIT is capable or will be capable of combusting.';

COMMENT ON COLUMN camdecmpsmd.fuel_type_code.fuel_type_description
    IS 'Full description of fuel type.';

COMMENT ON COLUMN camdecmpsmd.fuel_type_code.fuel_group_cd
    IS 'Identifies the category of fuel (e.g., gas, oil or other).';
