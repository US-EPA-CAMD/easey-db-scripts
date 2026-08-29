CREATE INDEX IF NOT EXISTS idx_stack_pipe_fac_ix 
  ON camdeasey.stack_pipe (fac_id);
CREATE UNIQUE INDEX IF NOT EXISTS stack_pipe_pk 
  ON camdeasey.stack_pipe (stack_pipe_id);
CREATE UNIQUE INDEX IF NOT EXISTS stack_pipe_uq 
  ON camdeasey.stack_pipe (fac_id,stack_name);

ALTER TABLE camdeasey.stack_pipe
        ADD CONSTRAINT stack_pipe_fac_fk FOREIGN KEY (fac_id) 
            REFERENCES camd.plant (fac_id);