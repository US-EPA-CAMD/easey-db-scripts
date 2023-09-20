ALTER TABLE IF EXISTS camdecmpswks.on_off_cal
    ADD CONSTRAINT pk_on_off_cal PRIMARY KEY (on_off_cal_id),
    ADD CONSTRAINT fk_on_off_cal_gas_level_code FOREIGN KEY (upscale_gas_level_cd)
        REFERENCES camdecmpsmd.gas_level_code (gas_level_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_on_off_cal_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_on_off_cal_test_sum_id
    ON camdecmpswks.on_off_cal USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_on_off_cal_upscale_gas_level_cd
    ON camdecmpswks.on_off_cal USING btree
    (upscale_gas_level_cd COLLATE pg_catalog."default" ASC NULLS LAST);
