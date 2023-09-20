ALTER TABLE IF EXISTS camdecmps.trans_accuracy
    ADD CONSTRAINT pk_trans_accuracy PRIMARY KEY (trans_ac_id),
    ADD CONSTRAINT fk_trans_accuracy_accuracy_spec_code_high FOREIGN KEY (high_level_accuracy_spec_cd)
        REFERENCES camdecmpsmd.accuracy_spec_code (accuracy_spec_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_trans_accuracy_accuracy_spec_code_low FOREIGN KEY (low_level_accuracy_spec_cd)
        REFERENCES camdecmpsmd.accuracy_spec_code (accuracy_spec_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_trans_accuracy_accuracy_spec_code_mid FOREIGN KEY (mid_level_accuracy_spec_cd)
        REFERENCES camdecmpsmd.accuracy_spec_code (accuracy_spec_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_trans_accuracy_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmps.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_trans_accuracy_test_sum_id
    ON camdecmps.trans_accuracy USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_trans_accuracy_high_level_accuracy_spec_cd
    ON camdecmps.trans_accuracy USING btree
    (high_level_accuracy_spec_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_trans_accuracy_low_level_accuracy_spec_cd
    ON camdecmps.trans_accuracy USING btree
    (low_level_accuracy_spec_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_trans_accuracy_mid_level_accuracy_spec_cd
    ON camdecmps.trans_accuracy USING btree
    (mid_level_accuracy_spec_cd COLLATE pg_catalog."default" ASC NULLS LAST);
