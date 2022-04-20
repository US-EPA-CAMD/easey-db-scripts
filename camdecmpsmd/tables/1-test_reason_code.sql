-- Table: camdecmpsmd.test_reason_code

-- DROP TABLE camdecmpsmd.test_reason_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.test_reason_code
(
    test_reason_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    test_reason_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_test_reason_code PRIMARY KEY (test_reason_cd)
);

COMMENT ON TABLE camdecmpsmd.test_reason_code
    IS 'Lookup table for reasons for tests.';

COMMENT ON COLUMN camdecmpsmd.test_reason_code.test_reason_cd
    IS 'Code used to identify test reason. ';

COMMENT ON COLUMN camdecmpsmd.test_reason_code.test_reason_cd_description
    IS 'Description of a test reason code. ';