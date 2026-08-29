CREATE INDEX IF NOT EXISTS idx_monitor_plan_re_begin_rpt_ 
  ON camdeasey.monitor_plan_reporting_freq (begin_rpt_period_id);
CREATE INDEX IF NOT EXISTS idx_monitor_plan_re_end_rpt_pe 
  ON camdeasey.monitor_plan_reporting_freq (end_rpt_period_id);
CREATE INDEX IF NOT EXISTS idx_monitor_plan_re_mon_plan_i 
  ON camdeasey.monitor_plan_reporting_freq (mon_plan_id);
CREATE INDEX IF NOT EXISTS idx_monitor_plan_re_report_fre 
  ON camdeasey.monitor_plan_reporting_freq (report_freq_cd);
CREATE INDEX IF NOT EXISTS pk_monitor_plan_reporting_freq 
  ON camdeasey.monitor_plan_reporting_freq (mon_plan_rf_id);