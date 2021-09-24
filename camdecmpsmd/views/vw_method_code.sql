-- View: camdecmpsmd.vw_method_code

-- DROP VIEW camdecmpsmd.vw_method_code;

CREATE OR REPLACE VIEW camdecmpsmd.vw_method_code
 AS
 SELECT method_code.method_cd,
    method_code.method_cd_description
   FROM camdecmpsmd.method_code;
