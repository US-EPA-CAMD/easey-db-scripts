-- View: camdecmpswks.vw_mp_unit_stack_configuration

DROP VIEW IF EXISTS camdecmpswks.vw_mp_unit_stack_configuration;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_unit_stack_configuration
 AS
 SELECT DISTINCT mp.mon_plan_id,
    ml.mon_loc_id,
    usc.config_id,
    usc.begin_date,
    usc.end_date,
    sp.stack_name,
    u.unitid,
    sp.stack_pipe_id,
    u.unit_id,
    u.non_load_based_ind,
    ml1.mon_loc_id AS stack_pipe_mon_loc_id,
    sp.fac_id
   FROM camdecmpswks.stack_pipe sp
     JOIN (camdecmpswks.unit_stack_configuration usc
     JOIN (camd.unit u
     JOIN (camdecmpswks.monitor_plan_location mpl
     JOIN camdecmpswks.monitor_plan mp ON mpl.mon_plan_id::text = mp.mon_plan_id::text
     JOIN camdecmpswks.monitor_location ml ON mpl.mon_loc_id::text = ml.mon_loc_id::text) ON u.unit_id = ml.unit_id) ON usc.unit_id = u.unit_id) ON sp.stack_pipe_id::text = usc.stack_pipe_id::text
     JOIN camdecmpswks.monitor_location ml1 ON sp.stack_pipe_id::text = ml1.stack_pipe_id::text;
