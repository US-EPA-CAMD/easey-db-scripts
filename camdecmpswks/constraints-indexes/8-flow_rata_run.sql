ALTER TABLE IF EXISTS camdecmpswks.flow_rata_run
    ADD CONSTRAINT pk_flow_rata_run PRIMARY KEY (flow_rata_run_id),
    ADD CONSTRAINT fk_flow_rata_run_rata_run FOREIGN KEY (rata_run_id)
        REFERENCES camdecmpswks.rata_run (rata_run_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_flow_rata_run_rata_run_id
    ON camdecmpswks.flow_rata_run USING btree
    (rata_run_id COLLATE pg_catalog."default" ASC NULLS LAST);
