-- View: camdecmpsmd.vw_sample_acquisition_method_code

-- DROP VIEW camdecmpsmd.vw_sample_acquisition_method_code;

CREATE OR REPLACE VIEW camdecmpsmd.vw_sample_acquisition_method_code
 AS
 SELECT acquisition_method_code.acq_cd,
    acquisition_method_code.acq_cd_description
   FROM camdecmpsmd.acquisition_method_code;
