-- View: camdecmpsmd.vw_span_master_data_relationships

-- DROP VIEW camdecmpsmd.vw_span_master_data_relationships;

CREATE OR REPLACE VIEW camdecmpsmd.vw_span_master_data_relationships
 AS
 SELECT component.component_type_code,
    uom.unit_of_measure_code,
    scale_method.span_scale_code,
    scale_method.span_method_code
   FROM ( SELECT param.value1 AS component_type_code
           FROM camdecmpsmd.vw_cross_check_catalog_value param
          WHERE param.cross_chk_catalog_name::text = 'Component Type to Category'::text AND param.value2 = 'SPAN'::text) component
     LEFT JOIN ( SELECT DISTINCT vw_cross_check_catalog_value.value1 AS component_type_code,
            vw_cross_check_catalog_value.value2 AS unit_of_measure_code
           FROM camdecmpsmd.vw_cross_check_catalog_value
          WHERE vw_cross_check_catalog_value.cross_chk_catalog_name::text = 'Component Type Code to Units of Measure for Span'::text) uom ON component.component_type_code = uom.component_type_code
     LEFT JOIN ( SELECT vw_cross_check_catalog_value.value1 AS component_type_code,
            vw_cross_check_catalog_value.value2 AS span_scale_code,
            vw_cross_check_catalog_value.value3 AS span_method_code
           FROM camdecmpsmd.vw_cross_check_catalog_value
          WHERE vw_cross_check_catalog_value.cross_chk_catalog_name::text = 'Component Type and Span Scale to Span Method'::text) scale_method ON scale_method.component_type_code = component.component_type_code;

ALTER TABLE camdecmpsmd.vw_span_master_data_relationships
    OWNER TO "uImcwuf4K9dyaxeL";

