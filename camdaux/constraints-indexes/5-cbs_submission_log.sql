ALTER TABLE camdaux.cbs_submission_log
        ADD CONSTRAINT fk_cbs_submission_log_event FOREIGN KEY (event_log_id) 
            REFERENCES camdaux.event_log (event_log_id);
ALTER TABLE camdaux.cbs_submission_log
        ADD CONSTRAINT fk_cbs_submission_log_quest FOREIGN KEY (challenge_question_id) 
            REFERENCES camdmd.challenge_question (challenge_question_id);

CREATE INDEX IF NOT EXISTS idx_cbs_submission_log_event 
  ON camdaux.cbs_submission_log (event_log_id);
CREATE INDEX IF NOT EXISTS idx_cbs_submission_log_quest 
  ON camdaux.cbs_submission_log (challenge_question_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_cbs_submission_log 
  ON camdaux.cbs_submission_log (cbs_submission_log_id);