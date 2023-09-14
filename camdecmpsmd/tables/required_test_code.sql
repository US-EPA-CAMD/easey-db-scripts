CREATE TABLE IF NOT EXISTS camdecmpsmd.required_test_code
(
    required_test_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    required_test_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.required_test_code
    IS 'Required test for an event.';

COMMENT ON COLUMN camdecmpsmd.required_test_code.required_test_cd
    IS 'Code used to identify the test(s) required due to the event. ';

COMMENT ON COLUMN camdecmpsmd.required_test_code.required_test_cd_description
    IS 'Description of lookup code. ';