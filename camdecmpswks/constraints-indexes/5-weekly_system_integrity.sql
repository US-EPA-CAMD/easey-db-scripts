ALTER TABLE IF EXISTS camdecmpswks.weekly_system_integrity
    ADD CONSTRAINT pk_weekly_system_integrity PRIMARY KEY (weekly_sys_integrity_id),
    ADD CONSTRAINT fk_weekly_system_integrity_gas_level_code FOREIGN KEY (gas_level_cd)
        REFERENCES camdecmpsmd.gas_level_code (gas_level_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_weekly_system_integrity_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_weekly_system_integrity_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_weekly_system_integrity_weekly_test_summary FOREIGN KEY (weekly_test_sum_id)
        REFERENCES camdecmpswks.weekly_test_summary (weekly_test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_weekly_system_integrity_gas_level_cd
    ON camdecmpswks.weekly_system_integrity USING btree
    (gas_level_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_weekly_system_integrity_mon_loc_id
    ON camdecmpswks.weekly_system_integrity USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_weekly_system_integrity_rpt_period_id
    ON camdecmpswks.weekly_system_integrity USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_weekly_system_integrity_weekly_test_sum_id
    ON camdecmpswks.weekly_system_integrity USING btree
    (weekly_test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_weekly_system_integrity_rpt_period_id_mon_loc_id
    ON camdecmpswks.weekly_system_integrity USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
