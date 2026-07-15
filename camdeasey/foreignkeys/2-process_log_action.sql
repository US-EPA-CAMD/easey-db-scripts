CREATE UNIQUE INDEX IF NOT EXISTS process_log_action_pk 
  ON camdeasey.process_log_action (process_log_action_id);

ALTER TABLE camdeasey.process_log_action
        ADD CONSTRAINT process_log_action_act_fk FOREIGN KEY (process_log_id) 
            REFERENCES camdeasey.process_log (process_log_id)
             ON DELETE CASCADE;