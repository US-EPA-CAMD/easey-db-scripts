CREATE OR REPLACE VIEW camdecmpswks.vw_ce_mp_monitor_location (monitor_plan_location_id, mon_plan_id, mon_loc_id, fac_id, oris_code, location_name, stack_pipe_id, unit_id, non_load_based_ind, stack_pipe_active_date, stack_pipe_retire_date, earliest_report_date) AS
SELECT
    mpl.monitor_plan_location_id, mpl.mon_plan_id, mpl.mon_loc_id, fac.fac_id, fac.oris_code, COALESCE(unt.unitid, stp.stack_name) AS location_name, loc.stack_pipe_id, loc.unit_id, unt.non_load_based_ind, stp.active_date AS stack_pipe_active_date, stp.retire_date AS stack_pipe_retire_date, MIN(COALESCE(vlp.emissions_recording_begin_date, unit_monitor_cert_begin_date)) AS earliest_report_date
    FROM camdecmpswks.monitor_plan_location AS mpl
    INNER JOIN camdecmpswks.monitor_location AS loc
        ON loc.mon_loc_id = mpl.mon_loc_id
    LEFT OUTER JOIN camd.unit AS unt
        ON unt.unit_id = loc.unit_id
    LEFT OUTER JOIN camdecmpswks.stack_pipe AS stp
        ON stp.stack_pipe_id = loc.stack_pipe_id
    INNER JOIN camd.plant AS fac
        ON fac.fac_id IN (unt.fac_id, stp.fac_id)
    LEFT OUTER JOIN camdecmpswks.vw_location_program AS vlp
        ON vlp.mon_loc_id = loc.mon_loc_id
    GROUP BY mpl.monitor_plan_location_id, mpl.mon_plan_id, mpl.mon_loc_id, fac.fac_id, fac.oris_code, COALESCE(unt.unitid, stp.stack_name), loc.stack_pipe_id, loc.unit_id, unt.non_load_based_ind, stp.active_date, stp.retire_date;