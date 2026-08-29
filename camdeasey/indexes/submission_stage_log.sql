CREATE INDEX IF NOT EXISTS idx_submission_stag_sub_detail 
  ON camdeasey.submission_stage_log (sub_detail_cd);
CREATE INDEX IF NOT EXISTS idx_submission_stag_sub_stage_ 
  ON camdeasey.submission_stage_log (sub_stage_cd);
CREATE INDEX IF NOT EXISTS idx_s_id_ssl_id 
  ON camdeasey.submission_stage_log (submission_id,sub_stage_log_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_submission_stage_log 
  ON camdeasey.submission_stage_log (sub_stage_log_id);
CREATE UNIQUE INDEX IF NOT EXISTS submission_stage_log_r01 
  ON camdeasey.submission_stage_log (submission_id,sub_stage_cd);