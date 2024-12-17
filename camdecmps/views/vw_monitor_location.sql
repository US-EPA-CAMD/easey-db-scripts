-- camdecmps.vw_monitor_location source
CREATE OR REPLACE VIEW camdecmps.vw_monitor_location
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
   FROM   camdecmps.monitor_location ml
              LEFT JOIN camd.unit u
                        ON u.unit_id = ml.unit_id
              LEFT JOIN camdecmps.stack_pipe sp
                        ON sp.stack_pipe_id::text = ml.stack_pipe_id::text
        JOIN camd.plant p
   ON p.fac_id in ( u.fac_id, sp.fac_id );