ALTER TABLE camdeasey.synchronization_management
        ADD CONSTRAINT synchronization_management_r01 FOREIGN KEY (mon_plan_id) 
            REFERENCES camdeasey.monitor_plan (mon_plan_id);