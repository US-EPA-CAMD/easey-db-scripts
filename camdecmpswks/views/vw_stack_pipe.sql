-- View: camdecmpswks.vw_stack_pipe

-- DROP VIEW camdecmpswks.vw_stack_pipe;

CREATE OR REPLACE VIEW camdecmpswks.vw_stack_pipe
 AS
 SELECT sp.stack_pipe_id,
    ml.mon_loc_id,
    sp.fac_id,
    sp.stack_name,
    sp.active_date,
    sp.retire_date
   FROM camdecmpswks.stack_pipe sp
     JOIN camdecmpswks.vw_monitor_location ml ON sp.stack_pipe_id::text = ml.stack_pipe_id::text;
