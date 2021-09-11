-- View: camdecmpsmd.vw_rule_check

-- DROP VIEW camdecmpsmd.vw_rule_check;

CREATE OR REPLACE VIEW camdecmpsmd.vw_rule_check
 AS
 SELECT rc.rule_check_id,
    rc.category_cd,
    cat_cd.category_cd_description,
    cc.check_name,
    cc.check_procedure,
    cc.check_type_cd,
    cc.check_number,
    ((((cc.check_name::text || ' ('::text) || cc.check_type_cd::text) || '-'::text) || cc.check_number::character varying(30)::text) || ')'::text AS rule_description,
    rc.check_catalog_id,
    cc.check_status_cd,
    chk_stat.check_status_cd_description,
    cc.code_status_cd,
    cod_stat.check_status_cd_description AS code_status_cd_description,
    cc.test_status_cd,
    tst_stat.check_status_cd_description AS test_status_cd_description,
    cc.run_check_flg
   FROM camdecmpsmd.rule_check rc
     JOIN camdecmpsmd.category_code cat_cd ON rc.category_cd::text = cat_cd.category_cd::text
     JOIN camdecmpsmd.check_catalog cc ON rc.check_catalog_id = cc.check_catalog_id
     LEFT JOIN camdecmpsmd.vw_check_status_code chk_stat ON cc.check_status_cd::text = chk_stat.check_status_cd::text
     LEFT JOIN camdecmpsmd.check_status_code tst_stat ON cc.test_status_cd::text = tst_stat.check_status_cd::text
     LEFT JOIN camdecmpsmd.check_status_code cod_stat ON cc.code_status_cd::text = cod_stat.check_status_cd::text;
