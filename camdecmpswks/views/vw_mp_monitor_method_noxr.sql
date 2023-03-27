-- View: camdecmpswks.vw_mp_monitor_method_noxr

DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_method_noxr;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_method_noxr
 AS
 SELECT monitor_method.mon_method_id,
    monitor_plan.mon_plan_id,
    monitor_location.mon_loc_id,
    monitor_method.parameter_cd,
    monitor_method.sub_data_cd,
    monitor_method.bypass_approach_cd,
    monitor_method.method_cd,
    monitor_method.begin_date,
    monitor_method.begin_hour,
    monitor_method.end_date,
    monitor_method.end_hour
   FROM camdecmpswks.monitor_location
     JOIN camdecmpswks.monitor_method ON monitor_location.mon_loc_id::text = monitor_method.mon_loc_id::text
     JOIN camdecmpswks.monitor_plan_location ON monitor_location.mon_loc_id::text = monitor_plan_location.mon_loc_id::text
     JOIN camdecmpswks.monitor_plan ON monitor_plan_location.mon_plan_id::text = monitor_plan.mon_plan_id::text
  WHERE monitor_method.parameter_cd::text = 'NOXR'::text;
