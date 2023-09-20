ALTER TABLE IF EXISTS camdecmps.flow_to_load_reference
    ADD CONSTRAINT pk_flow_to_load_reference PRIMARY KEY (flow_load_ref_id),
    ADD CONSTRAINT fk_flow_to_load_reference_operating_level_code FOREIGN KEY (op_level_cd)
        REFERENCES camdecmpsmd.operating_level_code (op_level_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_flow_to_load_reference_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmps.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_flow_to_load_reference_op_level_cd
    ON camdecmps.flow_to_load_reference USING btree
    (op_level_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_flow_to_load_reference_test_sum_id
    ON camdecmps.flow_to_load_reference USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
