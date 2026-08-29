CREATE INDEX IF NOT EXISTS monitor_plan_fac_ix 
  ON camdeasey.monitor_plan (fac_id);
CREATE INDEX IF NOT EXISTS monitor_plan_pk 
  ON camdeasey.monitor_plan (mon_plan_id);
CREATE INDEX IF NOT EXISTS monitor_plan_prd_beg_ix 
  ON camdeasey.monitor_plan (begin_rpt_period_id);
CREATE INDEX IF NOT EXISTS monitor_plan_prd_end_ix 
  ON camdeasey.monitor_plan (end_rpt_period_id);

ALTER TABLE camdeasey.monitor_plan
        ADD CONSTRAINT monitor_plan_fac_fk FOREIGN KEY (fac_id) 
            REFERENCES camd.plant (fac_id);
ALTER TABLE camdeasey.monitor_plan
        ADD CONSTRAINT monitor_plan_prd_beg_fk FOREIGN KEY (begin_rpt_period_id) 
            REFERENCES camdeaseymd.reporting_period (rpt_period_id);
ALTER TABLE camdeasey.monitor_plan
        ADD CONSTRAINT monitor_plan_prd_end_fk FOREIGN KEY (end_rpt_period_id) 
            REFERENCES camdeaseymd.reporting_period (rpt_period_id);