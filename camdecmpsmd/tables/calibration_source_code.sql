CREATE TABLE IF NOT EXISTS camdecmpsmd.calibration_source_code
(
    cal_source_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    cal_source_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.calibration_source_code
    IS 'Lookup table for calibration source code.';

COMMENT ON COLUMN camdecmpsmd.calibration_source_code.cal_source_cd
    IS 'Code used to identify the calibration source.';

COMMENT ON COLUMN camdecmpsmd.calibration_source_code.cal_source_cd_description
    IS 'Description of calibration source code.';