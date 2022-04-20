-- View: camdecmpsmd.vw_unitcontrol_master_data_relationships

-- DROP VIEW camdecmpsmd.vw_unitcontrol_master_data_relationships;

CREATE OR REPLACE VIEW camdecmpsmd.vw_unitcontrol_master_data_relationships
 AS
 SELECT unit_control.controlequipparamcode,
    control_code.control_code
   FROM ( SELECT param.value1 AS controlequipparamcode
           FROM camdecmpsmd.vw_cross_check_catalog_value param
          WHERE param.cross_chk_catalog_name::text = 'Parameter to Category'::text AND param.value2 = 'UNITCONTROL'::text) unit_control
     LEFT JOIN ( SELECT DISTINCT vw_cross_check_catalog_value.value1 AS controlequipparamcode,
            vw_cross_check_catalog_value.value2 AS control_code
           FROM camdecmpsmd.vw_cross_check_catalog_value
          WHERE vw_cross_check_catalog_value.cross_chk_catalog_name::text = 'Parameter Code to Control Code for Unit Control'::text) control_code ON unit_control.controlequipparamcode = control_code.controlequipparamcode;
