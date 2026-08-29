CREATE INDEX IF NOT EXISTS idx_submission_queue_deta_5052 
  ON camdeasey.submission_queue_detail (activity_id);
CREATE INDEX IF NOT EXISTS idx_submission_queue_deta_5129 
  ON camdeasey.submission_queue_detail (queue_status_cd);
CREATE INDEX IF NOT EXISTS idx_submission_queue_deta_6351 
  ON camdeasey.submission_queue_detail (file_type_cd);
CREATE INDEX IF NOT EXISTS submission_queue_detail_idx01 
  ON camdeasey.submission_queue_detail (submission_set);
CREATE UNIQUE INDEX IF NOT EXISTS submission_queue_detail_pk 
  ON camdeasey.submission_queue_detail (submission_id);