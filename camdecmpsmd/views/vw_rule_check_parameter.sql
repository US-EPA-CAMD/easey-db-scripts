-- View: camdecmpsmd.vw_rule_check_parameter

DROP VIEW IF EXISTS camdecmpswks.vw_rule_check_parameter;
DROP VIEW IF EXISTS camdecmpsmd.vw_rule_check_parameter;

CREATE OR REPLACE VIEW camdecmpsmd.vw_rule_check_parameter
 AS
 SELECT ccp.check_catalog_param_id,
    ccp.check_catalog_id,
    rc.rule_check_id,
    ccp.check_param_id,
    ccp.check_param_usage_cd,
    cpuc.check_param_usage_cd_name,
    rc.category_cd,
    cpc.check_param_id_name,
    cpc.check_data_type_cd,
    cc.check_type_cd,
    cc.check_number,
    cat.process_cd,
    cc.run_check_flg
   FROM camdecmpsmd.check_catalog cc
     JOIN camdecmpsmd.check_catalog_parameter ccp ON cc.check_catalog_id = ccp.check_catalog_id::numeric
     JOIN camdecmpsmd.rule_check rc ON cc.check_catalog_id = rc.check_catalog_id
     JOIN camdecmpsmd.check_parameter_code cpc ON ccp.check_param_id = cpc.check_param_id
     JOIN camdecmpsmd.category_code cat ON rc.category_cd::text = cat.category_cd::text
     JOIN camdecmpsmd.check_parameter_usage_code cpuc ON ccp.check_param_usage_cd::text = cpuc.check_param_usage_cd::text
     LEFT JOIN camdecmpsmd.check_status_code csc ON cc.check_status_cd::text = csc.check_status_cd::text;
