CREATE UNIQUE INDEX IF NOT EXISTS em_submission_access_u01 
  ON camdeasey.em_submission_access (mon_plan_id,rpt_period_id,access_begin_date,access_end_date);
CREATE INDEX IF NOT EXISTS em_submission_a_idx$$_15a60001 
  ON camdeasey.em_submission_access (mon_plan_id,rpt_period_id);
CREATE INDEX IF NOT EXISTS idx_em_submission_access_0729 
  ON camdeasey.em_submission_access (rpt_period_id);
CREATE INDEX IF NOT EXISTS idx_em_submission_a_em_status_ 
  ON camdeasey.em_submission_access (em_status_cd);
CREATE INDEX IF NOT EXISTS idx_em_submission_a_em_sub_typ 
  ON camdeasey.em_submission_access (em_sub_type_cd);
CREATE UNIQUE INDEX IF NOT EXISTS pk_em_submission_access 
  ON camdeasey.em_submission_access (em_sub_access_id);

ALTER TABLE camdeasey.em_submission_access
        ADD CONSTRAINT em_submission_access_r04 FOREIGN KEY (mon_plan_id) 
            REFERENCES camdeasey.monitor_plan (mon_plan_id);