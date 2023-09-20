ALTER TABLE IF EXISTS camdecmps.flow_to_load_check
    ADD CONSTRAINT pk_flow_to_load_check PRIMARY KEY (flow_load_check_id),
    ADD CONSTRAINT fk_flow_to_load_check_operating_level_code FOREIGN KEY (op_level_cd)
        REFERENCES camdecmpsmd.operating_level_code (op_level_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_flow_to_load_check_test_basis_code FOREIGN KEY (test_basis_cd)
        REFERENCES camdecmpsmd.test_basis_code (test_basis_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_flow_to_load_check_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmps.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_flow_to_load_check_op_level_cd
    ON camdecmps.flow_to_load_check USING btree
    (op_level_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_flow_to_load_check_test_basis_cd
    ON camdecmps.flow_to_load_check USING btree
    (test_basis_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_flow_to_load_check_test_sum_id
    ON camdecmps.flow_to_load_check USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
