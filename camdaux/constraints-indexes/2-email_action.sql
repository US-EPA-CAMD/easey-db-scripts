ALTER TABLE camdaux.email_action
        ADD CONSTRAINT fk_email_action_delivery_type FOREIGN KEY (delivery_type_cd) 
            REFERENCES camdmd.delivery_type_code (delivery_type_cd);
ALTER TABLE camdaux.email_action
        ADD CONSTRAINT fk_email_action_security_grp FOREIGN KEY (security_group_cd) 
            REFERENCES camdmd.security_group_code (security_group_cd);

CREATE INDEX IF NOT EXISTS idx_email_action_delivery_type 
  ON camdaux.email_action (delivery_type_cd);
CREATE INDEX IF NOT EXISTS idx_email_action_security_grp 
  ON camdaux.email_action (security_group_cd);
CREATE UNIQUE INDEX IF NOT EXISTS pk_email_action 
  ON camdaux.email_action (email_action_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_email_action 
  ON camdaux.email_action (event_action_id,security_group_cd);