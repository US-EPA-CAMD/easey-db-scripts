CREATE TABLE IF NOT EXISTS camdecmpsmd.accuracy_test_method_code
(
    acc_test_method_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    acc_test_method_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);


COMMENT ON TABLE camdecmpsmd.accuracy_test_method_code
    IS 'Lookup table for accuracy test method code.';

COMMENT ON COLUMN camdecmpsmd.accuracy_test_method_code.acc_test_method_cd
    IS 'Code used to indicate fuel flowmeter accuracy test method. ';

COMMENT ON COLUMN camdecmpsmd.accuracy_test_method_code.acc_test_method_cd_description
    IS 'Description of lookup code. ';