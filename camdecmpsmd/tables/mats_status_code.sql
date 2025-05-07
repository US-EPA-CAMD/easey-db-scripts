CREATE TABLE IF NOT EXISTS camdecmpsmd.MATS_STATUS_CODE (
    mats_status_cd varchar(8) COLLATE pg_catalog."default" NOT NULL,
    mats_status_description varchar(100) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.mats_status_code IS 'Lookup table for MATS status codes.';

COMMENT ON COLUMN camdecmpsmd.mats_status_code.mats_status_cd IS 'Status code.';

COMMENT ON COLUMN camdecmpsmd.mats_status_code.mats_status_description IS 'Status description.';

