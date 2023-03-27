-- View: camdecmpswks.vw_mp_monitor_system_component

DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_system_component;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_system_component
 AS
 SELECT mpl.mon_plan_id,
    mpl.mon_loc_id,
    msc.mon_sys_id,
    msc.component_id,
    msc.begin_date + ((msc.begin_hour || ' HOUR'::text)::interval) AS begin_datehour,
    msc.begin_date,
    msc.begin_hour,
    msc.end_date + ((msc.end_hour || ' HOUR'::text)::interval) AS end_datehour,
    msc.end_date,
    msc.end_hour,
    cmp.component_type_cd,
    cmp.component_identifier,
    cmp.basis_cd,
    cmp.acq_cd,
    sys.system_identifier,
    sys.sys_type_cd,
    sys.sys_designation_cd,
    sys.begin_date + ((sys.begin_hour || ' HOUR'::text)::interval) AS system_begin_datehour,
    sys.begin_date AS system_begin_date,
    sys.begin_hour AS system_begin_hour,
    sys.end_date + ((sys.end_hour || ' HOUR'::text)::interval) AS system_end_datehour,
    sys.end_date AS system_end_date,
    sys.end_hour AS system_end_hour,
    msc.mon_sys_comp_id
   FROM camdecmpswks.monitor_system_component msc
     JOIN camdecmpswks.component cmp ON cmp.component_id::text = msc.component_id::text
     JOIN camdecmpswks.monitor_system sys ON sys.mon_sys_id::text = msc.mon_sys_id::text
     JOIN camdecmpswks.monitor_plan_location mpl ON mpl.mon_loc_id::text = sys.mon_loc_id::text;
