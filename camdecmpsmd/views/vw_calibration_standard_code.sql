-- View: camdecmpsmd.vw_calibration_standard_code

-- DROP VIEW camdecmpsmd.vw_calibration_standard_code;

CREATE OR REPLACE VIEW camdecmpsmd.vw_calibration_standard_code
 AS
 SELECT calibration_standard_code.cal_standard_cd,
    calibration_standard_code.cal_standard_cd_description
   FROM camdecmpsmd.calibration_standard_code;
