ALTER TABLE IF EXISTS camdecmpswks.fuel_flow_to_load_check
    ADD CONSTRAINT pk_fuel_flow_to_load_check PRIMARY KEY (fuel_flow_load_id),
    ADD CONSTRAINT fk_fuel_flow_to_load_check_test_basis_code FOREIGN KEY (test_basis_cd)
        REFERENCES camdecmpsmd.test_basis_code (test_basis_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_fuel_flow_to_load_check_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_fuel_flow_to_load_check_test_sum_id
    ON camdecmpswks.fuel_flow_to_load_check USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_fuel_flow_to_load_check_test_basis_cd
    ON camdecmpswks.fuel_flow_to_load_check USING btree
    (test_basis_cd COLLATE pg_catalog."default" ASC NULLS LAST);
