-- View: camdecmpsmd.vw_control_code

DROP VIEW IF EXISTS camdecmpsmd.vw_control_code;

CREATE OR REPLACE VIEW camdecmpsmd.vw_control_code
 AS
 SELECT cccv.value2 AS control_cd,
    cccv.value1 AS control_equip_param_cd,
    cc.control_description
   FROM camdecmpsmd.cross_check_catalog_value cccv
     JOIN camdecmpsmd.cross_check_catalog USING (cross_chk_catalog_id)
     JOIN camdecmpsmd.control_code cc ON cccv.value2 = cc.control_cd::text
  WHERE cross_check_catalog.cross_chk_catalog_name::text = 'Parameter Code to Control Code for Unit Control'::text
  ORDER BY cccv.value2;
