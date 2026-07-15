CREATE UNIQUE INDEX IF NOT EXISTS quarter_unit_data_pk 
  ON camdeasey.quarter_unit_data (unit_id,op_year,op_quarter);