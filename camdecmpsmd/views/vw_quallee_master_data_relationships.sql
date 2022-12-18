-- View: camdecmpsmd.vw_quallee_master_data_relationships

DROP VIEW IF EXISTS camdecmpsmd.vw_quallee_master_data_relationships;

CREATE OR REPLACE VIEW camdecmpsmd.vw_quallee_master_data_relationships
 AS
 SELECT param_code.parameter_code,
    uom.unit_of_standard_code,
    qual_lee_ttc.qual_lee_test_type_cd
   FROM ( SELECT vw_cross_check_catalog_value.value1 AS parameter_code
           FROM camdecmpsmd.vw_cross_check_catalog_value
          WHERE vw_cross_check_catalog_value.cross_chk_catalog_name::text = 'Parameter to Category'::text AND vw_cross_check_catalog_value.value2 = 'QUALLEE'::text) param_code,
    ( SELECT vw_cross_check_catalog_value.value1 AS unit_of_standard_code
           FROM camdecmpsmd.vw_cross_check_catalog_value
          WHERE vw_cross_check_catalog_value.cross_chk_catalog_name::text = 'Units of Measure to Category'::text AND vw_cross_check_catalog_value.value2 = 'QUALLEE'::text) uom,
    ( SELECT qual_lee_test_type_code.qual_lee_test_type_cd
           FROM camdecmpsmd.qual_lee_test_type_code) qual_lee_ttc;
