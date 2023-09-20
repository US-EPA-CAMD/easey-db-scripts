ALTER TABLE IF EXISTS camdecmpswks.stack_pipe
    ADD CONSTRAINT pk_stack_pipe PRIMARY KEY (stack_pipe_id),
    ADD CONSTRAINT fk_stack_pipe_plant FOREIGN KEY (fac_id)
        REFERENCES camd.plant (fac_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_stack_pipe_fac_id
    ON camdecmpswks.stack_pipe USING btree
    (fac_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_stack_pipe_stack_name
    ON camdecmpswks.stack_pipe USING btree
    (stack_name COLLATE pg_catalog."default" ASC NULLS LAST);
