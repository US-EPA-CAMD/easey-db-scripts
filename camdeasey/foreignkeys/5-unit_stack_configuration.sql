CREATE UNIQUE INDEX IF NOT EXISTS unit_stack_configuration_pk 
  ON camdeasey.unit_stack_configuration (config_id);
CREATE INDEX IF NOT EXISTS unit_stack_configuration_st_ix 
  ON camdeasey.unit_stack_configuration (stack_pipe_id);
CREATE INDEX IF NOT EXISTS unit_stack_configuration_un_ix 
  ON camdeasey.unit_stack_configuration (unit_id);
CREATE UNIQUE INDEX IF NOT EXISTS unit_stack_configuration_uq 
  ON camdeasey.unit_stack_configuration (stack_pipe_id,unit_id);

ALTER TABLE camdeasey.unit_stack_configuration
        ADD CONSTRAINT unit_stack_configuration_sp_fk FOREIGN KEY (stack_pipe_id) 
            REFERENCES camdeasey.stack_pipe (stack_pipe_id);
ALTER TABLE camdeasey.unit_stack_configuration
        ADD CONSTRAINT unit_stack_configuration_un_fk FOREIGN KEY (unit_id) 
            REFERENCES camd.unit (unit_id);