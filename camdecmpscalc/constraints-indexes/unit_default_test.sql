ALTER TABLE IF EXISTS camdecmpscalc.unit_default_test
    ADD CONSTRAINT pk_unit_default_test PRIMARY KEY (pk),
   	ADD CONSTRAINT fk_unit_default_test_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_unit_default_test_chk_session_id
    ON camdecmpscalc.unit_default_test USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_unit_default_test_unit_default_test_sum_id
    ON camdecmpscalc.unit_default_test USING btree
    (unit_default_test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
