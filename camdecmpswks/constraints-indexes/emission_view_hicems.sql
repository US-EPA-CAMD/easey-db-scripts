ALTER TABLE IF EXISTS camdecmpswks.emission_view_hicems
    ADD CONSTRAINT pk_emission_view_hicems PRIMARY KEY (mon_plan_id, mon_loc_id, rpt_period_id, hour_id),
    ADD CONSTRAINT fk_emission_view_hicems_emission_evaluation FOREIGN KEY (rpt_period_id, mon_plan_id)
        REFERENCES camdecmpswks.emission_evaluation (rpt_period_id, mon_plan_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_emission_view_hicems_hrly_op_data FOREIGN KEY (hour_id)
        REFERENCES camdecmpswks.hrly_op_data (hour_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_emission_view_hicems_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_emission_view_hicems_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmpswks.monitor_plan (mon_plan_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_emission_view_hicems_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_emission_view_hicems_mon_plan_id
    ON camdecmpswks.emission_view_hicems USING btree
		(mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_emission_view_hicems_mon_loc_id
		ON camdecmpswks.emission_view_hicems USING btree
		(mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_emission_view_hicems_rpt_period_id
    ON camdecmpswks.emission_view_hicems USING btree
		(rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_emission_view_hicems_hour_id
		ON camdecmpswks.emission_view_hicems USING btree
		(hour_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_emission_view_hicems_rpt_period_id_mon_loc_id
		ON camdecmpswks.emission_view_hicems USING btree
		(rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
