ALTER TABLE camdeasey.process_log_action
        ADD CONSTRAINT process_log_action_act_fk FOREIGN KEY (process_log_id) 
            REFERENCES camdeasey.process_log (process_log_id)
             ON DELETE CASCADE;