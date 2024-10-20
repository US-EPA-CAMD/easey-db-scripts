CREATE TABLE IF NOT EXISTS camdecmpsmd.sod_volumetric_code
(
    sod_volumetric_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    sod_volumetric_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.sod_volumetric_code
    IS 'Lookup table of source of volumetric flow rate codes.';

COMMENT ON COLUMN camdecmpsmd.sod_volumetric_code.sod_volumetric_cd
    IS 'Code used to identify the source of volumetric flow rate. ';

COMMENT ON COLUMN camdecmpsmd.sod_volumetric_code.sod_volumetric_cd_description
    IS 'Description of lookup code. ';