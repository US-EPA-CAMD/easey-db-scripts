create materialized view camdsnap.MONITOR_PLAN_LOCATION_SS
as 
select  mpl.monitor_plan_location_id,
        mpl.mon_plan_id,
        mpl.mon_loc_id,
        now() as refresh_time
  from  camdecmps.MONITOR_PLAN_LOCATION mpl;


comment on materialized view camdsnap.MONITOR_PLAN_LOCATION_SS is 'snapshot table for snapshot CAMDSNAP.MONITOR_PLAN_LOCATION_SS';
