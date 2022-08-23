CREATE OR REPLACE VIEW camdecmpswks.vw_mp_location_program (up_id, mon_plan_id, mon_loc_id, oris_code, location_name, unit_id, stack_pipe_id, prg_cd, class, unit_monitor_cert_begin_date, emissions_recording_begin_date, trueup_begin_year, unit_monitor_cert_deadline, non_egu_flg, app_status, nox_group, optin_ind, def_ind, def_end_date, end_date, fac_id) AS
SELECT
    up.up_id, ml.mon_plan_id, ml.mon_loc_id, ml.oris_code, ml.location_name, usc.unit_id, ml.stack_pipe_id, up.prg_cd, up.class_cd,
    CASE
        WHEN usc.begin_date IS NULL THEN up.unit_monitor_cert_begin_date
        WHEN up.unit_monitor_cert_begin_date IS NULL THEN usc.begin_date
        WHEN up.unit_monitor_cert_begin_date >= usc.begin_date THEN up.unit_monitor_cert_begin_date
        ELSE usc.begin_date
    END AS unit_monitor_cert_begin_date,
    CASE
        WHEN usc.begin_date IS NULL THEN up.emissions_recording_begin_date
        WHEN up.emissions_recording_begin_date IS NULL THEN usc.begin_date
        WHEN up.emissions_recording_begin_date >= usc.begin_date THEN up.emissions_recording_begin_date
        ELSE usc.begin_date
    END AS emissions_recording_begin_date, up.trueup_begin_year, up.unit_monitor_cert_deadline, up.non_egu_ind, up.app_status_cd, up.nox_group, up.optin_ind, up.def_ind, up.def_end_date,
    CASE
        WHEN usc.end_date IS NULL THEN up.end_date
        WHEN up.end_date IS NULL THEN usc.end_date
        WHEN up.end_date <= usc.end_date THEN up.end_date
        ELSE usc.end_date
    END AS end_date, ml.fac_id
    FROM camdecmpswks.vw_mp_monitor_location AS ml
    INNER JOIN camdecmpswks.unit_stack_configuration AS usc
        ON ml.stack_pipe_id = usc.stack_pipe_id
    INNER JOIN camd.unit_program AS up
        ON usc.unit_id = up.unit_id
    INNER JOIN camd.unit AS u
        ON u.unit_id = usc.unit_id
UNION
SELECT
    up.up_id, ml.mon_plan_id, ml.mon_loc_id, ml.oris_code, ml.location_name, ml.unit_id, NULL AS stack_pipe_id, up.prg_cd, up.class_cd, up.unit_monitor_cert_begin_date, up.emissions_recording_begin_date, up.trueup_begin_year, up.unit_monitor_cert_deadline, up.non_egu_ind, up.app_status_cd, up.nox_group, up.optin_ind, up.def_ind, up.def_end_date, up.end_date, ml.fac_id
    FROM camdecmpswks.vw_mp_monitor_location AS ml
    INNER JOIN camd.unit_program AS up
        ON ml.unit_id = up.unit_id
    INNER JOIN camd.unit AS u
        ON u.unit_id = ml.unit_id;