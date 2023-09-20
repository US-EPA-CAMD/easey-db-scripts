ALTER TABLE IF EXISTS camdecmpswks.air_emission_testing
    ADD CONSTRAINT pk_air_emission_testing PRIMARY KEY (air_emission_test_id),
    ADD CONSTRAINT fk_air_emission_testing_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_air_emission_testing_test_sum_id
    ON camdecmpswks.air_emission_testing USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
