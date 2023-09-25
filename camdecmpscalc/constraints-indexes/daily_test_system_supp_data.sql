ALTER TABLE IF EXISTS camdecmpscalc.daily_test_system_supp_data
    ADD CONSTRAINT pk_daily_test_system_supp_data PRIMARY KEY (pk),
   	ADD CONSTRAINT fk_daily_test_system_supp_data_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE,
   	ADD CONSTRAINT fk_daily_test_system_supp_data_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmpswks.monitor_system (mon_sys_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_daily_test_system_supp_data_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_daily_test_system_supp_data_chk_session_id
    ON camdecmpscalc.daily_test_system_supp_data USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_system_supp_data_daily_test_sum_id
    ON camdecmpscalc.daily_test_system_supp_data USING btree
    (daily_test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_system_supp_data_mon_sys_id
    ON camdecmpscalc.daily_test_system_supp_data USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_system_supp_data_rpt_period_id
    ON camdecmpscalc.daily_test_system_supp_data USING btree
    (rpt_period_id ASC NULLS LAST);