-- View: camdecmpswks.vw_unit_op_status

-- DROP VIEW camdecmpswks.vw_unit_op_status;

CREATE OR REPLACE VIEW camdecmpswks.vw_unit_op_status
 AS
 SELECT ml.mon_loc_id,
    u.unit_id,
    u.unitid,
    uos.op_status_cd,
    uos.begin_date,
    uos.end_date,
    uos.unit_op_status_id,
    ml.oris_code,
    ml.location_identifier,
    ml.fac_id
   FROM camdecmpswks.vw_monitor_location ml
     JOIN (camd.unit_op_status uos
     JOIN camd.unit u ON uos.unit_id = u.unit_id) ON ml.unit_id = u.unit_id;
--MAY NEED TO CHANGE JOIN TO THE FOLLOWING IF ABOVE PRESENTS PROBLEMS
-- FROM  camdecmpswks.vw_monitor_location ml
--   JOIN  camd.unit u on u.unit_id = ml.unit_id
--   JOIN  camd.unit_op_status uos on uos.unit_id = u.unit_id
