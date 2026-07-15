ALTER TABLE camdaux.event_log
        ADD CONSTRAINT fk_event_log_event_action FOREIGN KEY (event_action_id) 
            REFERENCES camdmd.event_action (event_action_id);
ALTER TABLE camdaux.event_log
        ADD CONSTRAINT fk_event_log_person FOREIGN KEY (ppl_id) 
            REFERENCES camd.person (ppl_id);
ALTER TABLE camdaux.event_log
        ADD CONSTRAINT fk_event_log_xml_log FOREIGN KEY (xml_log_id) 
            REFERENCES camdaux.xml_log (xml_log_id);

CREATE INDEX IF NOT EXISTS idx_event_log_add_date 
  ON camdaux.event_log (add_date);
CREATE INDEX IF NOT EXISTS idx_event_log_event_action 
  ON camdaux.event_log (event_action_id);
CREATE INDEX IF NOT EXISTS idx_event_log_userid 
  ON camdaux.event_log (userid);
CREATE INDEX IF NOT EXISTS idx_event_log_xml_log 
  ON camdaux.event_log (xml_log_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_event_log 
  ON camdaux.event_log (event_log_id);