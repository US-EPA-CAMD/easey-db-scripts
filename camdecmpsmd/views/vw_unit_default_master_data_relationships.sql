-- View: camdecmpsmd.vw_unit_default_master_data_relationships

DROP VIEW IF EXISTS camdecmpsmd.vw_unit_default_master_data_relationships;

CREATE OR REPLACE VIEW camdecmpsmd.vw_unit_default_master_data_relationships
 AS
 SELECT fc.fuel_code,
    occ.operating_condition_code
   FROM ( SELECT vw_cross_check_catalog_value.value1 AS fuel_code
           FROM camdecmpsmd.vw_cross_check_catalog_value
          WHERE vw_cross_check_catalog_value.cross_chk_catalog_name::text = 'Fuel Codes to Category'::text AND vw_cross_check_catalog_value.value2 = 'UNITDEFAULT'::text) fc,
    ( SELECT vw_cross_check_catalog_value.value1 AS operating_condition_code
           FROM camdecmpsmd.vw_cross_check_catalog_value
          WHERE vw_cross_check_catalog_value.cross_chk_catalog_name::text = 'Operating Condition to Category'::text AND vw_cross_check_catalog_value.value2 = 'UNITDEFAULT'::text) occ;
