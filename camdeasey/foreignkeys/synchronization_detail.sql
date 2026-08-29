ALTER TABLE camdeasey.synchronization_detail
        ADD CONSTRAINT synchronization_detail_r01 FOREIGN KEY (mon_plan_id) 
            REFERENCES camdeasey.monitor_plan (mon_plan_id);