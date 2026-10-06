-- View: camdecmpswks.vw_monitor_location
DROP VIEW IF EXISTS camdecmpswks.vw_monitor_location CASCADE;

CREATE OR REPLACE VIEW camdecmpswks.vw_monitor_location
AS SELECT  ml.mon_loc_id,
           p.oris_code,
           p.facility_name,
           COALESCE( sp.stack_name, u.unitid ) AS location_identifier,
           p.fac_id,
           p.state,
           p.county_cd,
           u.unit_id,
           sp.stack_pipe_id,
           u.non_load_based_ind,
           sp.active_date,
           sp.retire_date,
           u.unitid,
           sp.stack_name,
           u.comr_op_date,
           u.comm_op_date
   FROM   camdecmpswks.monitor_location ml
              LEFT JOIN camdecmpswks.unit u ON ml.unit_id = u.unit_id
              LEFT JOIN camdecmpswks.stack_pipe sp ON ml.stack_pipe_id::text = sp.stack_pipe_id::text
        JOIN camd.plant p
   ON p.fac_id in ( u.fac_id, sp.fac_id );