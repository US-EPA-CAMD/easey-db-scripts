CREATE INDEX IF NOT EXISTS idx_unit_control_ce_param 
  ON camdeasey.unit_control (ce_param);
CREATE INDEX IF NOT EXISTS idx_unit_control_indicator_cd 
  ON camdeasey.unit_control (indicator_cd);
CREATE INDEX IF NOT EXISTS idx_unit_control_unit 
  ON camdeasey.unit_control (unit_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_unit_control 
  ON camdeasey.unit_control (ctl_id);