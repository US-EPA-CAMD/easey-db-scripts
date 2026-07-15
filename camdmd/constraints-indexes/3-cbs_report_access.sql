ALTER TABLE camdmd.cbs_report_access
        ADD CONSTRAINT fk_cbs_report_access_report FOREIGN KEY (cbs_report_id) 
            REFERENCES camdmd.cbs_report (cbs_report_id);
ALTER TABLE camdmd.cbs_report_access
        ADD CONSTRAINT fk_cbs_report_security_group FOREIGN KEY (security_group_cd) 
            REFERENCES camdmd.security_group_code (security_group_cd);

CREATE UNIQUE INDEX IF NOT EXISTS pk_cbs_report_access 
  ON camdmd.cbs_report_access (cbs_report_id,security_group_cd);