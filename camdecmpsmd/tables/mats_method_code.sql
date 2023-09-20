CREATE TABLE IF NOT EXISTS camdecmpsmd.mats_method_code
(
    mats_method_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    mats_method_description character varying(1000) COLLATE pg_catalog."default"
);

COMMENT ON TABLE camdecmpsmd.mats_method_code
    IS 'Lookup table of MATS compliance methods.';

COMMENT ON COLUMN camdecmpsmd.mats_method_code.mats_method_cd
    IS 'Code used to identify the MATS compliance methodology.';

COMMENT ON COLUMN camdecmpsmd.mats_method_code.mats_method_description
    IS 'Description of the MATS compliance method code.';