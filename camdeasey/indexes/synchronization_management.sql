CREATE INDEX IF NOT EXISTS idx_monitor_plan_id_sync_man 
  ON camdeasey.synchronization_management (mon_plan_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_synchronization_management 
  ON camdeasey.synchronization_management (synchronization_management_id);