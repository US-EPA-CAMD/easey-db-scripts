ALTER TABLE IF EXISTS camdecmpsmd.calibration_source_code
    ADD CONSTRAINT pk_calibration_source_code PRIMARY KEY (cal_source_cd),
    ADD CONSTRAINT uq_calibration_source_code_description UNIQUE (cal_source_cd_description);
