ALTER TABLE IF EXISTS camdecmps.monitor_plan_reporting_freq
    ADD CONSTRAINT pk_monitor_plan_reporting_freq PRIMARY KEY (mon_plan_rf_id),
    ADD CONSTRAINT fk_monitor_plan_reporting_freq_begin_rpt_period FOREIGN KEY (begin_rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_plan_reporting_freq_end_rpt_period FOREIGN KEY (end_rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_plan_reporting_freq_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmps.monitor_plan (mon_plan_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_plan_reporting_freq_report_freq_code FOREIGN KEY (report_freq_cd)
        REFERENCES camdecmpsmd.report_freq_code (report_freq_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_monitor_plan_reporting_freq_begin_rpt_period_id
    ON camdecmps.monitor_plan_reporting_freq USING btree
    (begin_rpt_period_id ASC NULLS LAST);
	
CREATE INDEX IF NOT EXISTS idx_monitor_plan_reporting_freq_end_rpt_period_id
    ON camdecmps.monitor_plan_reporting_freq USING btree
    (end_rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_plan_reporting_freq_mon_plan_id
    ON camdecmps.monitor_plan_reporting_freq USING btree
    (mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_plan_reporting_freq_report_freq_cd
    ON camdecmps.monitor_plan_reporting_freq USING btree
    (report_freq_cd COLLATE pg_catalog."default" ASC NULLS LAST);
