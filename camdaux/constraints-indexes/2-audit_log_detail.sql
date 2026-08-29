ALTER TABLE camdaux.audit_log_detail
        ADD CONSTRAINT fk_audit_log_detail_audit_log FOREIGN KEY (audit_log_id) 
            REFERENCES camdaux.audit_log (audit_log_id);

CREATE INDEX IF NOT EXISTS idx_audit_log_detail_audit_log 
  ON camdaux.audit_log_detail (audit_log_id);
CREATE INDEX IF NOT EXISTS idx_audit_log_detail_column 
  ON camdaux.audit_log_detail (column_name);
CREATE INDEX IF NOT EXISTS idx_audit_log_detail_new_value 
  ON camdaux.audit_log_detail (new_value);
CREATE INDEX IF NOT EXISTS idx_audit_log_detail_old_value 
  ON camdaux.audit_log_detail (old_value);
CREATE UNIQUE INDEX IF NOT EXISTS pk_audit_log_detail 
  ON camdaux.audit_log_detail (audit_log_detail_id);