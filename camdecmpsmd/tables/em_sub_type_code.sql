CREATE TABLE IF NOT EXISTS camdecmpsmd.em_sub_type_code
(
    em_sub_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    em_sub_type_cd_description character varying(1000) COLLATE pg_catalog."default"
);

COMMENT ON TABLE camdecmpsmd.em_sub_type_code
    IS 'Lookup table for emission submission type codes.';

COMMENT ON COLUMN camdecmpsmd.em_sub_type_code.em_sub_type_cd
    IS ' Code used to identify the emission submission type code.';

COMMENT ON COLUMN camdecmpsmd.em_sub_type_code.em_sub_type_cd_description
    IS ' Description of lookup code.';