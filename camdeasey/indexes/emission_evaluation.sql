CREATE INDEX IF NOT EXISTS emission_evaluation_pk 
  ON camdeasey.emission_evaluation (mon_plan_id,rpt_period_id);
CREATE INDEX IF NOT EXISTS emission_evaluation_prd_ix 
  ON camdeasey.emission_evaluation (rpt_period_id);
CREATE INDEX IF NOT EXISTS emission_evaluation_sub_ix 
  ON camdeasey.emission_evaluation (submission_id);