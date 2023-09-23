-- View: camdecmpsmd.vw_cross_check_catalog_value

DROP VIEW IF EXISTS camdecmpsmd.vw_cross_check_catalog_value CASCADE;

CREATE OR REPLACE VIEW camdecmpsmd.vw_cross_check_catalog_value
 AS
 SELECT cccv.cross_chk_catalog_value_id,
    cccv.cross_chk_catalog_id,
    ccc.cross_chk_catalog_name,
    cccv.value1,
    cccv.value2,
    cccv.value3
   FROM camdecmpsmd.cross_check_catalog_value cccv
     LEFT JOIN camdecmpsmd.cross_check_catalog ccc ON cccv.cross_chk_catalog_id = ccc.cross_chk_catalog_id;
