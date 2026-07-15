CREATE INDEX IF NOT EXISTS idx_mm_monlocid 
  ON camdeasey.monitor_method (mon_loc_id);
CREATE INDEX IF NOT EXISTS idx_mm_paramcd 
  ON camdeasey.monitor_method (parameter_cd);
CREATE INDEX IF NOT EXISTS idx_monitor_method_bypass_app 
  ON camdeasey.monitor_method (bypass_approach_cd);
CREATE INDEX IF NOT EXISTS idx_monitor_method_method_cd 
  ON camdeasey.monitor_method (method_cd);
CREATE INDEX IF NOT EXISTS idx_monitor_method_sub_data_c 
  ON camdeasey.monitor_method (sub_data_cd);
CREATE INDEX IF NOT EXISTS monitor_method_idx$$_15f60005 
  ON camdeasey.monitor_method (begin_date,begin_hour,parameter_cd);
CREATE INDEX IF NOT EXISTS pk_monitor_method 
  ON camdeasey.monitor_method (mon_method_id);