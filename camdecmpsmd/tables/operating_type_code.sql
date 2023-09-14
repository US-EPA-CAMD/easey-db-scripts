CREATE TABLE IF NOT EXISTS camdecmpsmd.operating_type_code
(
    op_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    op_type_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.operating_type_code
    IS 'Lookup table for operating type code (e.g., quarterly operating hours).';

COMMENT ON COLUMN camdecmpsmd.operating_type_code.op_type_cd
    IS 'Code used to identify the operating type. ';

COMMENT ON COLUMN camdecmpsmd.operating_type_code.op_type_cd_description
    IS 'Description of lookup code. ';