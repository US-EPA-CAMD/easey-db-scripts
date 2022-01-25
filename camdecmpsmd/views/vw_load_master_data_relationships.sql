-- View: camdecmpsmd.vw_load_master_data_relationships

-- DROP VIEW camdecmpsmd.vw_load_master_data_relationships;

CREATE OR REPLACE VIEW camdecmpsmd.vw_load_master_data_relationships
 AS
 SELECT uom.unit_of_measure_code,
    operating_level.operating_level_code AS normal_level,
    operating_level.operating_level_code AS second_level
   FROM ( SELECT unit.value1 AS unit_of_measure_code
           FROM camdecmpsmd.vw_cross_check_catalog_value unit
          WHERE unit.cross_chk_catalog_name::text = 'Units of Measure to Category'::text AND unit.value2 = 'LOAD'::text) uom,
    ( SELECT op_level.value1 AS operating_level_code
           FROM camdecmpsmd.vw_cross_check_catalog_value op_level
          WHERE op_level.cross_chk_catalog_name::text = 'Operating Level to Category'::text AND op_level.value2 = 'LOAD'::text) operating_level;

ALTER TABLE camdecmpsmd.vw_load_master_data_relationships
    OWNER TO "uImcwuf4K9dyaxeL";

