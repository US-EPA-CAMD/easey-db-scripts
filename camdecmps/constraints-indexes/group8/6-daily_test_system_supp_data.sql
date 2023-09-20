ALTER TABLE IF EXISTS camdecmps.daily_test_system_supp_data
	  ADD CONSTRAINT pk_daily_test_system_supp_data PRIMARY KEY (daily_test_system_supp_data_id),
    ADD CONSTRAINT fk_daily_test_system_sup_data_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_daily_test_system_supp_data_daily_test_supp_data FOREIGN KEY (daily_test_supp_data_id)
        REFERENCES camdecmps.daily_test_supp_data (daily_test_supp_data_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_daily_test_system_supp_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_daily_test_system_supp_data_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_daily_test_system_supp_data_daily_test_supp_data_id
    ON camdecmps.daily_test_system_supp_data USING btree
    (daily_test_supp_data_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_system_supp_data_mon_loc_id
    ON camdecmps.daily_test_system_supp_data USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_system_supp_data_mon_sys_id
    ON camdecmps.daily_test_system_supp_data USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_system_supp_data_rpt_period_id
    ON camdecmps.daily_test_system_supp_data USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_system_supp_data_rpt_period_id_mon_loc_id
    ON camdecmps.daily_test_system_supp_data USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
