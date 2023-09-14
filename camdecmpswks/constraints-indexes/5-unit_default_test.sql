ALTER TABLE IF EXISTS camdecmpswks.unit_default_test
    ADD CONSTRAINT pk_unt_default_test PRIMARY KEY (unit_default_test_sum_id),
    ADD CONSTRAINT fk_unt_default_test_fuel_code FOREIGN KEY (fuel_cd)
        REFERENCES camdecmpsmd.fuel_code (fuel_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_unt_default_test_operating_condition_code FOREIGN KEY (operating_condition_cd)
        REFERENCES camdecmpsmd.operating_condition_code (operating_condition_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_unt_default_test_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_unit_default_test_fuel_cd
    ON camdecmpswks.unit_default_test USING btree
    (fuel_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_unit_default_test_operating_condition_cd
    ON camdecmpswks.unit_default_test USING btree
    (operating_condition_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_unit_default_test_test_sum_id
    ON camdecmpswks.unit_default_test USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
