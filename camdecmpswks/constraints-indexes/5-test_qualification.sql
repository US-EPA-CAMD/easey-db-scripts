ALTER TABLE IF EXISTS camdecmpswks.test_qualification
    ADD CONSTRAINT pk_test_qualification PRIMARY KEY (test_qualification_id),
    ADD CONSTRAINT fk_test_qualification_test_claim_code FOREIGN KEY (test_claim_cd)
        REFERENCES camdecmpsmd.test_claim_code (test_claim_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_test_qualification_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_test_qualification_test_claim_cd
    ON camdecmpswks.test_qualification USING btree
    (test_claim_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_test_qualification_test_sum_id
    ON camdecmpswks.test_qualification USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
