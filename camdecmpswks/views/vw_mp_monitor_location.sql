CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_location (monitor_plan_location_id, mon_plan_id, mon_loc_id, fac_id, oris_code, location_name, stack_pipe_id, unit_id, non_load_based_ind, stack_pipe_active_date, stack_pipe_retire_date) AS
SELECT
    monitor_plan_location_id, mp.mon_plan_id, ml.mon_loc_id, mp.fac_id, oris_code, location_name, sp.stack_pipe_id, u.unit_id, non_load_based_ind, active_date AS stack_pipe_active_date, retire_date AS stack_pipe_retire_date
    FROM camdecmpswks.monitor_plan mp
    FULL OUTER JOIN camd.plant p
        ON mp.fac_id = p.fac_id
    FULL OUTER JOIN camdecmpswks.monitor_location ml
    INNER JOIN camdecmpswks.monitor_plan_location mpl
        ON ml.mon_loc_id = mpl.mon_loc_id
    LEFT OUTER JOIN camdecmpswks.vw_monitor_location_merged vwM
        ON mpl.mon_loc_id = vwM.mon_loc_id
        ON mp.mon_plan_id = mpl.mon_plan_id
    LEFT OUTER JOIN camd.unit u
        ON ml.unit_id = u.unit_id
    LEFT OUTER JOIN camdecmpswks.stack_pipe sp
        ON ml.stack_pipe_id = sp.stack_pipe_id;