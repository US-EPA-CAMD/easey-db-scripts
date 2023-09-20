ALTER TABLE IF EXISTS camdecmps.qa_cert_event
	  ADD CONSTRAINT pk_qa_cert_event PRIMARY KEY (qa_cert_event_id),
    ADD CONSTRAINT fk_qa_cert_event_component FOREIGN KEY (component_id)
        REFERENCES camdecmps.component (component_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_qa_cert_event_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_qa_cert_event_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_qa_cert_event_qa_cert_event_code FOREIGN KEY (qa_cert_event_cd)
        REFERENCES camdecmpsmd.qa_cert_event_code (qa_cert_event_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_qa_cert_event_required_test_code FOREIGN KEY (required_test_cd)
        REFERENCES camdecmpsmd.required_test_code (required_test_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_qa_cert_event_submission_availability_code FOREIGN KEY (submission_availability_cd)
        REFERENCES camdecmpsmd.submission_availability_code (submission_availability_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_chk_session_id
    ON camdecmps.qa_cert_event USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_component_id
    ON camdecmps.qa_cert_event USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_mon_loc_id
    ON camdecmps.qa_cert_event USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_mon_sys_id
    ON camdecmps.qa_cert_event USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_qa_cert_event_cd
    ON camdecmps.qa_cert_event USING btree
    (qa_cert_event_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_required_test_cd
    ON camdecmps.qa_cert_event USING btree
    (required_test_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_submission_availability_cd
    ON camdecmps.qa_cert_event USING btree
    (submission_availability_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_submission_id
    ON camdecmps.qa_cert_event USING btree
    (submission_id ASC NULLS LAST);
