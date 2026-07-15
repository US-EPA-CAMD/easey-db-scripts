CREATE INDEX IF NOT EXISTS idx_check_session_1526 
  ON camdeasey.check_session (test_extension_exemption_id);
CREATE INDEX IF NOT EXISTS idx_check_session_2816 
  ON camdeasey.check_session (qa_cert_event_id);
CREATE INDEX IF NOT EXISTS idx_check_session_6459 
  ON camdeasey.check_session (mon_plan_id);
CREATE INDEX IF NOT EXISTS idx_check_session_7529 
  ON camdeasey.check_session (test_sum_id);
CREATE INDEX IF NOT EXISTS idx_check_session_8070 
  ON camdeasey.check_session (rpt_period_id);
CREATE INDEX IF NOT EXISTS idx_check_session_category_c 
  ON camdeasey.check_session (category_cd);
CREATE INDEX IF NOT EXISTS idx_check_session_process_cd 
  ON camdeasey.check_session (process_cd);
CREATE INDEX IF NOT EXISTS idx_check_session_severity_c 
  ON camdeasey.check_session (severity_cd);
CREATE INDEX IF NOT EXISTS pk_check_session 
  ON camdeasey.check_session (chk_session_id);