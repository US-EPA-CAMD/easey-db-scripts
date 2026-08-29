CREATE INDEX IF NOT EXISTS idx_transfer_session_ppl 
  ON camdams.transfer_session (ppl_id);
CREATE INDEX IF NOT EXISTS idx_transfer_session_status 
  ON camdams.transfer_session (trans_session_status_cd);
CREATE INDEX IF NOT EXISTS idx_transfer_session_xml 
  ON camdams.transfer_session (xml_log_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_transfer_session 
  ON camdams.transfer_session (transfer_session_id);

ALTER TABLE camdams.transfer_session
        ADD CONSTRAINT fk_transfer_session_ppl FOREIGN KEY (ppl_id) 
            REFERENCES camd.person (ppl_id);
ALTER TABLE camdams.transfer_session
        ADD CONSTRAINT fk_transfer_session_status FOREIGN KEY (trans_session_status_cd) 
            REFERENCES camdmd.transfer_session_status_code (trans_session_status_cd);
ALTER TABLE camdams.transfer_session
        ADD CONSTRAINT fk_transfer_session_xml FOREIGN KEY (xml_log_id) 
            REFERENCES camdaux.xml_log (xml_log_id);