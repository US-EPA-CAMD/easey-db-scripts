ALTER TABLE IF EXISTS camdecmpscalc.flow_rata_run
    ADD CONSTRAINT pk_flow_rata_run PRIMARY KEY (pk),
   	ADD CONSTRAINT fk_flow_rata_run_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_flow_rata_run_chk_session_id
    ON camdecmpscalc.flow_rata_run USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_flow_rata_run_flow_rata_run_id
    ON camdecmpscalc.flow_rata_run USING btree
    (flow_rata_run_id COLLATE pg_catalog."default" ASC NULLS LAST);
