ALTER TABLE IF EXISTS camdecmpswks.linearity_injection
    ADD CONSTRAINT pk_linearity_injection PRIMARY KEY (lin_inj_id),
    ADD CONSTRAINT fk_linearity_injection_linearity_summary FOREIGN KEY (lin_sum_id)
        REFERENCES camdecmpswks.linearity_summary (lin_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_linearity_injection_lin_sum_id
    ON camdecmpswks.linearity_injection USING btree
    (lin_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);