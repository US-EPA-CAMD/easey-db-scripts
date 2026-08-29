CREATE UNIQUE INDEX IF NOT EXISTS monitor_location_pk 
  ON camdeasey.monitor_location (mon_loc_id);
CREATE INDEX IF NOT EXISTS monitor_location_stp_ix 
  ON camdeasey.monitor_location (stack_pipe_id);
CREATE INDEX IF NOT EXISTS monitor_location_unt_ix 
  ON camdeasey.monitor_location (unit_id);