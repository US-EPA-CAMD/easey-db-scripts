CREATE TABLE IF NOT EXISTS camdecmpsmd.basis_code
(
    basis_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    basis_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    basis_category character varying(10) COLLATE pg_catalog."default"
);

COMMENT ON TABLE camdecmpsmd.basis_code
    IS 'Lookup table of type of measurement with respect to moisture.';

COMMENT ON COLUMN camdecmpsmd.basis_code.basis_cd
    IS 'Code used to identify whether or not moisture was included in the measurement of concentration. ';

COMMENT ON COLUMN camdecmpsmd.basis_code.basis_cd_description
    IS 'Description of lookup code. ';

COMMENT ON COLUMN camdecmpsmd.basis_code.basis_category
    IS 'The moisture basis of monitor measurement. ';