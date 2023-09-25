ALTER TABLE IF EXISTS camdecmpscalc.qa_supp_attribute
    ADD CONSTRAINT pk_qa_supp_attribute PRIMARY KEY (pk),
   	ADD CONSTRAINT fk_qa_supp_attribute_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_qa_supp_attribute_chk_session_id
    ON camdecmpscalc.qa_supp_attribute USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_supp_attribute_test_sum_id
    ON camdecmpscalc.qa_supp_attribute USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
