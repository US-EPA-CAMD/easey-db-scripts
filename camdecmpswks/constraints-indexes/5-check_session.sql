ALTER TABLE IF EXISTS camdecmpswks.check_session
    ADD CONSTRAINT pk_check_session PRIMARY KEY (chk_session_id),
    ADD CONSTRAINT fk_check_session_category_code FOREIGN KEY (category_cd)
        REFERENCES camdecmpsmd.category_code (category_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_check_session_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmpswks.monitor_plan (mon_plan_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_check_session_process_code FOREIGN KEY (process_cd)
        REFERENCES camdecmpsmd.process_code (process_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_check_session_qa_cert_event FOREIGN KEY (qa_cert_event_id)
        REFERENCES camdecmpswks.qa_cert_event (qa_cert_event_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_check_session_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_check_session_severity_code FOREIGN KEY (severity_cd)
        REFERENCES camdecmpsmd.severity_code (severity_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_check_session_test_extension_exemption FOREIGN KEY (test_extension_exemption_id)
        REFERENCES camdecmpswks.test_extension_exemption (test_extension_exemption_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_check_session_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT chk_check_session_begin_date_lte_end_date CHECK (session_begin_date <= session_end_date);

CREATE INDEX IF NOT EXISTS idx_check_session_test_extension_exemption_id
    ON camdecmpswks.check_session USING btree
    (test_extension_exemption_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_session_qa_cert_event_id
    ON camdecmpswks.check_session USING btree
    (qa_cert_event_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_session_mon_plan_id
    ON camdecmpswks.check_session USING btree
    (mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_session_test_sum_id
    ON camdecmpswks.check_session USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_session_rpt_period_id
    ON camdecmpswks.check_session USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_session_submission_id
    ON camdecmpswks.check_session USING btree
    (submission_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_session_category_cd
    ON camdecmpswks.check_session USING btree
    (category_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_session_process_cd
    ON camdecmpswks.check_session USING btree
    (process_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_session_severity_cd
    ON camdecmpswks.check_session USING btree
    (severity_cd COLLATE pg_catalog."default" ASC NULLS LAST);
