ALTER TABLE camdaux.email_action_group
        ADD CONSTRAINT fk_email_action_group_action FOREIGN KEY (email_action_id) 
            REFERENCES camdaux.email_action (email_action_id);
ALTER TABLE camdaux.email_action_group
        ADD CONSTRAINT fk_email_action_group_group FOREIGN KEY (email_group_id) 
            REFERENCES camdmd.email_group (email_group_id);

CREATE INDEX IF NOT EXISTS idx_email_action_group_action 
  ON camdaux.email_action_group (email_action_id);
CREATE INDEX IF NOT EXISTS idx_email_action_group_group 
  ON camdaux.email_action_group (email_group_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_email_action_group 
  ON camdaux.email_action_group (email_action_group_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_email_action_group 
  ON camdaux.email_action_group (email_action_id,email_group_id);