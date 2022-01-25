-- View: camdecmpsmd.vw_defaults_master_data_relationships

-- DROP VIEW camdecmpsmd.vw_defaults_master_data_relationships;

CREATE OR REPLACE VIEW camdecmpsmd.vw_defaults_master_data_relationships
 AS
 SELECT param_code.parameter_code,
    param_code.operating_condition_code,
    uom.unit_of_measure_code,
    purp.purpose_code,
    fuel.fuel_code,
    src.source_code
   FROM ( SELECT param.value1 AS parameter_code,
            oc.value1 AS operating_condition_code
           FROM camdecmpsmd.vw_cross_check_catalog_value param,
            camdecmpsmd.vw_cross_check_catalog_value oc
          WHERE param.cross_chk_catalog_name::text = 'Parameter to Category'::text AND param.value2 = 'DEFAULT'::text AND oc.cross_chk_catalog_name::text = 'Operating Condition to Category'::text AND oc.value2 = 'DEFAULT'::text) param_code
     LEFT JOIN ( SELECT vw_cross_check_catalog_value.value1 AS parameter_code,
            vw_cross_check_catalog_value.value2 AS unit_of_measure_code
           FROM camdecmpsmd.vw_cross_check_catalog_value
          WHERE vw_cross_check_catalog_value.cross_chk_catalog_name::text = 'Parameter Code to Units of Measure Code for Defaults'::text) uom ON param_code.parameter_code = uom.parameter_code
     LEFT JOIN ( SELECT vw_cross_check_catalog_value.value1 AS parameter_code,
            vw_cross_check_catalog_value.value2 AS purpose_code
           FROM camdecmpsmd.vw_cross_check_catalog_value
          WHERE vw_cross_check_catalog_value.cross_chk_catalog_name::text = 'Parameter Code to Purpose Code for Defaults'::text) purp ON param_code.parameter_code = purp.parameter_code
     LEFT JOIN ( SELECT vw_cross_check_catalog_value.value1 AS parameter_code,
            vw_cross_check_catalog_value.value2 AS fuel_code
           FROM camdecmpsmd.vw_cross_check_catalog_value
          WHERE vw_cross_check_catalog_value.cross_chk_catalog_name::text = 'Parameter Code to Fuel Code for Defaults'::text) fuel ON param_code.parameter_code = fuel.parameter_code
     LEFT JOIN ( SELECT vw_cross_check_catalog_value.value1 AS parameter_code,
            vw_cross_check_catalog_value.value2 AS source_code
           FROM camdecmpsmd.vw_cross_check_catalog_value
          WHERE vw_cross_check_catalog_value.cross_chk_catalog_name::text = 'Parameter Code to Source Code for Defaults'::text) src ON param_code.parameter_code = src.parameter_code;

ALTER TABLE camdecmpsmd.vw_defaults_master_data_relationships
    OWNER TO "uImcwuf4K9dyaxeL";

