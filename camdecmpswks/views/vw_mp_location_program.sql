-- View: camdecmpswks.vw_mp_location_program

DROP VIEW IF EXISTS camdecmpswks.vw_mp_location_program;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_location_program
 AS
 SELECT up.up_id,
    ml.mon_plan_id,
    ml.mon_loc_id,
    ml.oris_code,
    ml.location_name,
    usc.unit_id,
    ml.stack_pipe_id,
    up.prg_cd,
    up.class_cd AS class,
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
        END AS emissions_recording_begin_date,
    up.trueup_begin_year,
    up.unit_monitor_cert_deadline,
    up.non_egu_ind AS non_egu_flg,
    up.app_status_cd AS app_status,
    up.optin_ind,
    up.def_ind,
    up.def_end_date,
        CASE
            WHEN usc.end_date IS NULL THEN up.end_date
            WHEN up.end_date IS NULL THEN usc.end_date
            WHEN up.end_date <= usc.end_date THEN up.end_date
            ELSE usc.end_date
        END AS end_date,
    ml.fac_id
   FROM camdecmpswks.vw_mp_monitor_location ml
     JOIN camdecmpswks.unit_stack_configuration usc ON ml.stack_pipe_id::text = usc.stack_pipe_id::text
     JOIN camd.unit_program up ON usc.unit_id = up.unit_id
     JOIN camd.unit u ON u.unit_id = usc.unit_id
UNION
 SELECT up.up_id,
    ml.mon_plan_id,
    ml.mon_loc_id,
    ml.oris_code,
    ml.location_name,
    ml.unit_id,
    NULL::character varying AS stack_pipe_id,
    up.prg_cd,
    up.class_cd AS class,
    up.unit_monitor_cert_begin_date,
    up.emissions_recording_begin_date,
    up.trueup_begin_year,
    up.unit_monitor_cert_deadline,
    up.non_egu_ind AS non_egu_flg,
    up.app_status_cd AS app_status,
    up.optin_ind,
    up.def_ind,
    up.def_end_date,
    up.end_date,
    ml.fac_id
   FROM camdecmpswks.vw_mp_monitor_location ml
     JOIN camd.unit_program up ON ml.unit_id = up.unit_id
     JOIN camd.unit u ON u.unit_id = ml.unit_id;
