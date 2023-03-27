-- View: camdecmpswks.vw_location_operating_status

DROP VIEW IF EXISTS camdecmpswks.vw_location_operating_status;

CREATE OR REPLACE VIEW camdecmpswks.vw_location_operating_status
 AS
 SELECT up.unit_op_status_id AS uos_id,
    ml.oris_code,
    ml.location_identifier,
    ml.mon_loc_id,
    ml.fac_id,
    up.unit_id,
    u.unitid,
    up.op_status_cd,
        CASE
            WHEN usc.begin_date IS NULL THEN up.begin_date
            WHEN up.begin_date IS NULL THEN usc.begin_date
            WHEN up.begin_date >= usc.begin_date THEN up.begin_date
            ELSE usc.begin_date
        END AS begin_date,
        CASE
            WHEN usc.end_date IS NULL THEN up.end_date
            WHEN up.end_date IS NULL THEN usc.end_date
            WHEN up.end_date <= usc.end_date THEN up.end_date
            ELSE usc.end_date
        END AS end_date
   FROM camdecmpswks.vw_monitor_location ml
     JOIN camdecmpswks.unit_stack_configuration usc ON ml.stack_pipe_id::text = usc.stack_pipe_id::text
     JOIN camd.unit_op_status up ON usc.unit_id = up.unit_id
     JOIN camd.unit u ON u.unit_id = usc.unit_id
  WHERE (usc.end_date IS NULL OR up.begin_date <= usc.end_date) AND (up.end_date IS NULL OR up.end_date >= usc.begin_date)
UNION
 SELECT up.unit_op_status_id AS uos_id,
    ml.oris_code,
    ml.location_identifier,
    ml.mon_loc_id,
    ml.fac_id,
    up.unit_id,
    u.unitid,
    up.op_status_cd,
    up.begin_date,
    up.end_date
   FROM camdecmpswks.vw_monitor_location ml
     JOIN camd.unit_op_status up ON ml.unit_id = up.unit_id
     JOIN camd.unit u ON u.unit_id = ml.unit_id;
