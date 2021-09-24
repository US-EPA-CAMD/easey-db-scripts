-- View: camdecmpsmd.vw_waf_method_code

-- DROP VIEW camdecmpsmd.vw_waf_method_code;

CREATE OR REPLACE VIEW camdecmpsmd.vw_waf_method_code
 AS
 SELECT waf_method_code.waf_method_cd,
    waf_method_code.waf_method_cd_description
   FROM camdecmpsmd.waf_method_code;
