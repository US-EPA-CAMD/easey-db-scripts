ALTER TABLE IF EXISTS camdecmpsaux.email_to_process
	  ADD CONSTRAINT pk_email_to_process PRIMARY KEY (to_process_id),
    ADD CONSTRAINT fk_email_to_process_em_submission_access FOREIGN KEY (em_sub_access_id)
        REFERENCES camdecmpsaux.em_submission_access (em_sub_access_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_email_to_process_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmps.monitor_plan (mon_plan_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_email_to_process_plant FOREIGN KEY (fac_id)
        REFERENCES camd.plant (fac_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_email_to_process_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_email_to_process_fac_id
    ON camdecmpsaux.email_to_process USING btree
    (fac_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_email_to_process_email_type
    ON camdecmpsaux.email_to_process USING btree
    (email_type COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_email_to_process_event_code
    ON camdecmpsaux.email_to_process USING btree
    (event_code ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_email_to_process_mon_plan_id
    ON camdecmpsaux.email_to_process USING btree
    (mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_email_to_process_rpt_period_id
    ON camdecmpsaux.email_to_process USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_email_to_process_em_sub_access_id
    ON camdecmpsaux.email_to_process USING btree
    (em_sub_access_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_email_to_process_submission_type
    ON camdecmpsaux.email_to_process USING btree
    (submission_type COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_email_to_process_status_cd
    ON camdecmpsaux.email_to_process USING btree
    (status_cd COLLATE pg_catalog."default" ASC NULLS LAST);
