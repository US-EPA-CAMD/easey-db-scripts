ALTER TABLE IF EXISTS camdecmpswks.emission_view_hiappd
    ADD CONSTRAINT pk_emission_view_hiappd PRIMARY KEY (mon_plan_id, mon_loc_id, rpt_period_id, date_hour, fuel_sys_id, fuel_type),
    ADD CONSTRAINT fk_emission_view_hiappd_emission_evaluation FOREIGN KEY (rpt_period_id, mon_plan_id)
        REFERENCES camdecmpswks.emission_evaluation (rpt_period_id, mon_plan_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_emission_view_hiappd_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_emission_view_hiappd_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmpswks.monitor_plan (mon_plan_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_emission_view_hiappd_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_emission_view_hiappd_mon_plan_id
    ON camdecmpswks.emission_view_hiappd USING btree
		(mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_emission_view_hiappd_mon_loc_id
		ON camdecmpswks.emission_view_hiappd USING btree
		(mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_emission_view_hiappd_rpt_period_id
    ON camdecmpswks.emission_view_hiappd USING btree
		(rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_emission_view_hiappd_date_hour
    ON camdecmpswks.emission_view_hiappd USING btree
	  (date_hour COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_emission_view_hiappd_fuel_sys_id
    ON camdecmpswks.emission_view_hiappd USING btree
	  (fuel_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_emission_view_hiappd_fuel_type
    ON camdecmpswks.emission_view_hiappd USING btree
	  (fuel_type COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_emission_view_hiappd_rpt_period_id_mon_loc_id
		ON camdecmpswks.emission_view_hiappd USING btree
		(rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_emission_view_hiappd_rpt_period_id_mon_plan_id
    ON camdecmpswks.emission_view_hiappd USING btree
    (rpt_period_id ASC NULLS LAST, mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);
