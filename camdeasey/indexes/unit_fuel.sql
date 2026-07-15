CREATE UNIQUE INDEX IF NOT EXISTS pk_unit_fuel 
  ON camdeasey.unit_fuel (uf_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_unit_fuel 
  ON camdeasey.unit_fuel (unit_id,fuel_type,begin_date);