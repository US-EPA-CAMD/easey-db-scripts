-- View: camdecmpsmd.vw_rule_check_condition

DROP VIEW IF EXISTS camdecmpsmd.vw_rule_check_condition;

CREATE OR REPLACE VIEW camdecmpsmd.vw_rule_check_condition
 AS
 SELECT rcc.rule_check_condition_id,
    rcc.rule_check_id,
    rc.category_cd,
    rcc.and_group_no,
    rcc.check_param_id,
    cpc.check_param_id_name,
    rcc.check_operator_cd,
    coc.check_operator_cd_name,
    rcc.check_condition,
    rcc.negation_ind,
    cpc.check_data_type_cd,
    rc.check_catalog_id,
    cpc.display_name,
    cpc.check_param_id_description,
    cpc.chk_param_type_cd,
    cat.process_cd,
    cc.check_name,
    cc.check_number,
    cc.check_type_cd,
    cc.run_check_flg
   FROM camdecmpsmd.rule_check_condition rcc
     JOIN camdecmpsmd.rule_check rc ON rcc.rule_check_id::numeric = rc.rule_check_id
     JOIN camdecmpsmd.check_parameter_code cpc ON rcc.check_param_id = cpc.check_param_id
     JOIN camdecmpsmd.check_operator_code coc ON rcc.check_operator_cd::text = coc.check_operator_cd::text
     JOIN camdecmpsmd.category_code cat ON rc.category_cd::text = cat.category_cd::text
     JOIN camdecmpsmd.check_catalog cc ON rc.check_catalog_id = cc.check_catalog_id
     LEFT JOIN camdecmpsmd.check_status_code csc ON cc.check_status_cd::text = csc.check_status_cd::text;
