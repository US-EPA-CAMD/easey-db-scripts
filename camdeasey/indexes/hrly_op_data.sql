CREATE INDEX IF NOT EXISTS hrly_op_data_emr_ix 
  ON camdeasey.hrly_op_data (rpt_period_id,mon_loc_id);
CREATE INDEX IF NOT EXISTS hrly_op_data_loc_ix 
  ON camdeasey.hrly_op_data (mon_loc_id);
CREATE INDEX IF NOT EXISTS hrly_op_data_pk 
  ON camdeasey.hrly_op_data (hour_id);
CREATE INDEX IF NOT EXISTS hrly_op_data_prd_ix 
  ON camdeasey.hrly_op_data (rpt_period_id);