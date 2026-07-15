ALTER TABLE camdeasey.unit_stack_configuration
        ADD CONSTRAINT unit_stack_configuration_sp_fk FOREIGN KEY (stack_pipe_id) 
            REFERENCES camdeasey.stack_pipe (stack_pipe_id);
ALTER TABLE camdeasey.unit_stack_configuration
        ADD CONSTRAINT unit_stack_configuration_un_fk FOREIGN KEY (unit_id) 
            REFERENCES camd.unit (unit_id);