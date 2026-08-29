ALTER TABLE camdmd.cbs_report
        ADD CONSTRAINT fk_cbs_report_report_type FOREIGN KEY (cbs_report_type_cd) 
            REFERENCES camdmd.cbs_report_type_code (cbs_report_type_cd);

CREATE INDEX IF NOT EXISTS idx_cbs_report_type 
  ON camdmd.cbs_report (cbs_report_type_cd);
CREATE UNIQUE INDEX IF NOT EXISTS pk_cbs_report 
  ON camdmd.cbs_report (cbs_report_id);