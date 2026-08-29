CREATE UNIQUE INDEX IF NOT EXISTS hour_unit_data_pk 
  ON camdeasey.hour_unit_data (unit_id,op_date,op_hour);