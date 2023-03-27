-- View: camdecmpswks.vw_mp_system_fuel_flow

DROP VIEW IF EXISTS camdecmpswks.vw_mp_system_fuel_flow;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_system_fuel_flow
 AS
 SELECT system_fuel_flow.sys_fuel_id,
    monitor_plan.mon_plan_id,
    monitor_location.mon_loc_id,
    system_fuel_flow.mon_sys_id,
    system_fuel_flow.max_rate,
    system_fuel_flow.begin_date,
    system_fuel_flow.begin_hour,
    system_fuel_flow.end_date,
    system_fuel_flow.end_hour,
    system_fuel_flow.sys_fuel_uom_cd,
    system_fuel_flow.max_rate_source_cd
   FROM camdecmpswks.monitor_location
     JOIN camdecmpswks.monitor_plan_location ON monitor_location.mon_loc_id::text = monitor_plan_location.mon_loc_id::text
     JOIN camdecmpswks.monitor_plan ON monitor_plan_location.mon_plan_id::text = monitor_plan.mon_plan_id::text
     JOIN camdecmpswks.monitor_system ON monitor_location.mon_loc_id::text = monitor_system.mon_loc_id::text
     JOIN camdecmpswks.system_fuel_flow ON monitor_system.mon_sys_id::text = system_fuel_flow.mon_sys_id::text;
