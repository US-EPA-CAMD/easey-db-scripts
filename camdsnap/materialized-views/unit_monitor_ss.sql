create materialized view camdsnap.UNIT_MONITOR_SS 
as 
select  unm.config_id,
        unm.mon_loc_id,
        unm.unit_id,
        unm.edr_end_date,
        unm.begin_date,
        unm.userid,
        unm.add_date,
        unm.update_date,
        now() as refresh_time
  from  (
            select  usc.config_id,
                    loc.mon_loc_id,
                    usc.unit_id,
                    usc.end_date as edr_end_date,
                    usc.begin_date,
                    usc.userid,
                    usc.add_date,
                    usc.update_date
              from  camdecmps.UNIT_STACK_CONFIGURATION usc
                    join camdecmps.STACK_PIPE stp
                      on stp.stack_pipe_id = usc.stack_pipe_id
                    join camdecmps.MONITOR_LOCATION loc
                      on loc.stack_pipe_id = stp.stack_pipe_id
        ) unm;


comment on materialized view camdsnap.UNIT_MONITOR_SS is 'snapshot table for snapshot CAMDSNAP.UNIT_MONITOR_SS';
