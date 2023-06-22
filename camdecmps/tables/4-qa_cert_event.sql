-- Table: camdecmps.qa_cert_event

-- DROP TABLE camdecmps.qa_cert_event;

CREATE TABLE IF NOT EXISTS camdecmps.qa_cert_event
(
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_sys_id character varying(45) COLLATE pg_catalog."default",
    component_id character varying(45) COLLATE pg_catalog."default",
    qa_cert_event_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    qa_cert_event_date date NOT NULL,
    qa_cert_event_hour numeric(2,0) NOT NULL,
    required_test_cd character varying(7) COLLATE pg_catalog."default",
    conditional_data_begin_date date,
    conditional_data_begin_hour numeric(2,0),
    last_test_completed_date date,
    last_test_completed_hour numeric(2,0),
    last_updated timestamp without time zone,
    updated_status_flg character varying(1) COLLATE pg_catalog."default",
    needs_eval_flg character varying(1) COLLATE pg_catalog."default",
    chk_session_id character varying(45) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    qa_cert_event_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    submission_id numeric(38,0),
    submission_availability_cd character varying(7) COLLATE pg_catalog."default",
    CONSTRAINT pk_qa_cert_event PRIMARY KEY (qa_cert_event_id),
    CONSTRAINT fk_qa_cert_event_component FOREIGN KEY (component_id)
        REFERENCES camdecmps.component (component_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_qa_cert_event_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_qa_cert_event_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_qa_cert_event_qa_cert_event_code FOREIGN KEY (qa_cert_event_cd)
        REFERENCES camdecmpsmd.qa_cert_event_code (qa_cert_event_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_qa_cert_event_required_test_code FOREIGN KEY (required_test_cd)
        REFERENCES camdecmpsmd.required_test_code (required_test_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_qa_cert_event_submission_availability_code FOREIGN KEY (submission_availability_cd)
        REFERENCES camdecmpsmd.submission_availability_code (submission_availability_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmps.qa_cert_event
    IS 'Maintenance, certification and recertification events.  Record Type 556.';

COMMENT ON COLUMN camdecmps.qa_cert_event.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmps.qa_cert_event.mon_sys_id
    IS 'Unique identifier of a monitoring system record. ';

COMMENT ON COLUMN camdecmps.qa_cert_event.component_id
    IS 'Unique identifier of a monitoring component record. ';

COMMENT ON COLUMN camdecmps.qa_cert_event.qa_cert_event_cd
    IS 'Code used to identify QA and certification event. ';

COMMENT ON COLUMN camdecmps.qa_cert_event.qa_cert_event_date
    IS 'Date on which the QA Cert Event occurred. ';

COMMENT ON COLUMN camdecmps.qa_cert_event.qa_cert_event_hour
    IS 'Hour in which the QA Cert Event occurred. ';

COMMENT ON COLUMN camdecmps.qa_cert_event.required_test_cd
    IS 'Code used to identify the test(s) required due to the event. ';

COMMENT ON COLUMN camdecmps.qa_cert_event.conditional_data_begin_date
    IS 'Date on which conditional data validation began based on completion of a successful daily calibration. ';

COMMENT ON COLUMN camdecmps.qa_cert_event.conditional_data_begin_hour
    IS 'Hour in which conditional data validation began based on completion of a successful daily calibration. ';

COMMENT ON COLUMN camdecmps.qa_cert_event.last_test_completed_date
    IS 'Date in which the last test was completed. ';

COMMENT ON COLUMN camdecmps.qa_cert_event.last_test_completed_hour
    IS 'Hour in which last test was completed. ';

COMMENT ON COLUMN camdecmps.qa_cert_event.last_updated
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmps.qa_cert_event.updated_status_flg
    IS 'If set to true, identifies that changes have been made to the QA certification event data from within the client tool, consequently data must be submitted to the Host. ';

COMMENT ON COLUMN camdecmps.qa_cert_event.needs_eval_flg
    IS 'Identifies whether the data need to have checks run against it. ';

COMMENT ON COLUMN camdecmps.qa_cert_event.chk_session_id
    IS 'Identifies the most recent check session used for the evaluation. ';

COMMENT ON COLUMN camdecmps.qa_cert_event.userid
    IS 'User account or source of data that added or updated record.';

COMMENT ON COLUMN camdecmps.qa_cert_event.add_date
    IS 'Date and time in which record was added.';

COMMENT ON COLUMN camdecmps.qa_cert_event.update_date
    IS 'Date and time in which record was last updated.';

COMMENT ON COLUMN camdecmps.qa_cert_event.qa_cert_event_id
    IS 'Unique identifier of an QA certification event record. ';

COMMENT ON COLUMN camdecmps.qa_cert_event.submission_id
    IS 'Unique identifier of a submission.';

COMMENT ON COLUMN camdecmps.qa_cert_event.submission_availability_cd
    IS 'Unique code value for a lookup table.';

-- Index: idx_qa_cert_event_chk_sessio

-- DROP INDEX camdecmps.idx_qa_cert_event_chk_sessio;

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_chk_sessio
    ON camdecmps.qa_cert_event USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_qa_cert_event_component

-- DROP INDEX camdecmps.idx_qa_cert_event_component;

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_component
    ON camdecmps.qa_cert_event USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_qa_cert_event_mon_loc_id

-- DROP INDEX camdecmps.idx_qa_cert_event_mon_loc_id;

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_mon_loc_id
    ON camdecmps.qa_cert_event USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_qa_cert_event_mon_sys_id

-- DROP INDEX camdecmps.idx_qa_cert_event_mon_sys_id;

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_mon_sys_id
    ON camdecmps.qa_cert_event USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_qa_cert_event_qa_cert_ev

-- DROP INDEX camdecmps.idx_qa_cert_event_qa_cert_ev;

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_qa_cert_ev
    ON camdecmps.qa_cert_event USING btree
    (qa_cert_event_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_qa_cert_event_required_t

-- DROP INDEX camdecmps.idx_qa_cert_event_required_t;

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_required_t
    ON camdecmps.qa_cert_event USING btree
    (required_test_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_qa_cert_event_submission

-- DROP INDEX camdecmps.idx_qa_cert_event_submission;

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_submission
    ON camdecmps.qa_cert_event USING btree
    (submission_availability_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_qa_cert_event_submission1

-- DROP INDEX camdecmps.idx_qa_cert_event_submission1;

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_submission1
    ON camdecmps.qa_cert_event USING btree
    (submission_id ASC NULLS LAST);
