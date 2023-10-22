ALTER TABLE IF EXISTS camdecmpswks.emission_view_dailycal
    ADD CONSTRAINT pk_emission_view_dailycal PRIMARY KEY (mon_plan_id, mon_loc_id, rpt_period_id, test_sum_id),
    ADD CONSTRAINT fk_emission_view_dailycal_emission_evaluation FOREIGN KEY (rpt_period_id, mon_plan_id)
        REFERENCES camdecmpswks.emission_evaluation (rpt_period_id, mon_plan_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_emission_view_dailycal_daily_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.daily_test_summary (daily_test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_emission_view_dailycal_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_emission_view_dailycal_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmpswks.monitor_plan (mon_plan_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_emission_view_dailycal_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_emission_view_dailycal_mon_plan_id
    ON camdecmpswks.emission_view_dailycal USING btree
		(mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_emission_view_dailycal_mon_loc_id
		ON camdecmpswks.emission_view_dailycal USING btree
		(mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_emission_view_dailycal_rpt_period_id
    ON camdecmpswks.emission_view_dailycal USING btree
		(rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_emission_view_dailycal_test_sum_id
		ON camdecmpswks.emission_view_dailycal USING btree
		(test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_emission_view_dailycal_rpt_period_id_mon_loc_id
		ON camdecmpswks.emission_view_dailycal USING btree
		(rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_emission_view_dailycal_rpt_period_id_mon_plan_id
    ON camdecmpswks.emission_view_dailycal USING btree
    (rpt_period_id ASC NULLS LAST, mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);
