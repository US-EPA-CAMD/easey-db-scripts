CREATE INDEX IF NOT EXISTS summary_value_loc_ix 
  ON camdeasey.summary_value (mon_loc_id);
CREATE INDEX IF NOT EXISTS summary_value_par_ix 
  ON camdeasey.summary_value (parameter_cd);
CREATE INDEX IF NOT EXISTS summary_value_pk 
  ON camdeasey.summary_value (sum_value_id);
CREATE INDEX IF NOT EXISTS summary_value_prd_id 
  ON camdeasey.summary_value (rpt_period_id);
CREATE UNIQUE INDEX IF NOT EXISTS summary_value_uq 
  ON camdeasey.summary_value (mon_loc_id,rpt_period_id,parameter_cd);