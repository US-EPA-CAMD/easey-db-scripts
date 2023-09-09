CREATE TABLE IF NOT EXISTS camdecmps.qa_cert_event_supp_data
(
    qa_cert_event_supp_data_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    qa_cert_event_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    qa_cert_event_supp_data_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    qa_cert_event_supp_date_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    count_from_datehour timestamp without time zone NOT NULL,
    count numeric(38,0),
    count_from_included_ind numeric(38,0) NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    delete_ind numeric(1,0) NOT NULL DEFAULT 0,
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_qa_cert_event_supp_data PRIMARY KEY (qa_cert_event_supp_data_id),
    CONSTRAINT fk_qa_cert_event_supp_data_data_cd FOREIGN KEY (qa_cert_event_supp_data_cd)
        REFERENCES camdecmpsmd.qa_cert_event_supp_data_code (qa_cert_event_supp_data_cd) MATCH SIMPLE,
    CONSTRAINT fk_qa_cert_event_supp_data_date_cd FOREIGN KEY (qa_cert_event_supp_date_cd)
        REFERENCES camdecmpsmd.qa_cert_event_supp_date_code (qa_cert_event_supp_date_cd) MATCH SIMPLE,
    CONSTRAINT fk_qa_cert_event_supp_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    CONSTRAINT fk_qa_cert_event_supp_data_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmps.reporting_period (rpt_period_id) MATCH SIMPLE,
    CONSTRAINT fk_qa_cert_event_supp_data_qa_cert_event FOREIGN KEY (qa_cert_event_id)
        REFERENCES camdecmps.qa_cert_event (qa_cert_event_id) MATCH SIMPLE
        ON DELETE CASCADE
);

COMMENT ON TABLE camdecmps.qa_cert_event_supp_data
    IS 'Contains the QA certification event supplemental data counts for a QA Cert Event row and QA cet event supplental data code.';

COMMENT ON COLUMN camdecmps.qa_cert_event_supp_data.qa_cert_event_supp_data_id
    IS 'Unique identifier.';

COMMENT ON COLUMN camdecmps.qa_cert_event_supp_data.qa_cert_event_id
    IS 'Unique identifier of a QA cert event record.';

COMMENT ON COLUMN camdecmps.qa_cert_event_supp_data.qa_cert_event_supp_data_cd
    IS 'Code used to identify the QA cert event supplemental data type.';

COMMENT ON COLUMN camdecmps.qa_cert_event_supp_data.qa_cert_event_supp_date_cd
    IS 'Code used to identify whether the count is based on QA Cert Event Date or Conditional Data Begin Date/Hour.';

COMMENT ON COLUMN camdecmps.qa_cert_event_supp_data.count_from_datehour
    IS 'The date/hour on which the counts are based. ';

COMMENT ON COLUMN camdecmps.qa_cert_event_supp_data.count
    IS 'Count of days or hours based on QA_CERT_EVENT_SUPP_DATA_CD, QA_CERT_EVENT_SUPP_DATE_CD and COUNT_FROM_DATEHOUR.';

COMMENT ON COLUMN camdecmps.qa_cert_event_supp_data.count_from_included_ind
    IS 'Indicates whether the date or hour was included in the count.';

COMMENT ON COLUMN camdecmps.qa_cert_event_supp_data.mon_loc_id
    IS 'Unique identifier of a monitoring location record.';

COMMENT ON COLUMN camdecmps.qa_cert_event_supp_data.rpt_period_id
    IS 'Unique identifier of a reporting period record.';

COMMENT ON COLUMN camdecmps.qa_cert_event_supp_data.delete_ind
    IS 'Indicates whether the supplemental data is in a deleted state, and that ECMPS client synchronization should delete it from the each client.';

COMMENT ON COLUMN camdecmps.qa_cert_event_supp_data.userid
    IS 'User account or source of data that added or updated record.';

COMMENT ON COLUMN camdecmps.qa_cert_event_supp_data.add_date
    IS 'Date and time in which record was added.';

COMMENT ON COLUMN camdecmps.qa_cert_event_supp_data.update_date
    IS 'Date and time in which record was last updated.';

-- Index: idx_qa_cert_event_supp_data_ce

-- DROP INDEX camdecmps.idx_qa_cert_event_supp_data_ce;

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_supp_data_ce
    ON camdecmps.qa_cert_event_supp_data USING btree
    (qa_cert_event_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_qa_cert_event_supp_data_da

-- DROP INDEX camdecmps.idx_qa_cert_event_supp_data_da;

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_supp_data_da
    ON camdecmps.qa_cert_event_supp_data USING btree
    (qa_cert_event_supp_data_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_qa_cert_event_supp_data_de

-- DROP INDEX camdecmps.idx_qa_cert_event_supp_data_de;

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_supp_data_de
    ON camdecmps.qa_cert_event_supp_data USING btree
    (qa_cert_event_supp_date_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_qa_cert_event_supp_data_er

-- DROP INDEX camdecmps.idx_qa_cert_event_supp_data_er;

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_supp_data_er
    ON camdecmps.qa_cert_event_supp_data USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_qa_cert_event_supp_data_ml

-- DROP INDEX camdecmps.idx_qa_cert_event_supp_data_ml;

CREATE INDEX IF NOT EXISTS idx_qa_cert_event_supp_data_ml
    ON camdecmps.qa_cert_event_supp_data USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
