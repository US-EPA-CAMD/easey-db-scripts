-- View: camdecmpsmd.vw_control_code

DROP VIEW IF EXISTS camdecmpsmd.vw_control_code;

CREATE OR REPLACE VIEW camdecmpsmd.vw_control_code
 AS
 SELECT	value2 AS control_cd,
 	value1 AS control_equip_param_cd,
	cc.control_description
	FROM camdecmpsmd.cross_check_catalog_value cccv
	JOIN camdecmpsmd.cross_check_catalog USING (cross_chk_catalog_id)
	JOIN camdecmpsmd.control_code cc ON cccv.value2 = cc.control_cd
	WHERE cross_chk_catalog_name = 'Parameter Code to Control Code for Unit Control'
	ORDER BY value2;
