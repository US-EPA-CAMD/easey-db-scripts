ALTER TABLE camdeasey.stack_pipe
        ADD CONSTRAINT stack_pipe_fac_fk FOREIGN KEY (fac_id) 
            REFERENCES camd.plant (fac_id);