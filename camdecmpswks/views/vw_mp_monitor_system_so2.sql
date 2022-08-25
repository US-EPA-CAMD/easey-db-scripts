CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_system_so2 (mon_plan_id, mon_loc_id, mon_sys_id, system_identifier, sys_type_cd, begin_date, begin_hour, end_date, end_hour, sys_designation_cd, fuel_cd) AS
SELECT
    monitor_plan.mon_plan_id, monitor_location.mon_loc_id, monitor_system.mon_sys_id, monitor_system.system_identifier, monitor_system.sys_type_cd, monitor_system.begin_date, monitor_system.begin_hour, monitor_system.end_date, monitor_system.end_hour, monitor_system.sys_designation_cd, monitor_system.fuel_cd
    FROM camdecmpswks.monitor_location
    INNER JOIN camdecmpswks.monitor_plan_location
        ON monitor_location.mon_loc_id = monitor_plan_location.mon_loc_id
    INNER JOIN camdecmpswks.monitor_plan
        ON monitor_plan_location.mon_plan_id = monitor_plan.mon_plan_id
    INNER JOIN camdecmpswks.monitor_system
        ON monitor_location.mon_loc_id = monitor_system.mon_loc_id
    WHERE (monitor_system.sys_type_cd = 'SO2');