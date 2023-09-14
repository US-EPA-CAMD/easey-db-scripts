ALTER TABLE IF EXISTS camdecmpswks.rata
    ADD CONSTRAINT pk_rata PRIMARY KEY (rata_id),
    ADD CONSTRAINT fk_rata_rata_frequency_code FOREIGN KEY (rata_frequency_cd)
        REFERENCES camdecmpsmd.rata_frequency_code (rata_frequency_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_rata_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_rata_test_sum_id
    ON camdecmpswks.rata USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_rata_rata_frequency_cd
    ON camdecmpswks.rata USING btree
    (rata_frequency_cd COLLATE pg_catalog."default" ASC NULLS LAST);
