-- View: camdecmpsmd.vw_systemfuel_master_data_relationships

-- DROP VIEW camdecmpsmd.vw_systemfuel_master_data_relationships;

CREATE OR REPLACE VIEW camdecmpsmd.vw_systemfuel_master_data_relationships
 AS
 SELECT uom.unit_of_measure_code,
    uom.max_rate_source_code
   FROM ( SELECT unit.value1 AS unit_of_measure_code,
            mfrs.max_rate_source_cd AS max_rate_source_code
           FROM camdecmpsmd.vw_cross_check_catalog_value unit,
            camdecmpsmd.max_rate_source_code mfrs
          WHERE unit.cross_chk_catalog_name::text = 'Units of Measure to Category'::text AND unit.value2 = 'SYSFUEL'::text) uom;

ALTER TABLE camdecmpsmd.vw_systemfuel_master_data_relationships
    OWNER TO "uImcwuf4K9dyaxeL";

