ALTER TABLE camdeasey.submission_log
        ADD CONSTRAINT submission_log_css_fk FOREIGN KEY (check_session_severity_cd) 
            REFERENCES camdeaseymd.severity_code (severity_cd);
ALTER TABLE camdeasey.submission_log
        ADD CONSTRAINT submission_log_fac_fk FOREIGN KEY (fac_id) 
            REFERENCES camd.plant (fac_id);
ALTER TABLE camdeasey.submission_log
        ADD CONSTRAINT submission_log_prd_fk FOREIGN KEY (rpt_period_id) 
            REFERENCES camdeaseymd.reporting_period (rpt_period_id);
ALTER TABLE camdeasey.submission_log
        ADD CONSTRAINT submission_log_sev_fk FOREIGN KEY (severity_cd) 
            REFERENCES camdeaseymd.severity_code (severity_cd);