-- View: camdecmpsmd.vw_check_catalog_plugin

DROP VIEW IF EXISTS camdecmpsmd.vw_check_catalog_plugin;

CREATE OR REPLACE VIEW camdecmpsmd.vw_check_catalog_plugin
 AS
 SELECT ccp.check_catalog_plugin_id,
    ccp.check_catalog_id,
    cc.check_type_cd,
    cc.check_number,
    cc.check_name,
    ccp.plugin_name,
    ccp.plugin_type_cd,
    ptc.plugin_type_cd_description,
    ccp.check_param_id,
    cpc.display_name AS check_param_id_display_name,
    cpc.check_param_id_name,
    ccp.field_name
   FROM camdecmpsmd.check_catalog_plugin ccp
     JOIN camdecmpsmd.check_catalog cc ON ccp.check_catalog_id::numeric = cc.check_catalog_id
     LEFT JOIN camdecmpsmd.check_parameter_code cpc ON ccp.check_param_id = cpc.check_param_id
     LEFT JOIN camdecmpsmd.plugin_type_code ptc ON ccp.plugin_type_cd::text = ptc.plugin_type_cd::text;
