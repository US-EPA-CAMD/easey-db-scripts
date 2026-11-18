create materialized view camdsnap.MONITOR_PLAN_REPORTING_FREQ_SS
as 
select  frq.mon_plan_rf_id,
        frq.mon_plan_id,
        frq.report_freq_cd,
        frq.end_rpt_period_id,
        frq.begin_rpt_period_id,
        frq.userid,
        frq.add_date,
        frq.update_date,
        now() as refresh_time
  from  camdecmps.MONITOR_PLAN_REPORTING_FREQ frq;


comment on materialized view camdsnap.MONITOR_PLAN_REPORTING_FREQ_SS is 'snapshot table for snapshot CAMDSNAP.MONITOR_PLAN_REPORTING_FREQ_SS';
