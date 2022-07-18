-- Table: camdecmpsmd.sod_volumetric_code

-- DROP TABLE IF EXISTS camdecmpsmd.sod_volumetric_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.sod_volumetric_code
(
    sod_volumetric_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    sod_volumetric_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_sod_volumetric_code PRIMARY KEY (sod_volumetric_cd)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS camdecmpsmd.sod_volumetric_code
    OWNER to "uImcwuf4K9dyaxeL";

COMMENT ON TABLE camdecmpsmd.sod_volumetric_code
    IS 'Lookup table of source of volumetric flow rate codes.';

COMMENT ON COLUMN camdecmpsmd.sod_volumetric_code.sod_volumetric_cd
    IS 'Code used to identify the source of volumetric flow rate. ';

COMMENT ON COLUMN camdecmpsmd.sod_volumetric_code.sod_volumetric_cd_description
    IS 'Description of lookup code. ';