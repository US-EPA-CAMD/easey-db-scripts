CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_system_component (mon_plan_id, mon_loc_id, mon_sys_id, component_id, begin_datehour, begin_date, begin_hour, end_datehour, end_date, end_hour, component_type_cd, component_identifier, basis_cd, acq_cd, system_identifier, sys_type_cd, sys_designation_cd, system_begin_datehour, system_begin_date, system_begin_hour, system_end_datehour, system_end_date, system_end_hour, mon_sys_comp_id) AS
SELECT
    mpl.mon_plan_id, mpl.mon_loc_id, msc.mon_sys_id, msc.component_id, msc.begin_date + (msc.begin_hour::NUMERIC || ' HOUR')::INTERVAL AS begin_datehour, msc.begin_date, msc.begin_hour, msc.end_date + (msc.end_hour::NUMERIC || ' HOUR')::INTERVAL AS end_datehour, msc.end_date, msc.end_hour, cmp.component_type_cd, cmp.component_identifier, cmp.basis_cd, cmp.acq_cd, sys.system_identifier, sys.sys_type_cd, sys.sys_designation_cd, sys.begin_date + (sys.begin_hour::NUMERIC || ' HOUR')::INTERVAL AS system_begin_datehour, sys.begin_date AS system_begin_date, sys.begin_hour AS system_begin_hour, sys.end_date + (sys.end_hour::NUMERIC || ' HOUR')::INTERVAL AS system_end_datehour, sys.end_date AS system_end_date, sys.end_hour AS system_end_hour, msc.mon_sys_comp_id
    FROM camdecmpswks.monitor_system_component AS msc
    INNER JOIN camdecmpswks.component AS cmp
        ON cmp.component_id = msc.component_id
    INNER JOIN camdecmpswks.monitor_system AS sys
        ON sys.mon_sys_id = msc.mon_sys_id
    INNER JOIN camdecmpswks.monitor_plan_location AS mpl
        ON mpl.mon_loc_id = sys.mon_loc_id;