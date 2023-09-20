ALTER TABLE IF EXISTS camdecmpswks.monitor_location
    ADD CONSTRAINT pk_monitor_location PRIMARY KEY (mon_loc_id),
    ADD CONSTRAINT fk_monitor_location_stack_pipe FOREIGN KEY (stack_pipe_id)
        REFERENCES camdecmpswks.stack_pipe (stack_pipe_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_location_unit FOREIGN KEY (unit_id)
        REFERENCES camd.unit (unit_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_monitor_location_stack_pipe_id
    ON camdecmpswks.monitor_location USING btree
    (stack_pipe_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_location_unit_id
    ON camdecmpswks.monitor_location USING btree
    (unit_id ASC NULLS LAST);
