-- View: camdecmpswks.vw_mp_monitor_qualification

DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_qualification;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_qualification
 AS
 SELECT monitor_qualification.mon_qual_id,
    monitor_plan.mon_plan_id,
    monitor_location.mon_loc_id,
    monitor_qualification.qual_type_cd,
    monitor_qualification.begin_date,
    monitor_qualification.end_date,
    COALESCE(stack_pipe.stack_name, unit.unitid) AS location_id,
    COALESCE(stack_pipe.fac_id, unit.fac_id) AS fac_id
   FROM camdecmpswks.monitor_location
     JOIN camdecmpswks.monitor_qualification ON monitor_location.mon_loc_id::text = monitor_qualification.mon_loc_id::text
     JOIN camdecmpswks.monitor_plan_location ON monitor_location.mon_loc_id::text = monitor_plan_location.mon_loc_id::text
     JOIN camdecmpswks.monitor_plan ON monitor_plan_location.mon_plan_id::text = monitor_plan.mon_plan_id::text
     LEFT JOIN camd.unit ON monitor_location.unit_id = unit.unit_id
     LEFT JOIN camdecmpswks.stack_pipe ON monitor_location.stack_pipe_id::text = stack_pipe.stack_pipe_id::text;
