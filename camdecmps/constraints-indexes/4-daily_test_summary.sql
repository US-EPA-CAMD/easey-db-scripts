ALTER TABLE IF EXISTS camdecmps.daily_test_summary
    ADD CONSTRAINT pk_daily_test_summary PRIMARY KEY (daily_test_sum_id, rpt_period_id),
    ADD CONSTRAINT fk_daily_test_summary_component FOREIGN KEY (component_id)
        REFERENCES camdecmps.component (component_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_daily_test_summary_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_daily_test_summary_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_daily_test_summary_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_daily_test_summary_span_scale_code FOREIGN KEY (span_scale_cd)
        REFERENCES camdecmpsmd.span_scale_code (span_scale_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_daily_test_summary_test_result_code FOREIGN KEY (test_result_cd)
        REFERENCES camdecmpsmd.test_result_code (test_result_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_daily_test_summary_test_type_code FOREIGN KEY (test_type_cd)
        REFERENCES camdecmpsmd.test_type_code (test_type_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_daily_test_summary_rpt_period_id
    ON camdecmps.daily_test_summary USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_summary_component_id
    ON camdecmps.daily_test_summary USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_summary_mon_loc_id
    ON camdecmps.daily_test_summary USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_summary_span_scale_cd
    ON camdecmps.daily_test_summary USING btree
    (span_scale_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_summary_test_result_cd
    ON camdecmps.daily_test_summary USING btree
    (test_result_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_summary_test_type_cd
    ON camdecmps.daily_test_summary USING btree
    (test_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_summary_mon_sys_id
    ON camdecmps.daily_test_summary USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_summary_rpt_period_id_mon_loc_id
    ON camdecmps.daily_test_summary USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
