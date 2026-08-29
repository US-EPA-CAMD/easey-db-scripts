CREATE INDEX IF NOT EXISTS idx_submission_queue_completed_time ON camdecmpsaux.submission_queue USING btree (completed_time);
CREATE INDEX IF NOT EXISTS  idx_submission_queue_started_time ON camdecmpsaux.submission_queue USING btree (started_time);
CREATE INDEX IF NOT EXISTS  idx_submission_queue_queued_time ON camdecmpsaux.submission_queue ((queued_time::date));