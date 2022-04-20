-- Table: camdecmpsmd.calibration_standard_code

-- DROP TABLE camdecmpsmd.calibration_standard_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.calibration_standard_code
(
    cal_standard_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    cal_standard_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_calibration_standard_code PRIMARY KEY (cal_standard_cd)
);

COMMENT ON TABLE camdecmpsmd.calibration_standard_code
    IS 'Lookup table for calibration standard code.';

COMMENT ON COLUMN camdecmpsmd.calibration_standard_code.cal_standard_cd
    IS 'Code used to identify the calibration standard.';

COMMENT ON COLUMN camdecmpsmd.calibration_standard_code.cal_standard_cd_description
    IS 'Description of calibration standard code.';