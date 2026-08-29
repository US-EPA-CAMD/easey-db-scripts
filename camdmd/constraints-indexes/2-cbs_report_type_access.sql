ALTER TABLE camdmd.cbs_report_type_access
        ADD CONSTRAINT fk_cbs_report_access_sgcdsxc FOREIGN KEY (security_group_cd) 
            REFERENCES camdmd.security_group_code (security_group_cd);

CREATE UNIQUE INDEX IF NOT EXISTS pk_cbs_report_type_access 
  ON camdmd.cbs_report_type_access (cbs_report_type_cd,security_group_cd);