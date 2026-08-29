CREATE UNIQUE INDEX IF NOT EXISTS synchronization_detail_pk 
  ON camdeasey.synchronization_detail (synchronization_detail_id);

ALTER TABLE camdeasey.synchronization_detail
        ADD CONSTRAINT synchronization_detail_r01 FOREIGN KEY (mon_plan_id) 
            REFERENCES camdeasey.monitor_plan (mon_plan_id);