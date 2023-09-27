ALTER TABLE IF EXISTS camdecmps.monitor_plan
    ADD CONSTRAINT pk_monitor_plan PRIMARY KEY (mon_plan_id),
    ADD CONSTRAINT fk_monitor_plan_plant FOREIGN KEY (fac_id)
        REFERENCES camd.plant (fac_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_plan_reporting_period_begin_rpt_period FOREIGN KEY (begin_rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_plan_reporting_period_end_rpt_period FOREIGN KEY (end_rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_plan_submission_availability_code FOREIGN KEY (submission_availability_cd)
        REFERENCES camdecmpsmd.submission_availability_code (submission_availability_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_monitor_plan_fac_id
    ON camdecmps.monitor_plan USING btree
    (fac_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_plan_chk_session_id
    ON camdecmps.monitor_plan USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_plan_submission_id
    ON camdecmps.monitor_plan USING btree
    (submission_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_plan_submission_availability_cd
    ON camdecmps.monitor_plan USING btree
    (submission_availability_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_plan_begin_rpt_period_id
    ON camdecmps.monitor_plan USING btree
    (begin_rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_plan_end_rpt_period_id
    ON camdecmps.monitor_plan USING btree
    (end_rpt_period_id ASC NULLS LAST);
