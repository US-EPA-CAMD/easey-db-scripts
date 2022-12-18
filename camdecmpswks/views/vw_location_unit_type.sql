-- View: camdecmpswks.vw_location_unit_type

DROP VIEW IF EXISTS camdecmpswks.vw_location_unit_type;

CREATE OR REPLACE VIEW camdecmpswks.vw_location_unit_type
 AS
 SELECT uc.unit_boiler_type_id,
    ml.oris_code,
    ml.location_identifier,
    uc.unit_id,
    ml.mon_loc_id,
    ml.fac_id,
    u.unitid,
    uc.unit_type_cd,
        CASE
            WHEN usc.begin_date IS NULL THEN uc.begin_date
            WHEN uc.begin_date IS NULL THEN usc.begin_date
            WHEN uc.begin_date >= usc.begin_date THEN uc.begin_date
            ELSE usc.begin_date
        END AS begin_date,
        CASE
            WHEN usc.end_date IS NULL THEN uc.end_date
            WHEN uc.end_date IS NULL THEN usc.end_date
            WHEN uc.end_date <= usc.end_date THEN uc.end_date
            ELSE usc.end_date
        END AS end_date
   FROM camdecmpswks.vw_monitor_location ml
     JOIN camdecmpswks.unit_stack_configuration usc ON ml.stack_pipe_id::text = usc.stack_pipe_id::text
     JOIN camd.unit_boiler_type uc ON usc.unit_id = uc.unit_id AND (uc.begin_date IS NULL OR usc.end_date IS NULL OR uc.begin_date <= usc.end_date) AND (uc.end_date IS NULL OR uc.end_date >= usc.begin_date)
     JOIN camd.unit u ON u.unit_id = usc.unit_id
UNION
 SELECT uc.unit_boiler_type_id,
    ml.oris_code,
    ml.location_identifier,
    uc.unit_id,
    ml.mon_loc_id,
    ml.fac_id,
    u.unitid,
    uc.unit_type_cd,
    uc.begin_date,
    uc.end_date
   FROM camdecmpswks.vw_monitor_location ml
     JOIN camd.unit_boiler_type uc ON ml.unit_id = uc.unit_id
     JOIN camd.unit u ON u.unit_id = ml.unit_id;
