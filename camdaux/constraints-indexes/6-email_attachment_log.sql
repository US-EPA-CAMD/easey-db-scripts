ALTER TABLE camdaux.email_attachment_log
        ADD CONSTRAINT fk_email_attachment_log_email FOREIGN KEY (email_log_id) 
            REFERENCES camdaux.email_log (email_log_id);

CREATE INDEX IF NOT EXISTS idx_email_attachment_log_email 
  ON camdaux.email_attachment_log (email_log_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_email_attachment_log 
  ON camdaux.email_attachment_log (email_attachment_log_id);