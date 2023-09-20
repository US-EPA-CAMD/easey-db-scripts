ALTER TABLE IF EXISTS camdecmpsaux.apportionment
	  ADD CONSTRAINT pk_apportionment PRIMARY KEY (apport_id),
    ADD CONSTRAINT fk_apportionment_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmps.monitor_plan (mon_plan_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_apportionment_begin_rpt_period_id FOREIGN KEY (begin_rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_apportionment_end_rpt_period_id FOREIGN KEY (end_rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_apportionment_mon_plan_id
    ON camdecmpsaux.apportionment USING btree
    (mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_apportionment_begin_rpt_period_id
    ON camdecmpsaux.apportionment USING btree
    (begin_rpt_period_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_apportionment_end_rpt_period_id
    ON camdecmpsaux.apportionment USING btree
    (end_rpt_period_id COLLATE pg_catalog."default" ASC NULLS LAST);
