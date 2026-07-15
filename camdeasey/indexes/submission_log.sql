CREATE INDEX IF NOT EXISTS submission_log_add_ix 
  ON camdeasey.submission_log (trunc("add_date"));
CREATE INDEX IF NOT EXISTS submission_log_cat_ix 
  ON camdeasey.submission_log (fac_id,file_type_cd,rpt_period_id,severity_cd);
CREATE INDEX IF NOT EXISTS submission_log_fac_ix 
  ON camdeasey.submission_log (fac_id);
CREATE INDEX IF NOT EXISTS submission_log_lst_ix 
  ON camdeasey.submission_log (mon_plan_id,add_date,file_type_cd,rpt_period_id);
CREATE UNIQUE INDEX IF NOT EXISTS submission_log_pk 
  ON camdeasey.submission_log (submission_id);
CREATE INDEX IF NOT EXISTS submission_log_pln_ix 
  ON camdeasey.submission_log (mon_plan_id);
CREATE INDEX IF NOT EXISTS submission_log_prd_ix 
  ON camdeasey.submission_log (rpt_period_id);
CREATE INDEX IF NOT EXISTS submission_log_set_ix 
  ON camdeasey.submission_log (submission_set_id);
CREATE INDEX IF NOT EXISTS submission_log_typ_ix 
  ON camdeasey.submission_log (file_type_cd);