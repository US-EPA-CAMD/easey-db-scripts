-- View: camdecmpsmd.vw_systemcomponent_master_data_relationships

-- DROP VIEW camdecmpsmd.vw_systemcomponent_master_data_relationships;

CREATE OR REPLACE VIEW camdecmpsmd.vw_systemcomponent_master_data_relationships
 AS
 SELECT component.component_type_code,
    sam.sample_aquisition_method_code,
    sam.basis_code
   FROM ( SELECT param.value1 AS component_type_code
           FROM camdecmpsmd.vw_cross_check_catalog_value param
          WHERE param.cross_chk_catalog_name::text = 'Component Type to Category'::text AND param.value2 = 'COMPONENT'::text) component
     LEFT JOIN ( SELECT DISTINCT vw_cross_check_catalog_value.value1 AS component_type_code,
            vw_cross_check_catalog_value.value3 AS sample_aquisition_method_code,
                CASE
                    WHEN vw_cross_check_catalog_value.value2 IS NOT NULL THEN vw_cross_check_catalog_value.value2
                    WHEN vw_cross_check_catalog_value.value2 IS NULL AND vw_cross_check_catalog_value.value3 IS NOT NULL THEN bc.basis_cd::text
                    ELSE NULL::text
                END AS basis_code
           FROM camdecmpsmd.vw_cross_check_catalog_value,
            camdecmpsmd.basis_code bc
          WHERE vw_cross_check_catalog_value.cross_chk_catalog_name::text = 'Component Type and Basis to Sample Acquisition Method'::text) sam ON component.component_type_code = sam.component_type_code
  ORDER BY component.component_type_code, sam.sample_aquisition_method_code;

ALTER TABLE camdecmpsmd.vw_systemcomponent_master_data_relationships
    OWNER TO "uImcwuf4K9dyaxeL";

