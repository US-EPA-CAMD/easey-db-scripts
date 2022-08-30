CREATE OR REPLACE VIEW camdecmpswks.vw_monitor_location_merged (mon_loc_id, location_name) AS
SELECT
    ml.mon_loc_id, COALESCE(u.unitid, sp.stack_name) AS location_name
    FROM camdecmpswks.monitor_location AS ml
    LEFT OUTER JOIN camd.unit AS u
        ON ml.unit_id = u.unit_id
    LEFT OUTER JOIN camdecmpswks.stack_pipe AS sp
        ON sp.stack_pipe_id = ml.stack_pipe_id