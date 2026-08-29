ALTER TABLE camdaux.email_send_queue
        ADD CONSTRAINT fk_email_send_queue_email FOREIGN KEY (email_log_id) 
            REFERENCES camdaux.email_log (email_log_id);
ALTER TABLE camdaux.email_send_queue
        ADD CONSTRAINT fk_email_send_queue_xml_log FOREIGN KEY (merged_xml_log_id) 
            REFERENCES camdaux.xml_log (xml_log_id);

CREATE UNIQUE INDEX IF NOT EXISTS pk_email_send_queue 
  ON camdaux.email_send_queue (email_log_id);