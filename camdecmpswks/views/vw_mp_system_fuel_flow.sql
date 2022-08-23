CREATE OR REPLACE VIEW camdecmpswks.vw_mp_system_fuel_flow (sys_fuel_id, mon_plan_id, mon_loc_id, mon_sys_id, max_rate, begin_date, begin_hour, end_date, end_hour, sys_fuel_uom_cd, max_rate_source_cd) AS
SELECT
    system_fuel_flow.sys_fuel_id, monitor_plan.mon_plan_id, monitor_location.mon_loc_id, system_fuel_flow.mon_sys_id, system_fuel_flow.max_rate, system_fuel_flow.begin_date, system_fuel_flow.begin_hour, system_fuel_flow.end_date, system_fuel_flow.end_hour, system_fuel_flow.sys_fuel_uom_cd, system_fuel_flow.max_rate_source_cd
    FROM camdecmpswks.monitor_location
    INNER JOIN camdecmpswks.monitor_plan_location
        ON monitor_location.mon_loc_id = monitor_plan_location.mon_loc_id
    INNER JOIN camdecmpswks.monitor_plan
        ON monitor_plan_location.mon_plan_id = monitor_plan.mon_plan_id
    INNER JOIN camdecmpswks.monitor_system
        ON monitor_location.mon_loc_id = monitor_system.mon_loc_id
    INNER JOIN camdecmpswks.system_fuel_flow
        ON monitor_system.mon_sys_id = system_fuel_flow.mon_sys_id;