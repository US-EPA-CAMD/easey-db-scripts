-- Table: camdecmpsaux.check_session

-- DROP TABLE camdecmpsaux.check_session;

CREATE TABLE IF NOT EXISTS camdecmpsaux.check_session
(
    chk_session_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    session_begin_date timestamp without time zone,
    session_end_date timestamp without time zone,
    session_comment character varying(1000) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default",
    mon_plan_id character varying(45) COLLATE pg_catalog."default",
    severity_cd character varying(7) COLLATE pg_catalog."default",
    qa_cert_event_id character varying(45) COLLATE pg_catalog."default",
    test_extension_exemption_id character varying(45) COLLATE pg_catalog."default",
    category_cd character varying(7) COLLATE pg_catalog."default",
    process_cd character varying(7) COLLATE pg_catalog."default",
    rpt_period_id numeric(38,0),
    test_sum_id character varying(45) COLLATE pg_catalog."default",
    submission_id double precision,
    CONSTRAINT pk_check_session PRIMARY KEY (chk_session_id),
    CONSTRAINT check_session_r05 FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_category_code_check_session FOREIGN KEY (category_cd)
        REFERENCES camdecmpsmd.category_code (category_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_process_code_check_session FOREIGN KEY (process_cd)
        REFERENCES camdecmpsmd.process_code (process_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_severity_code_check_session FOREIGN KEY (severity_cd)
        REFERENCES camdecmpsmd.severity_code (severity_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT check_session_c01 CHECK (session_begin_date <= session_end_date)
);

COMMENT ON TABLE camdecmpsaux.check_session
    IS 'Evaluation check sessions.';

COMMENT ON COLUMN camdecmpsaux.check_session.chk_session_id
    IS ' Unique identifier of a check session record.';

COMMENT ON COLUMN camdecmpsaux.check_session.session_begin_date
    IS ' Date and time in which the check session was started.';

COMMENT ON COLUMN camdecmpsaux.check_session.session_end_date
    IS ' Date and time in which the check session was ended.';

COMMENT ON COLUMN camdecmpsaux.check_session.session_comment
    IS ' Comment related to the check session.';

COMMENT ON COLUMN camdecmpsaux.check_session.userid
    IS ' User account or source of data that added or updated record.';

COMMENT ON COLUMN camdecmpsaux.check_session.mon_plan_id
    IS ' Unique identifier of a monitoring plan record. ';

COMMENT ON COLUMN camdecmpsaux.check_session.severity_cd
    IS ' Code used to identify the severity of the check result.';

COMMENT ON COLUMN camdecmpsaux.check_session.qa_cert_event_id
    IS ' Unique identifier of a QA certification event record. ';

COMMENT ON COLUMN camdecmpsaux.check_session.test_extension_exemption_id
    IS ' Unique identifier of a test extension exemption record. ';

COMMENT ON COLUMN camdecmpsaux.check_session.category_cd
    IS ' Code used to identify the check category.';

COMMENT ON COLUMN camdecmpsaux.check_session.process_cd
    IS ' Code used to identify the check process.';

COMMENT ON COLUMN camdecmpsaux.check_session.rpt_period_id
    IS ' Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmpsaux.check_session.test_sum_id
    IS ' Unique identifier of a test summary record. ';

COMMENT ON COLUMN camdecmpsaux.check_session.submission_id
    IS ' Unique identifier of a submission.';

-- Index: idx_check_session_1526

-- DROP INDEX camdecmpsaux.idx_check_session_1526;

CREATE INDEX IF NOT EXISTS idx_check_session_1526
    ON camdecmpsaux.check_session USING btree
    (test_extension_exemption_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_check_session_2816

-- DROP INDEX camdecmpsaux.idx_check_session_2816;

CREATE INDEX IF NOT EXISTS idx_check_session_2816
    ON camdecmpsaux.check_session USING btree
    (qa_cert_event_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_check_session_6459

-- DROP INDEX camdecmpsaux.idx_check_session_6459;

CREATE INDEX IF NOT EXISTS idx_check_session_6459
    ON camdecmpsaux.check_session USING btree
    (mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_check_session_7529

-- DROP INDEX camdecmpsaux.idx_check_session_7529;

CREATE INDEX IF NOT EXISTS idx_check_session_7529
    ON camdecmpsaux.check_session USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_check_session_8070

-- DROP INDEX camdecmpsaux.idx_check_session_8070;

CREATE INDEX IF NOT EXISTS idx_check_session_8070
    ON camdecmpsaux.check_session USING btree
    (rpt_period_id ASC NULLS LAST);

-- Index: idx_check_session_category_c

-- DROP INDEX camdecmpsaux.idx_check_session_category_c;

CREATE INDEX IF NOT EXISTS idx_check_session_category_c
    ON camdecmpsaux.check_session USING btree
    (category_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_check_session_process_cd

-- DROP INDEX camdecmpsaux.idx_check_session_process_cd;

CREATE INDEX IF NOT EXISTS idx_check_session_process_cd
    ON camdecmpsaux.check_session USING btree
    (process_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_check_session_severity_c

-- DROP INDEX camdecmpsaux.idx_check_session_severity_c;

CREATE INDEX IF NOT EXISTS idx_check_session_severity_c
    ON camdecmpsaux.check_session USING btree
    (severity_cd COLLATE pg_catalog."default" ASC NULLS LAST);
