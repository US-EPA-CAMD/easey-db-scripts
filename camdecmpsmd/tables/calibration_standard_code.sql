CREATE TABLE IF NOT EXISTS camdecmpsmd.calibration_standard_code
(
    cal_standard_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    cal_standard_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.calibration_standard_code
    IS 'Lookup table for calibration standard code.';

COMMENT ON COLUMN camdecmpsmd.calibration_standard_code.cal_standard_cd
    IS 'Code used to identify the calibration standard.';

COMMENT ON COLUMN camdecmpsmd.calibration_standard_code.cal_standard_cd_description
    IS 'Description of calibration standard code.';