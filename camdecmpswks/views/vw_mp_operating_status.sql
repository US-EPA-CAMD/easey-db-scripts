CREATE OR REPLACE VIEW camdecmpswks.vw_mp_operating_status (mon_loc_id, unit_id, unitid, op_status_cd, begin_date, mon_plan_id, end_date, uos_id) AS
SELECT
    monitor_location.mon_loc_id, unit.unit_id, unit.unitid, unit_op_status.op_status_cd, unit_op_status.begin_date, monitor_plan.mon_plan_id, unit_op_status.end_date, unit_op_status.uos_id
    FROM camdecmpswks.monitor_plan_location
    INNER JOIN camdecmpswks.monitor_location
        ON monitor_plan_location.mon_loc_id = monitor_location.mon_loc_id
    INNER JOIN camdecmpswks.monitor_plan
        ON monitor_plan_location.mon_plan_id = monitor_plan.mon_plan_id
    INNER JOIN camd.unit_op_status
    INNER JOIN camd.unit
        ON unit_op_status.unit_id = unit.unit_id
        ON monitor_location.unit_id = unit.unit_id;