CREATE UNIQUE INDEX IF NOT EXISTS monitor_location_pk 
  ON camdeasey.monitor_location (mon_loc_id);
CREATE INDEX IF NOT EXISTS monitor_location_stp_ix 
  ON camdeasey.monitor_location (stack_pipe_id);
CREATE INDEX IF NOT EXISTS monitor_location_unt_ix 
  ON camdeasey.monitor_location (unit_id);

ALTER TABLE camdeasey.monitor_location
        ADD CONSTRAINT monitor_location_stp_fk FOREIGN KEY (stack_pipe_id) 
            REFERENCES camdeasey.stack_pipe (stack_pipe_id);
ALTER TABLE camdeasey.monitor_location
        ADD CONSTRAINT monitor_location_unt_fk FOREIGN KEY (unit_id) 
            REFERENCES camd.unit (unit_id);