ALTER TABLE camdaux.transfer_session_log
        ADD CONSTRAINT fk_trans_session_log_trans_err FOREIGN KEY (trans_error_cd) 
            REFERENCES camdmd.transaction_error_code (trans_error_cd);
ALTER TABLE camdaux.transfer_session_log
        ADD CONSTRAINT fk_trans_sess_log_status_cd FOREIGN KEY (trans_session_status_cd) 
            REFERENCES camdmd.transfer_session_status_code (trans_session_status_cd);
ALTER TABLE camdaux.transfer_session_log
        ADD CONSTRAINT fk_trans_sess_log_transct_stat FOREIGN KEY (trans_status_cd) 
            REFERENCES camdmd.transaction_status_code (trans_status_cd);
ALTER TABLE camdaux.transfer_session_log
        ADD CONSTRAINT fk_trans_sess_log_trans_sess FOREIGN KEY (transfer_session_id) 
            REFERENCES camdams.transfer_session (transfer_session_id);
ALTER TABLE camdaux.transfer_session_log
        ADD CONSTRAINT fk_trans_sess_log_trns_ss_trn FOREIGN KEY (transfer_session_trans_id) 
            REFERENCES camdams.transfer_session_transaction (transfer_session_trans_id);

CREATE INDEX IF NOT EXISTS idx_trans_session_log_trns_err 
  ON camdaux.transfer_session_log (trans_error_cd);
CREATE INDEX IF NOT EXISTS idx_trans_sess_log_status_cd 
  ON camdaux.transfer_session_log (trans_session_status_cd);
CREATE INDEX IF NOT EXISTS idx_trans_sess_log_trans_sess 
  ON camdaux.transfer_session_log (transfer_session_id);
CREATE INDEX IF NOT EXISTS idx_trans_sess_log_trnsct_stat 
  ON camdaux.transfer_session_log (trans_status_cd);
CREATE INDEX IF NOT EXISTS idx_trans_sess_log_trns_ss_trn 
  ON camdaux.transfer_session_log (transfer_session_trans_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_transfer_session_log 
  ON camdaux.transfer_session_log (transfer_session_log_id);