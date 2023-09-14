CREATE TABLE IF NOT EXISTS camdecmpsmd.rata_frequency_code
(
    rata_frequency_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    rata_frequency_cd_description character varying(1000) COLLATE pg_catalog."default"
);

COMMENT ON TABLE camdecmpsmd.rata_frequency_code
    IS 'Lookup table that indicates whether the RATA requires a test in two or four quarters.';

COMMENT ON COLUMN camdecmpsmd.rata_frequency_code.rata_frequency_cd
    IS 'Code used to identify RATA frequency. ';

COMMENT ON COLUMN camdecmpsmd.rata_frequency_code.rata_frequency_cd_description
    IS 'Description of RATA frequency code. ';