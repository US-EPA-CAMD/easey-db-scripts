-- View: camdecmpswks.vw_evem_long_term_fuel_flow

DROP VIEW IF EXISTS camdecmpswks.vw_evem_long_term_fuel_flow;

CREATE OR REPLACE VIEW camdecmpswks.vw_evem_long_term_fuel_flow
 AS
 SELECT ltff.ltff_id,
    ltff.mon_loc_id,
    ms.mon_sys_id,
    ms.system_identifier,
    ms.sys_type_cd,
    ltff.fuel_flow_period_cd,
    ml.mon_plan_id,
    ltff.long_term_fuel_flow_value,
    ltff.ltff_uom_cd,
    ltff.gross_calorific_value,
    ltff.gcv_uom_cd,
    ltff.total_heat_input,
    ltff.calc_total_heat_input,
    ms.fuel_cd,
    ms.sys_designation_cd,
    rp.calendar_year,
    rp.quarter,
    rp.rpt_period_id
   FROM camdecmpswks.long_term_fuel_flow ltff
     JOIN camdecmpsmd.reporting_period rp ON ltff.rpt_period_id = rp.rpt_period_id
     JOIN camdecmpswks.vw_mp_monitor_location ml ON ml.mon_loc_id::text = ltff.mon_loc_id::text
     LEFT JOIN camdecmpswks.monitor_system ms ON ltff.mon_sys_id::text = ms.mon_sys_id::text;
