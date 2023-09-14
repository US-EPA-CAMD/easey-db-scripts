ALTER TABLE IF EXISTS camdecmps.calibration_injection
    ADD CONSTRAINT pk_calibration_injection PRIMARY KEY (cal_inj_id),
    ADD CONSTRAINT fk_calibration_injection_gas_level_code FOREIGN KEY (upscale_gas_level_cd)
        REFERENCES camdecmpsmd.gas_level_code (gas_level_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_calibration_injection_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmps.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_calibration_injection_upscale_gas_level_cd
    ON camdecmps.calibration_injection USING btree
    (upscale_gas_level_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_calibration_injection_test_sum_id
    ON camdecmps.calibration_injection USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
