ALTER TABLE IF EXISTS camdecmps.emission_view_matsweekly
    ADD CONSTRAINT pk_emission_view_matsweekly PRIMARY KEY (mon_plan_id, mon_loc_id, rpt_period_id, weekly_test_sum_id),
    ADD CONSTRAINT fk_emission_view_matsweekly_emission_evaluation FOREIGN KEY (rpt_period_id, mon_plan_id)
        REFERENCES camdecmps.emission_evaluation (rpt_period_id, mon_plan_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_emission_view_matsweekly_weekly_test_summary FOREIGN KEY (weekly_test_sum_id, rpt_period_id)
        REFERENCES camdecmps.weekly_test_summary (weekly_test_sum_id, rpt_period_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_emission_view_matsweekly_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_emission_view_matsweekly_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmps.monitor_plan (mon_plan_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_emission_view_matsweekly_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_emission_view_matsweekly_mon_plan_id
    ON camdecmps.emission_view_matsweekly USING btree
		(mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_emission_view_matsweekly_mon_loc_id
		ON camdecmps.emission_view_matsweekly USING btree
		(mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_emission_view_matsweekly_rpt_period_id
    ON camdecmps.emission_view_matsweekly USING btree
		(rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_emission_view_matsweekly_weekly_test_sum_id
		ON camdecmps.emission_view_matsweekly USING btree
		(weekly_test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_emission_view_matsweekly_rpt_period_id_mon_loc_id
		ON camdecmps.emission_view_matsweekly USING btree
		(rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_emission_view_matsweekly_rpt_period_id_mon_plan_id
    ON camdecmps.emission_view_matsweekly USING btree
    (rpt_period_id ASC NULLS LAST, mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);
