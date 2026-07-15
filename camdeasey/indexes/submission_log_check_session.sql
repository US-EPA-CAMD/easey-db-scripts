CREATE UNIQUE INDEX IF NOT EXISTS pk_submission_log_check_sessio 
  ON camdeasey.submission_log_check_session (submission_id,chk_session_id);