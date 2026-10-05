-- View: camdecmpsmd.vw_check_catalog_result

DROP VIEW IF EXISTS camdecmpsmd.vw_check_catalog_result CASCADE;

CREATE OR REPLACE VIEW camdecmpsmd.vw_check_catalog_result
 AS
 SELECT ccr.check_catalog_result_id,
    cc.check_name,
    ccr.check_result,
    ccr.severity_cd,
    sc.severity_cd_description,
    cc.check_number,
    cc.check_type_cd,
    cc.check_catalog_id,
    rc.response_catalog_description,
    ccr.response_catalog_id
   FROM camdecmpsmd.check_catalog_result ccr
     LEFT JOIN camdecmpsmd.response_catalog rc ON ccr.response_catalog_id = rc.response_catalog_id::numeric
     LEFT JOIN camdecmpsmd.severity_code sc ON ccr.severity_cd::text = sc.severity_cd::text
     LEFT JOIN camdecmpsmd.check_catalog cc ON cc.check_catalog_id = ccr.check_catalog_id;

