-- View: camdecmpsmd.vw_unitfuel_master_data_relationships

DROP VIEW IF EXISTS camdecmpsmd.vw_unitfuel_master_data_relationships;

CREATE OR REPLACE VIEW camdecmpsmd.vw_unitfuel_master_data_relationships
 AS
 SELECT fuel_type_code.fuel_type_cd,
    fuel_indicator_code.fuel_indicator_cd,
    gcv.dem_method_cd AS dem_gcv,
    so2.dem_method_cd AS dem_so2
   FROM camdecmpsmd.fuel_type_code,
    camdecmpsmd.fuel_indicator_code,
    ( SELECT dem_method_code.dem_method_cd
           FROM camdecmpsmd.dem_method_code
          WHERE dem_method_code.dem_parameter::text = 'GCV'::text) gcv,
    ( SELECT dem_method_code.dem_method_cd
           FROM camdecmpsmd.dem_method_code
          WHERE dem_method_code.dem_parameter::text = 'SULFUR'::text) so2;
