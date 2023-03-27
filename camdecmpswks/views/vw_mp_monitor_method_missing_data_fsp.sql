-- View: camdecmpswks.vw_mp_monitor_method_missing_data_fsp

DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_method_missing_data_fsp;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_method_missing_data_fsp
 AS
 SELECT vw_mp_monitor_method.mon_method_id,
    vw_mp_monitor_method.mon_plan_id,
    vw_mp_monitor_method.mon_loc_id,
    vw_mp_monitor_method.parameter_cd,
    vw_mp_monitor_method.sub_data_cd,
    vw_mp_monitor_method.bypass_approach_cd,
    vw_mp_monitor_method.method_cd,
    vw_mp_monitor_method.begin_datehour,
    vw_mp_monitor_method.begin_date,
    vw_mp_monitor_method.begin_hour,
    vw_mp_monitor_method.end_datehour,
    vw_mp_monitor_method.end_date,
    vw_mp_monitor_method.end_hour,
    vw_mp_monitor_method.stack_pipe_id,
    vw_mp_monitor_method.stack_name,
    vw_mp_monitor_method.unit_id,
    vw_mp_monitor_method.unitid
   FROM camdecmpswks.vw_mp_monitor_method
  WHERE vw_mp_monitor_method.sub_data_cd::text = ANY (ARRAY['FSP75'::character varying::text, 'FSP75C'::character varying::text]);
