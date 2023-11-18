-- View: camdecmpsmd.vw_systemcomponent_master_data_relationships

DROP VIEW IF EXISTS camdecmpsmd.vw_systemcomponent_master_data_relationships;

CREATE OR REPLACE VIEW camdecmpsmd.vw_systemcomponent_master_data_relationships
 AS
 SELECT component.component_type_code,
    sam.sample_aquisition_method_code,
    bas.basis_code
   FROM ( SELECT param.value1 AS component_type_code
           FROM camdecmpsmd.vw_cross_check_catalog_value param
          WHERE param.cross_chk_catalog_name::text = 'Component Type to Category'::text AND param.value2 = 'COMPONENT'::text) component
     LEFT JOIN ( SELECT DISTINCT vw_cross_check_catalog_value.value1 AS component_type_code,
            vw_cross_check_catalog_value.value3 AS sample_aquisition_method_code
           FROM camdecmpsmd.vw_cross_check_catalog_value
          WHERE vw_cross_check_catalog_value.cross_chk_catalog_name::text = 'Component Type and Basis to Sample Acquisition Method'::text) sam ON component.component_type_code = sam.component_type_code
     LEFT JOIN ( SELECT DISTINCT vw_cross_check_catalog_value.value1 AS component_type_code,
             vw_cross_check_catalog_value.value2 AS basis_code
           FROM camdecmpsmd.vw_cross_check_catalog_value
          WHERE vw_cross_check_catalog_value.cross_chk_catalog_name::text = 'Component Type Code to Basis Code'::text) bas ON component.component_type_code = bas.component_type_code
  ORDER BY component.component_type_code, sam.sample_aquisition_method_code, bas.basis_code;
