-- View: camdecmps.emission_view_ltff

DROP VIEW IF EXISTS camdecmps.emission_view_ltff;

CREATE OR REPLACE VIEW camdecmps.emission_view_ltff
 AS
 SELECT ltff.mon_loc_id,
    rp.rpt_period_id,
    ms.system_identifier AS fuel_flow_system_id,
    ms.sys_type_cd AS system_type,
    ms.fuel_cd AS fuel_type,
    ltff.fuel_flow_period_cd AS period_cd,
    ltff.long_term_fuel_flow_value AS fuel_flow,
    ltff.ltff_uom_cd AS fuel_flow_uom,
    ltff.gross_calorific_value,
    ltff.gcv_uom_cd AS gcv_uom,
    ltff.total_heat_input AS rpt_heat_input,
    ltff.calc_total_heat_input AS calc_heat_input
   FROM camdecmps.long_term_fuel_flow ltff
     LEFT JOIN camdecmps.monitor_system ms ON ms.mon_sys_id::text = ltff.mon_sys_id::text
     JOIN camdecmpsmd.reporting_period rp ON rp.rpt_period_id = ltff.rpt_period_id;
