-- View: camdecmpswks.vw_unit_monitor_system

-- DROP VIEW camdecmpswks.vw_unit_monitor_system;

CREATE OR REPLACE VIEW camdecmpswks.vw_unit_monitor_system
 AS
 SELECT ml.mon_loc_id,
    ms.mon_sys_id,
    ml.oris_code,
    ml.location_identifier,
    ml.fac_id,
    usc.stack_name,
    ms.system_identifier,
    ms.sys_type_cd,
    ms.sys_designation_cd,
    ms.fuel_cd,
        CASE
            WHEN usc.begin_date IS NULL THEN ms.begin_date
            WHEN ms.begin_date IS NULL THEN usc.begin_date
            WHEN ms.begin_date >= usc.begin_date THEN ms.begin_date
            ELSE usc.begin_date
        END AS begin_date,
        CASE
            WHEN usc.begin_date IS NULL THEN ms.begin_hour
            WHEN ms.begin_date IS NULL THEN NULL::numeric
            WHEN ms.begin_date >= usc.begin_date THEN ms.begin_hour
            ELSE NULL::numeric
        END AS begin_hour,
        CASE
            WHEN usc.end_date IS NULL THEN ms.end_date
            WHEN ms.end_date IS NULL THEN usc.end_date
            WHEN ms.end_date <= usc.end_date THEN ms.end_date
            ELSE usc.end_date
        END AS end_date,
        CASE
            WHEN usc.end_date IS NULL THEN ms.end_hour
            WHEN ms.end_date IS NULL THEN NULL::numeric
            WHEN ms.end_date <= usc.end_date THEN ms.end_hour
            ELSE NULL::numeric
        END AS end_hour
   FROM camdecmpswks.vw_monitor_location ml
     JOIN camdecmpswks.vw_unit_stack_configuration usc ON ml.unit_id = usc.unit_id
     JOIN camdecmpswks.monitor_system ms ON usc.stack_pipe_mon_loc_id::text = ms.mon_loc_id::text AND (usc.end_date IS NULL OR ms.begin_date <= usc.end_date) AND (ms.end_date IS NULL OR ms.end_date >= usc.begin_date)
UNION
 SELECT ml.mon_loc_id,
    ms.mon_sys_id,
    ml.oris_code,
    ml.location_identifier,
    ml.fac_id,
    NULL::character varying AS stack_name,
    ms.system_identifier,
    ms.sys_type_cd,
    ms.sys_designation_cd,
    ms.fuel_cd,
    ms.begin_date,
    ms.begin_hour,
    ms.end_date,
    ms.end_hour
   FROM camdecmpswks.vw_monitor_location ml
     JOIN camdecmpswks.monitor_system ms ON ml.mon_loc_id::text = ms.mon_loc_id::text;
