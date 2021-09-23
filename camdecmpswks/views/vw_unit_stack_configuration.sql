-- View: camdecmpswks.vw_unit_stack_configuration

-- DROP VIEW camdecmpswks.vw_unit_stack_configuration;

CREATE OR REPLACE VIEW camdecmpswks.vw_unit_stack_configuration
 AS
 SELECT DISTINCT mlu.mon_loc_id,
    usc.config_id,
    usc.begin_date,
    usc.end_date,
    mls.location_identifier AS stack_name,
    mlu.location_identifier AS unitid,
    mls.stack_pipe_id,
    mlu.unit_id,
    mlu.non_load_based_ind,
    mls.mon_loc_id AS stack_pipe_mon_loc_id,
    mlu.fac_id
   FROM camdecmpswks.unit_stack_configuration usc
     JOIN camdecmpswks.vw_monitor_location mlu ON usc.unit_id = mlu.unit_id
     JOIN camdecmpswks.vw_monitor_location mls ON usc.stack_pipe_id::text = mls.stack_pipe_id::text;
