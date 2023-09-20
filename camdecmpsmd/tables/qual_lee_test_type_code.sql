CREATE TABLE IF NOT EXISTS camdecmpsmd.qual_lee_test_type_code
(
    qual_lee_test_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    qual_lee_test_type_description character varying(1000) COLLATE pg_catalog."default"
);

COMMENT ON TABLE camdecmpsmd.qual_lee_test_type_code
    IS 'Indication of whether the qualifying test was an initial test or retest.';

COMMENT ON COLUMN camdecmpsmd.qual_lee_test_type_code.qual_lee_test_type_cd
    IS 'Indication of whether the qualifying test was an initial test or retest.';

COMMENT ON COLUMN camdecmpsmd.qual_lee_test_type_code.qual_lee_test_type_description
    IS 'Description of the Qualification LEE Test Type code.';