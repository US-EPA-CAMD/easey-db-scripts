-- ------------ Write CREATE-TABLE-stage scripts -----------

CREATE TABLE IF NOT EXISTS camdecmps.qa_cert_event_supp_data(
    qa_cert_event_supp_data_id CHARACTER VARYING(45) NOT NULL,
    qa_cert_event_id CHARACTER VARYING(45) NOT NULL,
    qa_cert_event_supp_data_cd CHARACTER VARYING(7) NOT NULL,
    qa_cert_event_supp_date_cd CHARACTER VARYING(7) NOT NULL,
    count_from_datehour TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    count NUMERIC(38,0),
    count_from_included_ind NUMERIC(38,0) NOT NULL,
    mon_loc_id CHARACTER VARYING(45) NOT NULL,
    rpt_period_id NUMERIC(38,0) NOT NULL,
    delete_ind NUMERIC(1,0) NOT NULL DEFAULT 0,
    userid CHARACTER VARYING(8),
    add_date TIMESTAMP WITHOUT TIME ZONE,
    update_date TIMESTAMP WITHOUT TIME ZONE
)
        WITH (
        OIDS=FALSE
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



-- ------------ Write CREATE-INDEX-stage scripts -----------

CREATE INDEX idx_qa_cert_event_supp_data_ce
ON camdecmps.qa_cert_event_supp_data
USING BTREE (qa_cert_event_id ASC);



CREATE INDEX idx_qa_cert_event_supp_data_da
ON camdecmps.qa_cert_event_supp_data
USING BTREE (qa_cert_event_supp_data_cd ASC);



CREATE INDEX idx_qa_cert_event_supp_data_de
ON camdecmps.qa_cert_event_supp_data
USING BTREE (qa_cert_event_supp_date_cd ASC);



CREATE INDEX idx_qa_cert_event_supp_data_er
ON camdecmps.qa_cert_event_supp_data
USING BTREE (rpt_period_id ASC, mon_loc_id ASC);



CREATE INDEX idx_qa_cert_event_supp_data_ml
ON camdecmps.qa_cert_event_supp_data
USING BTREE (mon_loc_id ASC);



-- ------------ Write CREATE-CONSTRAINT-stage scripts -----------

ALTER TABLE camdecmps.qa_cert_event_supp_data
ADD CONSTRAINT pk_qa_cert_event_supp_data PRIMARY KEY (qa_cert_event_supp_data_id);



-- ------------ Write CREATE-FOREIGN-KEY-CONSTRAINT-stage scripts -----------

ALTER TABLE camdecmps.qa_cert_event_supp_data
ADD CONSTRAINT fk_qa_cert_event_supp_data_ce FOREIGN KEY (qa_cert_event_id) 
REFERENCES camdecmps.qa_cert_event (qa_cert_event_id)
ON DELETE NO ACTION;



ALTER TABLE camdecmps.qa_cert_event_supp_data
ADD CONSTRAINT fk_qa_cert_event_supp_data_da FOREIGN KEY (qa_cert_event_supp_data_cd) 
REFERENCES camdecmpsmd.qa_cert_event_supp_data_code (qa_cert_event_supp_data_cd)
ON DELETE NO ACTION;



ALTER TABLE camdecmps.qa_cert_event_supp_data
ADD CONSTRAINT fk_qa_cert_event_supp_data_de FOREIGN KEY (qa_cert_event_supp_date_cd) 
REFERENCES camdecmpsmd.qa_cert_event_supp_data_code (qa_cert_event_supp_data_cd)
ON DELETE NO ACTION;



ALTER TABLE camdecmps.qa_cert_event_supp_data
ADD CONSTRAINT fk_qa_cert_event_supp_data_ml FOREIGN KEY (mon_loc_id) 
REFERENCES camdecmps.monitor_location (mon_loc_id)
ON DELETE NO ACTION;



