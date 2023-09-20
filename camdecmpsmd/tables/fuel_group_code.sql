CREATE TABLE IF NOT EXISTS camdecmpsmd.fuel_group_code
(
    fuel_group_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    fuel_group_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.fuel_group_code
    IS 'Lookup table containing the groups of fuels to which the unit fuel codes correspond.  Example: PRG is the parent fuel code for Digester Gas, Coke Oven Gas and Refiner Gas.';

COMMENT ON COLUMN camdecmpsmd.fuel_group_code.fuel_group_cd
    IS 'Identifies the group in which the fuel is cataloged.';

COMMENT ON COLUMN camdecmpsmd.fuel_group_code.fuel_group_description
    IS 'Full description of the fuel group.';