-- View: camdecmpswks.vw_mp_hrly_fuel_flow

DROP VIEW IF EXISTS camdecmpswks.vw_mp_hrly_fuel_flow;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_hrly_fuel_flow
 AS
 SELECT hff.hrly_fuel_flow_id,
    hff.hour_id,
    vwhod.mon_plan_id,
    vwhod.mon_loc_id,
    vwhod.rpt_period_id,
    vwhod.calendar_year,
    vwhod.quarter,
    vwhod.begin_date,
    vwhod.begin_hour,
    ms.mon_sys_id,
    fc.fuel_cd,
    fc.fuel_group_cd,
    fc.unit_fuel_cd,
    hff.fuel_usage_time,
    hff.volumetric_flow_rate,
    hff.calc_volumetric_flow_rate,
    hff.volumetric_uom_cd,
    hff.sod_volumetric_cd,
    hff.mass_flow_rate,
    hff.calc_mass_flow_rate,
    hff.sod_mass_cd,
    ms.system_identifier,
    ms.sys_type_cd,
    ms.sys_designation_cd,
    ms.begin_date AS system_begin_date
   FROM camdecmpswks.vw_mp_hrly_op_data vwhod
     JOIN camdecmpswks.hrly_fuel_flow hff ON vwhod.hour_id::text = hff.hour_id::text
     LEFT JOIN camdecmpsmd.fuel_code fc ON hff.fuel_cd::text = fc.fuel_cd::text
     LEFT JOIN camdecmpswks.monitor_system ms ON hff.mon_sys_id::text = ms.mon_sys_id::text;
