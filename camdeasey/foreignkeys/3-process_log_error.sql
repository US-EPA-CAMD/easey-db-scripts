CREATE UNIQUE INDEX IF NOT EXISTS process_log_error_pk 
  ON camdeasey.process_log_error (process_log_error_id);

ALTER TABLE camdeasey.process_log_error
        ADD CONSTRAINT process_log_error_act_fk FOREIGN KEY (process_log_action_id) 
            REFERENCES camdeasey.process_log_action (process_log_action_id)
             ON DELETE CASCADE;