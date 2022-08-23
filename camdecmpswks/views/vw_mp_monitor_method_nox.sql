CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_method_nox (mon_method_id, mon_plan_id, mon_loc_id, parameter_cd, sub_data_cd, bypass_approach_cd, method_cd, begin_date, begin_hour, end_date, end_hour) AS
SELECT
    monitor_method.mon_method_id, monitor_plan.mon_plan_id, monitor_location.mon_loc_id, monitor_method.parameter_cd, monitor_method.sub_data_cd, monitor_method.bypass_approach_cd, monitor_method.method_cd, monitor_method.begin_date, monitor_method.begin_hour, monitor_method.end_date, monitor_method.end_hour
    FROM camdecmpswks.monitor_location
    INNER JOIN camdecmpswks.monitor_method
        ON monitor_location.mon_loc_id = monitor_method.mon_loc_id
    INNER JOIN camdecmpswks.monitor_plan_location
        ON monitor_location.mon_loc_id = monitor_plan_location.mon_loc_id
    INNER JOIN camdecmpswks.monitor_plan
        ON monitor_plan_location.mon_plan_id = monitor_plan.mon_plan_id
    WHERE (monitor_method.parameter_cd IN ('NOX', 'NOXM'));