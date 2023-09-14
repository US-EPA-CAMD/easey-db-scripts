CREATE TABLE IF NOT EXISTS camdecmpsmd.test_type_code
(
    test_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    test_type_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.test_type_code
    IS 'Lookup table of test types.  Include the new DAHS verification completion date test.';

COMMENT ON COLUMN camdecmpsmd.test_type_code.test_type_cd
    IS 'Code used to identify test type. ';

COMMENT ON COLUMN camdecmpsmd.test_type_code.test_type_cd_description
    IS 'Description of a test type code. ';