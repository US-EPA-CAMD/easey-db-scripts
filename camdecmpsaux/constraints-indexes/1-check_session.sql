ALTER TABLE IF EXISTS camdecmpsaux.check_session
    ADD CONSTRAINT pk_check_session PRIMARY KEY (chk_session_id),
    ADD CONSTRAINT fk_check_session_category_code FOREIGN KEY (category_cd)
        REFERENCES camdecmpsmd.category_code (category_cd) MATCH SIMPLE,
    --ADD CONSTRAINT fk_check_session_monitor_plan FOREIGN KEY (mon_plan_id)
    --    REFERENCES camdecmps.monitor_plan (mon_plan_id) MATCH SIMPLE
    --    ON DELETE CASCADE,
    ADD CONSTRAINT fk_check_session_process_code FOREIGN KEY (process_cd)
        REFERENCES camdecmpsmd.process_code (process_cd) MATCH SIMPLE,
    --ADD CONSTRAINT fk_check_session_qa_cert_event FOREIGN KEY (qa_cert_event_id)
    --    REFERENCES camdecmps.qa_cert_event (qa_cert_event_id) MATCH SIMPLE
    --    ON DELETE CASCADE,
    ADD CONSTRAINT fk_check_session_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_check_session_severity_code FOREIGN KEY (severity_cd)
        REFERENCES camdecmpsmd.severity_code (severity_cd) MATCH SIMPLE,
    --ADD CONSTRAINT fk_check_session_test_extension_exemption FOREIGN KEY (test_extension_exemption_id)
    --    REFERENCES camdecmps.test_extension_exemption (test_extension_exemption_id) MATCH SIMPLE
    --    ON DELETE CASCADE,
    --ADD CONSTRAINT fk_check_session_test_summary FOREIGN KEY (test_sum_id)
    --    REFERENCES camdecmps.test_summary (test_sum_id) MATCH SIMPLE
    --    ON DELETE CASCADE,
    ADD CONSTRAINT chk_check_session_begin_date_lte_end_date CHECK (session_begin_date <= session_end_date);

CREATE INDEX IF NOT EXISTS idx_check_session_test_extension_exemption_id
    ON camdecmpsaux.check_session USING btree
    (test_extension_exemption_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_session_qa_cert_event_id
    ON camdecmpsaux.check_session USING btree
    (qa_cert_event_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_session_mon_plan_id
    ON camdecmpsaux.check_session USING btree
    (mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_session_test_sum_id
    ON camdecmpsaux.check_session USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_session_rpt_period_id
    ON camdecmpsaux.check_session USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_session_submission_id
    ON camdecmpsaux.check_session USING btree
    (submission_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_session_category_cd
    ON camdecmpsaux.check_session USING btree
    (category_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_session_process_cd
    ON camdecmpsaux.check_session USING btree
    (process_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_check_session_severity_cd
    ON camdecmpsaux.check_session USING btree
    (severity_cd COLLATE pg_catalog."default" ASC NULLS LAST);

/*
--9
select * from camdecmpsaux.check_session cs
left join camdecmps.monitor_plan mp using(mon_plan_id)
where cs.mon_plan_id is not null and mp.mon_plan_id is null

--3830
select * from camdecmpsaux.check_session cs
left join camdecmps.test_summary ts using(test_sum_id)
where cs.test_sum_id is not null and ts.test_sum_id is null

--9
select * from camdecmpsaux.check_session cs
left join camdecmps.qa_cert_event qce using(qa_cert_event_id)
where cs.qa_cert_event_id is not null and qce.qa_cert_event_id is null

--0
select * from camdecmpsaux.check_session cs
left join camdecmps.test_extension_exemption tee using(test_extension_exemption_id)
where cs.test_extension_exemption_id is not null and tee.test_extension_exemption_id is null
*/