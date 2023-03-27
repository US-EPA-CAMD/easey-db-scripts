-- View: camdecmpswks.vw_mp_operating_status

DROP VIEW IF EXISTS camdecmpswks.vw_mp_operating_status;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_operating_status
 AS
 SELECT monitor_location.mon_loc_id,
    unit.unit_id,
    unit.unitid,
    unit_op_status.op_status_cd,
    unit_op_status.begin_date,
    monitor_plan.mon_plan_id,
    unit_op_status.end_date,
    unit_op_status.unit_op_status_id AS uos_id
   FROM camdecmpswks.monitor_plan_location
     JOIN camdecmpswks.monitor_location ON monitor_plan_location.mon_loc_id::text = monitor_location.mon_loc_id::text
     JOIN camdecmpswks.monitor_plan ON monitor_plan_location.mon_plan_id::text = monitor_plan.mon_plan_id::text
     JOIN (camd.unit_op_status
     JOIN camd.unit ON unit_op_status.unit_id = unit.unit_id) ON monitor_location.unit_id = unit.unit_id;
