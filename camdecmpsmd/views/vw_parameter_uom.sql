-- View: camdecmpsmd.vw_parameter_uom

-- DROP VIEW camdecmpsmd.vw_parameter_uom;

CREATE OR REPLACE VIEW camdecmpsmd.vw_parameter_uom
 AS
 SELECT parameter_uom.param_id,
    parameter_uom.parameter_cd,
    parameter_uom.uom_cd,
    parameter_uom.parameter_format,
    parameter_uom.min_value,
    parameter_uom.max_value,
    parameter_uom.decimals_hrly,
    parameter_uom.decimals_fuel_flow,
    parameter_uom.decimals_summary
   FROM camdecmpsmd.parameter_uom;
