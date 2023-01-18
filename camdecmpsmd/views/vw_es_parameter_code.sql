-- View: camdecmpsmd.vw_es_parameter_code

-- DROP VIEW camdecmpsmd.vw_es_parameter_code;

CREATE OR REPLACE VIEW camdecmpsmd.vw_es_parameter_code
 AS
 SELECT chk.check_type_cd,
    chk.check_number,
    esp.parameter_cd,
    pc.parameter_cd_description
   FROM camdecmpsmd.check_catalog chk
     JOIN camdecmpsmd.rule_check rul ON rul.check_catalog_id = chk.check_catalog_id
     JOIN camdecmpsmd.category_code cat ON cat.category_cd::text = rul.category_cd::text
     JOIN camdecmpsmd.es_parameter_category xrf ON xrf.category_cd::text = cat.category_cd::text
     JOIN camdecmpsmd.es_parameter esp ON esp.es_parameter_group_cd::text = xrf.es_parameter_group_cd::text
     JOIN camdecmpsmd.parameter_code pc USING (parameter_cd)
  WHERE cat.process_cd::text = ANY (ARRAY['HOURLY'::character varying, 'MP'::character varying, 'OTHERQA'::character varying, 'TEST'::character varying]::text[]);
