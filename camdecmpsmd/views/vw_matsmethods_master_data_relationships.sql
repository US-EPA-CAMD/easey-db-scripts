-- View: camdecmpsmd.vw_matsmethods_master_data_relationships

DROP VIEW IF EXISTS camdecmpsmd.vw_matsmethods_master_data_relationships;

CREATE OR REPLACE VIEW camdecmpsmd.vw_matsmethods_master_data_relationships
 AS
 SELECT vw_cross_check_catalog_value.value1 AS parameter_code,
    vw_cross_check_catalog_value.value2 AS method_code
   FROM camdecmpsmd.vw_cross_check_catalog_value
  WHERE vw_cross_check_catalog_value.cross_chk_catalog_name::text = 'MATS Supplemental Compliance Parameter to Method'::text;
