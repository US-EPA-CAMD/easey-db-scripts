ALTER TABLE camdaux.email_action_text
        ADD CONSTRAINT fk_email_action_text_action FOREIGN KEY (email_action_id) 
            REFERENCES camdaux.email_action (email_action_id);
ALTER TABLE camdaux.email_action_text
        ADD CONSTRAINT fk_email_action_text_text FOREIGN KEY (email_text_id) 
            REFERENCES camdaux.email_text (email_text_id);

CREATE INDEX IF NOT EXISTS idx_email_action_text_action 
  ON camdaux.email_action_text (email_action_id);
CREATE INDEX IF NOT EXISTS idx_email_action_text_text 
  ON camdaux.email_action_text (email_text_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_email_action_text 
  ON camdaux.email_action_text (email_action_text_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_email_action_order 
  ON camdaux.email_action_text (email_action_id,display_order);
CREATE UNIQUE INDEX IF NOT EXISTS uq_email_action_text 
  ON camdaux.email_action_text (email_action_id,email_text_id);