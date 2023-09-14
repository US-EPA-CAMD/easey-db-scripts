CREATE TABLE IF NOT EXISTS camdecmpsmd.test_result_code
(
    test_result_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    test_result_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.test_result_code
    IS 'Lookup table of test result codes.';

COMMENT ON COLUMN camdecmpsmd.test_result_code.test_result_cd
    IS 'Code used to identify reported test result. ';

COMMENT ON COLUMN camdecmpsmd.test_result_code.test_result_cd_description
    IS 'Description of test result code. ';