ALTER TABLE IF EXISTS camdecmpswks.linearity_summary
    ADD CONSTRAINT pk_linearity_summary PRIMARY KEY (lin_sum_id),
    ADD CONSTRAINT fk_linearity_summary_gas_level_code FOREIGN KEY (gas_level_cd)
        REFERENCES camdecmpsmd.gas_level_code (gas_level_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_linearity_summary_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_linearity_summary_gas_level_cd
    ON camdecmpswks.linearity_summary USING btree
    (gas_level_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_linearity_summary_test_sum_id
    ON camdecmpswks.linearity_summary USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
