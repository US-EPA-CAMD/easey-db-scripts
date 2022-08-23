CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_method_missing_data_fsp (mon_method_id, mon_plan_id, mon_loc_id, parameter_cd, sub_data_cd, bypass_approach_cd, method_cd, begin_datehour, begin_date, begin_hour, end_datehour, end_date, end_hour, stack_pipe_id, stack_name, unit_id, unitid) AS
SELECT
    *
    FROM camdecmpswks.vw_mp_monitor_method
    WHERE (vw_mp_monitor_method.sub_data_cd IN ('FSP75', 'FSP75C'));