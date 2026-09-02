--------------------
-- Unique Indexes --
--------------------

create unique index MONITOR_PLAN_REPORTING_FREQ_SS_UQ on camdsnap.MONITOR_PLAN_REPORTING_FREQ_SS ( mon_plan_rf_id );


---------------------
-- General Indexes --
---------------------

create index MONITOR_PLAN_REPORTING_FREQ_SS_PRB_IX on camdsnap.MONITOR_PLAN_REPORTING_FREQ_SS ( begin_rpt_period_id );
create index MONITOR_PLAN_REPORTING_FREQ_SS_PRE_IX on camdsnap.MONITOR_PLAN_REPORTING_FREQ_SS ( end_rpt_period_id );
create index MONITOR_PLAN_REPORTING_FREQ_SS_PLN_IX on camdsnap.MONITOR_PLAN_REPORTING_FREQ_SS ( mon_plan_id );
