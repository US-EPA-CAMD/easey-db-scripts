ALTER TABLE IF EXISTS camdecmps.emission_view_matssorbent
    ADD CONSTRAINT pk_emission_view_matssorbent PRIMARY KEY (mon_plan_id, mon_loc_id, rpt_period_id, system_identifier, date_hour, end_date_time),
    ADD CONSTRAINT fk_emission_view_matssorbent_emission_evaluation FOREIGN KEY (rpt_period_id, mon_plan_id)
        REFERENCES camdecmps.emission_evaluation (rpt_period_id, mon_plan_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_emission_view_matssorbent_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_emission_view_matssorbent_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmps.monitor_plan (mon_plan_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_emission_view_matssorbent_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_emission_view_matssorbent_mon_plan_id
    ON camdecmps.emission_view_matssorbent USING btree
		(mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_emission_view_matssorbent_mon_loc_id
		ON camdecmps.emission_view_matssorbent USING btree
		(mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_emission_view_matssorbent_rpt_period_id
    ON camdecmps.emission_view_matssorbent USING btree
		(rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_emission_view_matssorbent_rpt_period_id_mon_loc_id
		ON camdecmps.emission_view_matssorbent USING btree
		(rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);