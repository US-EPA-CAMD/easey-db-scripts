ALTER TABLE camdaux.email_log
        ADD CONSTRAINT fk_email_log_action FOREIGN KEY (email_action_id) 
            REFERENCES camdaux.email_action (email_action_id);
ALTER TABLE camdaux.email_log
        ADD CONSTRAINT fk_email_log_event FOREIGN KEY (event_log_id) 
            REFERENCES camdaux.event_log (event_log_id);
ALTER TABLE camdaux.email_log
        ADD CONSTRAINT fk_email_log_xml_log FOREIGN KEY (xml_log_id) 
            REFERENCES camdaux.xml_log (xml_log_id);

CREATE INDEX IF NOT EXISTS idx_email_log_action 
  ON camdaux.email_log (email_action_id);
CREATE INDEX IF NOT EXISTS idx_email_log_event 
  ON camdaux.email_log (event_log_id);
CREATE INDEX IF NOT EXISTS idx_email_log_xml_log 
  ON camdaux.email_log (xml_log_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_email_log 
  ON camdaux.email_log (email_log_id);