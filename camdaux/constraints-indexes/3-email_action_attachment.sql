ALTER TABLE camdaux.email_action_attachment
        ADD CONSTRAINT fk_email_action_attachment_at FOREIGN KEY (attachment_id) 
            REFERENCES camdmd.attachment (attachment_id);
ALTER TABLE camdaux.email_action_attachment
        ADD CONSTRAINT fk_email_action_attachment_em FOREIGN KEY (email_action_id) 
            REFERENCES camdaux.email_action (email_action_id);

CREATE INDEX IF NOT EXISTS idx_email_action_attachment_at 
  ON camdaux.email_action_attachment (attachment_id);
CREATE INDEX IF NOT EXISTS idx_email_action_attachment_em 
  ON camdaux.email_action_attachment (email_action_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_email_action_attachment 
  ON camdaux.email_action_attachment (email_action_attachment_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_email_action_attachment 
  ON camdaux.email_action_attachment (email_action_id,attachment_id);