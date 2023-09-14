ALTER TABLE IF EXISTS camdecmpswks.qa_supp_attribute
    ADD CONSTRAINT pk_qa_supp_attribute PRIMARY KEY (qa_supp_attribute_id),
    ADD CONSTRAINT fk_qa_supp_attribute_qa_supp_data FOREIGN KEY (qa_supp_data_id)
        REFERENCES camdecmpswks.qa_supp_data (qa_supp_data_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_qa_supp_attribute_qa_supp_data_id
    ON camdecmpswks.qa_supp_attribute USING btree
    (qa_supp_data_id COLLATE pg_catalog."default" ASC NULLS LAST);
