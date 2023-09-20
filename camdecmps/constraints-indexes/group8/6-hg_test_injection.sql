ALTER TABLE IF EXISTS camdecmps.hg_test_injection
    ADD CONSTRAINT pk_hg_test_injection PRIMARY KEY (hg_test_inj_id),
    ADD CONSTRAINT fk_hg_test_injection_hg_test_summary FOREIGN KEY (hg_test_sum_id)
        REFERENCES camdecmps.hg_test_summary (hg_test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_hg_test_injection_hg_test_sum_id
    ON camdecmps.hg_test_injection USING btree
    (hg_test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
