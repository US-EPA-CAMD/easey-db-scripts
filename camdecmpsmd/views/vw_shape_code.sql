-- View: camdecmpsmd.vw_shape_code

-- DROP VIEW camdecmpsmd.vw_shape_code;

CREATE OR REPLACE VIEW camdecmpsmd.vw_shape_code
 AS
 SELECT shape_code.shape_cd,
    shape_code.shape_cd_description
   FROM camdecmpsmd.shape_code;