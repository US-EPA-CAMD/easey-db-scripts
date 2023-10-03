ALTER TABLE IF EXISTS camdecmps.daily_calibration
    ADD CONSTRAINT pk_daily_calibration PRIMARY KEY (cal_inj_id, rpt_period_id),
    ADD CONSTRAINT fk_daily_calibration_daily_test_summary FOREIGN KEY (daily_test_sum_id, rpt_period_id)
        REFERENCES camdecmps.daily_test_summary (daily_test_sum_id, rpt_period_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_daily_calibration_gas_level_code FOREIGN KEY (upscale_gas_level_cd)
        REFERENCES camdecmpsmd.gas_level_code (gas_level_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_daily_calibration_injection_protocol_code FOREIGN KEY (injection_protocol_cd)
        REFERENCES camdecmpsmd.injection_protocol_code (injection_protocol_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_daily_calibration_protocol_gas_vendor FOREIGN KEY (vendor_id)
        REFERENCES camdecmps.protocol_gas_vendor (vendor_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_daily_calibration_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_daily_calibration_rpt_period_id
    ON camdecmps.daily_calibration USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_calibrati_daily_test_sum_id
    ON camdecmps.daily_calibration USING btree
    (daily_test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_calibration_vendor_id
    ON camdecmps.daily_calibration USING btree
    (vendor_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_calibration_upscale_gas_level_cd
    ON camdecmps.daily_calibration USING btree
    (upscale_gas_level_cd ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_calibration_injection_protocol_cd
    ON camdecmps.daily_calibration USING btree
    (injection_protocol_cd ASC NULLS LAST);
