-- View: camdecmpsmd.vw_methods_master_data_relationships

-- DROP VIEW camdecmpsmd.vw_methods_master_data_relationships;

CREATE OR REPLACE VIEW camdecmpsmd.vw_methods_master_data_relationships
 AS
 SELECT method_param.parameter_code,
    method_code.method_code,
    bypass_code.bypass_approach_code,
    substitute_data_code.substitute_data_code
   FROM ( SELECT param.value1 AS parameter_code
           FROM camdecmpsmd.vw_cross_check_catalog_value param
          WHERE param.cross_chk_catalog_name::text = 'Parameter to Category'::text AND param.value2 = 'METHOD'::text) method_param
     LEFT JOIN ( SELECT DISTINCT vw_cross_check_catalog_value.value1 AS parameter_code,
            vw_cross_check_catalog_value.value2 AS method_code
           FROM camdecmpsmd.vw_cross_check_catalog_value
          WHERE vw_cross_check_catalog_value.cross_chk_catalog_name::text = 'Method Parameter to Method to System Type'::text) method_code ON method_param.parameter_code = method_code.parameter_code
     LEFT JOIN ( SELECT vw_cross_check_catalog_value.value1 AS parameter_code,
            vw_cross_check_catalog_value.value2 AS method_code,
            vw_cross_check_catalog_value.value3 AS bypass_approach_code
           FROM camdecmpsmd.vw_cross_check_catalog_value
          WHERE vw_cross_check_catalog_value.cross_chk_catalog_name::text = 'Method Parameter to Method Code to Bypass Approach for Methods'::text) bypass_code ON method_param.parameter_code = bypass_code.parameter_code AND method_code.method_code = bypass_code.method_code
     LEFT JOIN ( SELECT vw_cross_check_catalog_value.value1 AS parameter_code,
            vw_cross_check_catalog_value.value2 AS substitute_data_code
           FROM camdecmpsmd.vw_cross_check_catalog_value
          WHERE vw_cross_check_catalog_value.cross_chk_catalog_name::text = 'Method Parameter to Substitute Data Code for Methods'::text) substitute_data_code ON method_param.parameter_code = substitute_data_code.parameter_code;
