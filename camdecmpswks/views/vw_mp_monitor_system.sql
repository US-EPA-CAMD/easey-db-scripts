-- View: camdecmpswks.vw_mp_monitor_system

DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_system;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_system
 AS
 SELECT monitor_plan.mon_plan_id,
    monitor_location.mon_loc_id,
    monitor_system.mon_sys_id,
    monitor_system.system_identifier,
    monitor_system.sys_type_cd,
    monitor_system.begin_date,
    monitor_system.begin_hour,
    monitor_system.end_date,
    monitor_system.end_hour,
    monitor_system.sys_designation_cd,
    monitor_system.fuel_cd,
    monitor_system.begin_date + ((monitor_system.begin_hour || ' HOUR'::text)::interval) AS begin_datehour,
    monitor_system.end_date + ((monitor_system.end_hour || ' HOUR'::text)::interval) AS end_datehour
   FROM camdecmpswks.monitor_location
     JOIN camdecmpswks.monitor_plan_location ON monitor_location.mon_loc_id::text = monitor_plan_location.mon_loc_id::text
     JOIN camdecmpswks.monitor_plan ON monitor_plan_location.mon_plan_id::text = monitor_plan.mon_plan_id::text
     JOIN camdecmpswks.monitor_system ON monitor_location.mon_loc_id::text = monitor_system.mon_loc_id::text;
