CREATE TABLE IF NOT EXISTS camdecmpsmd.submission_availability_code
(
    submission_availability_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    sub_avail_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.submission_availability_code
    IS 'Lookup table for submission availability code.';

COMMENT ON COLUMN camdecmpsmd.submission_availability_code.submission_availability_cd
    IS 'Unique code value for a lookup table.';

COMMENT ON COLUMN camdecmpsmd.submission_availability_code.sub_avail_cd_description
    IS 'Description of lookup code.';