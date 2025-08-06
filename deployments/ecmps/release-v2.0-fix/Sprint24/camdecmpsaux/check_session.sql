ALTER TABLE IF EXISTS camdecmpsaux.check_session
    ADD COLUMN evaluation_id bigint,
    ADD CONSTRAINT fk_check_session_evaluation_queue FOREIGN KEY (evaluation_id)
        REFERENCES camdecmpsaux.evaluation_queue (evaluation_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_check_session_evaluation_id
    ON camdecmpsaux.check_session USING btree
    (evaluation_id ASC NULLS LAST);

COMMENT ON COLUMN camdecmpsaux.check_session.evaluation_id
    IS ' Unique identifier of an evaluation queue record.';