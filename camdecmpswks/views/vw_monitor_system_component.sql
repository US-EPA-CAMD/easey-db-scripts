-- View: camdecmpswks.vw_monitor_system_component

DROP VIEW IF EXISTS camdecmpswks.vw_monitor_system_component;

CREATE OR REPLACE VIEW camdecmpswks.vw_monitor_system_component
 AS
 SELECT msc.mon_sys_comp_id,
    ml.mon_loc_id,
    ml.oris_code,
    ml.location_identifier,
    ml.fac_id,
    msc.mon_sys_id,
    msc.component_id,
    msc.begin_date,
    msc.begin_hour,
    msc.end_date,
    msc.end_hour,
    c.component_type_cd,
    c.acq_cd,
    c.basis_cd,
    ms.begin_date AS system_begin_date,
    ms.begin_hour AS system_begin_hour,
    ms.end_date AS system_end_date,
    ms.end_hour AS system_end_hour,
    ms.system_identifier,
    c.component_identifier,
    msc.begin_date + ((msc.begin_hour || ' HOUR'::text)::interval) AS begin_datehour,
    msc.end_date + ((msc.end_hour || ' HOUR'::text)::interval) AS end_datehour
   FROM camdecmpswks.monitor_system_component msc
     JOIN camdecmpswks.component c ON msc.component_id::text = c.component_id::text
     JOIN camdecmpswks.monitor_system ms ON msc.mon_sys_id::text = ms.mon_sys_id::text
     JOIN camdecmpswks.vw_monitor_location ml ON ms.mon_loc_id::text = ml.mon_loc_id::text;
