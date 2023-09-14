CREATE TABLE IF NOT EXISTS camdecmpsmd.sod_mass_code
(
    sod_mass_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    sod_mass_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.sod_mass_code
    IS 'Lookup table of source of mass flow rate codes.';

COMMENT ON COLUMN camdecmpsmd.sod_mass_code.sod_mass_cd
    IS 'Code used to identify the source of mass flow rate. ';

COMMENT ON COLUMN camdecmpsmd.sod_mass_code.sod_mass_cd_description
    IS 'Description of lookup code. ';