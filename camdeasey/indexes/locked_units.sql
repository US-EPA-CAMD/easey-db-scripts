CREATE INDEX IF NOT EXISTS locked_units_idx001 
  ON camdeasey.locked_units (activity_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_locked_units 
  ON camdeasey.locked_units (unit_id);