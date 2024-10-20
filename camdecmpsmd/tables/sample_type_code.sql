CREATE TABLE IF NOT EXISTS camdecmpsmd.sample_type_code
(
    sample_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    sample_type_cd_description character varying(1000) COLLATE pg_catalog."default"
);

COMMENT ON TABLE camdecmpsmd.sample_type_code
    IS 'Lookup table for sample type codes.';

COMMENT ON COLUMN camdecmpsmd.sample_type_code.sample_type_cd
    IS 'Code used to identify the sample type. ';

COMMENT ON COLUMN camdecmpsmd.sample_type_code.sample_type_cd_description
    IS 'Description of lookup code. ';