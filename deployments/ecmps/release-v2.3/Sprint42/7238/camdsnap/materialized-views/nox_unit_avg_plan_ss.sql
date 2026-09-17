create materialized view camdsnap.NOX_UNIT_AVG_PLAN_SS
as 
select  nap.unit_avg_plan_id,
        nap.unit_id,
        nap.avg_plan_id,
        nap.begin_date,
        nap.end_date,
        nap.add_date,
        nap.update_date,
        nap.userid,
        now() as refresh_time
  from  camdams.NOX_UNIT_AVG_PLAN nap;


comment on materialized view camdsnap.NOX_UNIT_AVG_PLAN_SS is 'snapshot table for snapshot CAMDSNAP.NOX_UNIT_AVG_PLAN_SS';
