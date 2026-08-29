ALTER TABLE camdeasey.monitor_location
        ADD CONSTRAINT monitor_location_stp_fk FOREIGN KEY (stack_pipe_id) 
            REFERENCES camdeasey.stack_pipe (stack_pipe_id);
ALTER TABLE camdeasey.monitor_location
        ADD CONSTRAINT monitor_location_unt_fk FOREIGN KEY (unit_id) 
            REFERENCES camd.unit (unit_id);