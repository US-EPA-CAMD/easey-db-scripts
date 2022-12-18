-- View: camdecmpsmd.vw_formula_master_data_relationships

DROP VIEW IF EXISTS camdecmpsmd.vw_formula_master_data_relationships;

CREATE OR REPLACE VIEW camdecmpsmd.vw_formula_master_data_relationships
 AS
 SELECT param_code.parameter_code,
    formula_code.formula_code
   FROM ( SELECT param.value1 AS parameter_code
           FROM camdecmpsmd.vw_cross_check_catalog_value param
          WHERE param.cross_chk_catalog_name::text = 'Parameter to Category'::text AND param.value2 = 'FORMULA'::text) param_code
     LEFT JOIN ( SELECT DISTINCT vw_cross_check_catalog_value.value1 AS parameter_code,
            vw_cross_check_catalog_value.value2 AS formula_code
           FROM camdecmpsmd.vw_cross_check_catalog_value
          WHERE vw_cross_check_catalog_value.cross_chk_catalog_name::text = 'Parameter Code to Formula Code for Formulas'::text) formula_code ON param_code.parameter_code = formula_code.parameter_code;
