-- View: camdecmpsmd.vw_units_of_measure_code

-- DROP VIEW camdecmpsmd.vw_units_of_measure_code;

CREATE OR REPLACE VIEW camdecmpsmd.vw_units_of_measure_code
 AS
 SELECT units_of_measure_code.uom_cd,
    units_of_measure_code.uom_cd_description
   FROM camdecmpsmd.units_of_measure_code;
