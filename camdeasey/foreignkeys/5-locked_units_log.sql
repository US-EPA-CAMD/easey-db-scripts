CREATE INDEX IF NOT EXISTS idx_locked_units_log_4787 
  ON camdeasey.locked_units_log (activity_id);
CREATE INDEX IF NOT EXISTS locked_units_log_pk 
  ON camdeasey.locked_units_log (unit_id,activity_id);

ALTER TABLE camdeasey.locked_units_log
        ADD CONSTRAINT fk_locked_units_log_act FOREIGN KEY (activity_id) 
            REFERENCES camdeasey.activity_log (activity_id);
ALTER TABLE camdeasey.locked_units_log
        ADD CONSTRAINT fk_locked_units_log_unit FOREIGN KEY (unit_id) 
            REFERENCES camd.unit (unit_id);