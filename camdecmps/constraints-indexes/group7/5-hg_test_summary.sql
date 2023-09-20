ALTER TABLE IF EXISTS camdecmps.hg_test_summary
    ADD CONSTRAINT pk_hg_test_summary PRIMARY KEY (hg_test_sum_id),
    ADD CONSTRAINT fk_hg_test_summary_gas_level_code FOREIGN KEY (gas_level_cd)
        REFERENCES camdecmpsmd.gas_level_code (gas_level_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_hg_test_summary_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmps.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_hg_test_summary_test_sum_id
    ON camdecmps.hg_test_summary USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hg_test_summary_gas_level_cd
    ON camdecmps.hg_test_summary USING btree
    (gas_level_cd COLLATE pg_catalog."default" ASC NULLS LAST);
