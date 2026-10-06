-- View: camdecmpswks.vw_monitor_location_merged

DROP VIEW IF EXISTS camdecmpswks.vw_monitor_location_merged CASCADE;

CREATE OR REPLACE VIEW camdecmpswks.vw_monitor_location_merged
 AS
 SELECT ml.mon_loc_id,
    COALESCE(u.unitid, sp.stack_name) AS location_name
   FROM camdecmpswks.monitor_location ml
     LEFT JOIN camd.unit u ON ml.unit_id = u.unit_id
     LEFT JOIN camdecmpswks.stack_pipe sp ON sp.stack_pipe_id::text = ml.stack_pipe_id::text;
