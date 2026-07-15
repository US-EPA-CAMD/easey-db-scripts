CREATE INDEX IF NOT EXISTS idx_transfer_session_tr_id 
  ON camdams.transfer_session_transaction (trans_id);
CREATE INDEX IF NOT EXISTS idx_transfer_session_tr_prg 
  ON camdams.transfer_session_transaction (prg_cd);
CREATE INDEX IF NOT EXISTS idx_transfer_session_tr_sess 
  ON camdams.transfer_session_transaction (transfer_session_id);
CREATE INDEX IF NOT EXISTS idx_transfer_session_tr_status 
  ON camdams.transfer_session_transaction (trans_status_cd);
CREATE INDEX IF NOT EXISTS idx_transfer_session_tr_xml 
  ON camdams.transfer_session_transaction (xml_log_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_transfer_session_tr 
  ON camdams.transfer_session_transaction (transfer_session_trans_id);

ALTER TABLE camdams.transfer_session_transaction
        ADD CONSTRAINT fk_transfer_session_tr_id FOREIGN KEY (trans_id) 
            REFERENCES camdams.transaction (trans_id);
ALTER TABLE camdams.transfer_session_transaction
        ADD CONSTRAINT fk_transfer_session_tr_prg FOREIGN KEY (prg_cd) 
            REFERENCES camdmd.program_code (prg_cd);
ALTER TABLE camdams.transfer_session_transaction
        ADD CONSTRAINT fk_transfer_session_tr_session FOREIGN KEY (transfer_session_id) 
            REFERENCES camdams.transfer_session (transfer_session_id);
ALTER TABLE camdams.transfer_session_transaction
        ADD CONSTRAINT fk_transfer_session_tr_status FOREIGN KEY (trans_status_cd) 
            REFERENCES camdmd.transaction_status_code (trans_status_cd);
ALTER TABLE camdams.transfer_session_transaction
        ADD CONSTRAINT fk_transfer_session_tr_xml FOREIGN KEY (xml_log_id) 
            REFERENCES camdaux.xml_log (xml_log_id);