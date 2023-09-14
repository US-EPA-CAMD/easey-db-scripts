CREATE TABLE IF NOT EXISTS camdecmpsmd.fuel_code
(
    fuel_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    fuel_group_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    unit_fuel_cd character varying(7) COLLATE pg_catalog."default",
    fuel_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.fuel_code
    IS 'Lookup table of fuel types.';

COMMENT ON COLUMN camdecmpsmd.fuel_code.fuel_cd
    IS 'Code used to identify the type of fuel. ';

COMMENT ON COLUMN camdecmpsmd.fuel_code.fuel_group_cd
    IS 'Identifies the group that the fuel is cataloged in. ';

COMMENT ON COLUMN camdecmpsmd.fuel_code.unit_fuel_cd
    IS 'Each fuel corresponds to a unit fuel code.  The unit fuel code is a subset and/or grouping of the fuel code values that are applicable to unit fuels. ';

COMMENT ON COLUMN camdecmpsmd.fuel_code.fuel_cd_description
    IS 'Description of lookup code. ';
