-- View: camdecmpswks.vw_location_program

DROP VIEW IF EXISTS camdecmpswks.vw_location_program;

CREATE OR REPLACE VIEW camdecmpswks.vw_location_program
 AS
 SELECT up.up_id,
    ml.oris_code,
    ml.location_identifier,
    ml.mon_loc_id,
    ml.fac_id,
    up.unit_id,
    u.unitid,
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
    NULL::date AS unit_monitoring_begin_date,
        CASE
            WHEN usc.end_date IS NULL THEN up.end_date
            WHEN up.end_date IS NULL THEN usc.end_date
            WHEN up.end_date <= usc.end_date THEN up.end_date
            ELSE usc.end_date
        END AS end_date
   FROM camdecmpswks.vw_monitor_location ml
     JOIN camdecmpswks.unit_stack_configuration usc ON ml.stack_pipe_id::text = usc.stack_pipe_id::text
     JOIN camd.unit_program up ON usc.unit_id = up.unit_id AND (usc.end_date IS NULL OR up.unit_monitor_cert_begin_date <= usc.end_date) AND (up.end_date IS NULL OR up.end_date >= usc.begin_date)
     JOIN camd.unit u ON u.unit_id = usc.unit_id
UNION
 SELECT up.up_id,
    ml.oris_code,
    ml.location_identifier,
    ml.mon_loc_id,
    ml.fac_id,
    up.unit_id,
    u.unitid,
    up.prg_cd,
    up.class_cd AS class,
    up.unit_monitor_cert_begin_date,
    up.emissions_recording_begin_date,
        CASE
            WHEN up.emissions_recording_begin_date IS NOT NULL THEN up.emissions_recording_begin_date
            WHEN up.unit_monitor_cert_deadline IS NOT NULL THEN up.unit_monitor_cert_deadline
            WHEN up.unit_monitor_cert_begin_date IS NOT NULL THEN up.unit_monitor_cert_begin_date + 180
            ELSE NULL::date
        END AS unit_monitoring_begin_date,
    up.end_date
   FROM camdecmpswks.vw_monitor_location ml
     JOIN camd.unit_program up ON ml.unit_id = up.unit_id
     JOIN camd.unit u ON u.unit_id = ml.unit_id;
