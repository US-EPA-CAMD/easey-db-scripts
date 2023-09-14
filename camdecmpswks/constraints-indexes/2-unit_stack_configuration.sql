ALTER TABLE IF EXISTS camdecmpswks.unit_stack_configuration
    ADD CONSTRAINT pk_unit_stack_configuration PRIMARY KEY (config_id),
    ADD CONSTRAINT fk_unit_stack_configuration_stack_pipe FOREIGN KEY (stack_pipe_id)
        REFERENCES camdecmpswks.stack_pipe (stack_pipe_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_unit_stack_configuration_unit FOREIGN KEY (unit_id)
        REFERENCES camd.unit (unit_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_unit_stack_configuration_stack_pipe_id
    ON camdecmpswks.unit_stack_configuration USING btree
    (stack_pipe_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_unit_stack_configuration_unit_id
    ON camdecmpswks.unit_stack_configuration USING btree
    (unit_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_unit_stack_configuration_stack_pipe_id_unit_id
    ON camdecmpswks.unit_stack_configuration USING btree
    (stack_pipe_id COLLATE pg_catalog."default" ASC NULLS LAST, unit_id ASC NULLS LAST);
