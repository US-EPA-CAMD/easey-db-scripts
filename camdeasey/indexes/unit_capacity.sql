CREATE INDEX IF NOT EXISTS idx_unit_capacity_unit 
  ON camdeasey.unit_capacity (unit_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_unit_capacity 
  ON camdeasey.unit_capacity (unit_cap_id);