-- View: camdecmpswks.vw_monitor_system

DROP VIEW IF EXISTS camdecmpswks.vw_monitor_system;

CREATE OR REPLACE VIEW camdecmpswks.vw_monitor_system
 AS
 SELECT ml.mon_loc_id,
    ms.mon_sys_id,
    ml.oris_code,
    ml.location_identifier,
    ml.fac_id,
    ms.system_identifier,
    ms.sys_type_cd,
    ms.begin_date,
    ms.begin_hour,
    ms.end_date,
    ms.end_hour,
    ms.sys_designation_cd,
    ms.fuel_cd,
    ms.begin_date + ((ms.begin_hour || ' HOUR'::text)::interval) AS begin_datehour,
    ms.end_date + ((ms.end_hour || ' HOUR'::text)::interval) AS end_datehour
   FROM camdecmpswks.monitor_system ms
     JOIN camdecmpswks.vw_monitor_location ml ON ms.mon_loc_id::text = ml.mon_loc_id::text;
