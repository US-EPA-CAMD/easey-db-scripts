CREATE TABLE IF NOT EXISTS camdecmpsmd.test_basis_code
(
    test_basis_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    test_basis_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.test_basis_code
    IS 'Lookup table for test basis code.';

COMMENT ON COLUMN camdecmpsmd.test_basis_code.test_basis_cd
    IS 'Unique code value for a lookup table.';

COMMENT ON COLUMN camdecmpsmd.test_basis_code.test_basis_description
    IS 'Description of lookup code.';