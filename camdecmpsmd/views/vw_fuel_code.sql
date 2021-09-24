-- View: camdecmpsmd.vw_fuel_code

-- DROP VIEW camdecmpsmd.vw_fuel_code;

CREATE OR REPLACE VIEW camdecmpsmd.vw_fuel_code
 AS
 SELECT fuel_code.fuel_cd,
    fuel_code.fuel_group_cd,
    fuel_code.unit_fuel_cd,
    fuel_code.fuel_cd_description
   FROM camdecmpsmd.fuel_code;