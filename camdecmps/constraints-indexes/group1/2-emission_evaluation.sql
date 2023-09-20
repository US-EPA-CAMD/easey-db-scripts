ALTER TABLE camdecmps.emission_evaluation
    ADD CONSTRAINT pk_emission_evaluation PRIMARY KEY (mon_plan_id, rpt_period_id),
    ADD CONSTRAINT fk_emission_evaluation_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmps.monitor_plan (mon_plan_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_emission_evaluation_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_emission_evaluation_submission_availability_code FOREIGN KEY (submission_availability_cd)
        REFERENCES camdecmpsmd.submission_availability_code (submission_availability_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_emission_evaluation_mon_plan_id
    ON camdecmps.emission_evaluation USING btree
    (mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_emission_evaluation_rpt_period_id
    ON camdecmps.emission_evaluation USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_emission_evaluation_submission_id
    ON camdecmps.emission_evaluation USING btree
    (submission_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_emission_evaluation_chk_session_id
    ON camdecmps.emission_evaluation USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_emission_evaluation_submission_availability_cd
    ON camdecmps.emission_evaluation USING btree
    (submission_availability_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_emission_evaluation_rpt_period_id_mon_plan_id
    ON camdecmps.emission_evaluation USING btree
    (rpt_period_id ASC NULLS LAST, mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);
