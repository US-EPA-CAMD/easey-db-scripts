create materialized view camdsnap.MONITOR_LOCATION_SS 
as 
select  loc.mon_loc_id,
        fac.oris_code,
        coalesce( stp.stack_name, unt.unitid ) as location_id,
        unt.unit_id,
        stp.stack_pipe_id,
        coalesce( stp.fac_id, unt.fac_id ) as fac_id,
        coalesce( stp.active_date, opr.begin_date )  active_date,
        coalesce( stp.retire_date, ret.begin_date )  retire_date,
        loc.userid,
        coalesce( stp.add_date, unt.add_date ) as add_date,
        coalesce( stp.update_date, unt.update_date ) as update_date,
        now() as refresh_time
  from  camdecmps.MONITOR_LOCATION  loc
        left join camdecmps.STACK_PIPE stp
          on stp.stack_pipe_id = loc.stack_pipe_id
        left join camd.UNIT unt
          on unt.unit_id = loc.unit_id
        join camd.PLANT fac
          on fac.fac_id in (stp.fac_id, unt.fac_id)
        left join (
                    select  unit_id, 
                            min ( begin_date ) begin_date
                      from  camd.UNIT_OP_STATUS
                     where  op_status_cd = 'opr'
                     group
                        by  unit_id
                  ) opr
          on opr.unit_id = loc.unit_id
        left join (
                    select  unit_id,
                            min (begin_date) begin_date
                      from  camd.UNIT_OP_STATUS
                     where  op_status_cd = 'ret'
                     group
                        by  unit_id) ret
          on ret.unit_id = loc.unit_id;


comment on materialized view camdsnap.MONITOR_LOCATION_SS is 'snapshot table for snapshot CAMDSNAP.MONITOR_LOCATION_SS';
