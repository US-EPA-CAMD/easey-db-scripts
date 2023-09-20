ALTER TABLE IF EXISTS camdecmpsmd.calibration_standard_code
    ADD CONSTRAINT pk_calibration_standard_code PRIMARY KEY (cal_standard_cd),
    ADD CONSTRAINT uq_calibration_standard_code_description UNIQUE (cal_standard_cd_description);
