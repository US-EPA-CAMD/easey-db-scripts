-- View: camdecmpswks.emission_view_ltff

DROP VIEW IF EXISTS camdecmpswks.emission_view_ltff;

CREATE OR REPLACE VIEW camdecmpswks.emission_view_ltff
 AS
 SELECT mpl.mon_plan_id,
    ltff.mon_loc_id,
    rp.rpt_period_id,
    rp.begin_date,
    rp.end_date,
    rp.begin_date AS datehour,
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
   FROM camdecmpswks.long_term_fuel_flow ltff
     JOIN camdecmpswks.monitor_plan_location mpl USING (mon_loc_id)
     JOIN camdecmpsmd.reporting_period rp USING (rpt_period_id)
     LEFT JOIN camdecmpswks.monitor_system ms USING (mon_sys_id);
