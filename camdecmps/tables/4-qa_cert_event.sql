-- ------------ Write CREATE-TABLE-stage scripts -----------

CREATE TABLE IF NOT EXISTS camdecmps.qa_cert_event(
    mon_loc_id CHARACTER VARYING(45) NOT NULL,
    mon_sys_id CHARACTER VARYING(45),
    component_id CHARACTER VARYING(45),
    qa_cert_event_cd CHARACTER VARYING(7) NOT NULL,
    qa_cert_event_date DATE NOT NULL,
    qa_cert_event_hour NUMERIC(2,0) NOT NULL,
    required_test_cd CHARACTER VARYING(7),
    conditional_data_begin_date DATE,
    conditional_data_begin_hour NUMERIC(2,0),
    last_test_completed_date DATE,
    last_test_completed_hour NUMERIC(2,0),
    last_updated TIMESTAMP WITHOUT TIME ZONE,
    updated_status_flg CHARACTER VARYING(1),
    needs_eval_flg CHARACTER VARYING(1),
    chk_session_id CHARACTER VARYING(45),
    userid CHARACTER VARYING(8),
    add_date TIMESTAMP WITHOUT TIME ZONE,
    update_date TIMESTAMP WITHOUT TIME ZONE,
    qa_cert_event_id CHARACTER VARYING(45) NOT NULL,
    submission_id NUMERIC(38,0),
    submission_availability_cd CHARACTER VARYING(7)
)
        WITH (
        OIDS=FALSE
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



-- ------------ Write CREATE-INDEX-stage scripts -----------

CREATE INDEX idx_qa_cert_event_chk_sessio
ON camdecmps.qa_cert_event
USING BTREE (chk_session_id ASC);



CREATE INDEX idx_qa_cert_event_component
ON camdecmps.qa_cert_event
USING BTREE (component_id ASC);



CREATE INDEX idx_qa_cert_event_mon_loc_id
ON camdecmps.qa_cert_event
USING BTREE (mon_loc_id ASC);



CREATE INDEX idx_qa_cert_event_mon_sys_id
ON camdecmps.qa_cert_event
USING BTREE (mon_sys_id ASC);



CREATE INDEX idx_qa_cert_event_qa_cert_ev
ON camdecmps.qa_cert_event
USING BTREE (qa_cert_event_cd ASC);



CREATE INDEX idx_qa_cert_event_required_t
ON camdecmps.qa_cert_event
USING BTREE (required_test_cd ASC);



CREATE INDEX idx_qa_cert_event_submission
ON camdecmps.qa_cert_event
USING BTREE (submission_availability_cd ASC);



CREATE INDEX idx_qa_cert_event_submission1
ON camdecmps.qa_cert_event
USING BTREE (submission_id ASC);



-- ------------ Write CREATE-CONSTRAINT-stage scripts -----------

ALTER TABLE camdecmps.qa_cert_event
ADD CONSTRAINT pk_qa_cert_event PRIMARY KEY (qa_cert_event_id);



-- ------------ Write CREATE-FOREIGN-KEY-CONSTRAINT-stage scripts -----------

ALTER TABLE camdecmps.qa_cert_event
ADD CONSTRAINT fk_component_qa_cert_event FOREIGN KEY (component_id) 
REFERENCES camdecmps.component (component_id)
ON DELETE NO ACTION;



ALTER TABLE camdecmps.qa_cert_event
ADD CONSTRAINT fk_monitor_locat_qa_cert_event FOREIGN KEY (mon_loc_id) 
REFERENCES camdecmps.monitor_location (mon_loc_id)
ON DELETE NO ACTION;



ALTER TABLE camdecmps.qa_cert_event
ADD CONSTRAINT fk_monitor_syste_qa_cert_event FOREIGN KEY (mon_sys_id) 
REFERENCES camdecmps.monitor_system (mon_sys_id)
ON DELETE NO ACTION;



ALTER TABLE camdecmps.qa_cert_event
ADD CONSTRAINT fk_qa_cert_event_qa_cert_event FOREIGN KEY (qa_cert_event_cd) 
REFERENCES camdecmpsmd.qa_cert_event_code (qa_cert_event_cd)
ON DELETE NO ACTION;



ALTER TABLE camdecmps.qa_cert_event
ADD CONSTRAINT fk_required_test_qa_cert_event FOREIGN KEY (required_test_cd) 
REFERENCES camdecmpsmd.required_test_code (required_test_cd)
ON DELETE NO ACTION;



ALTER TABLE camdecmps.qa_cert_event
ADD CONSTRAINT fk_submission_av_qa_cert_event FOREIGN KEY (submission_availability_cd) 
REFERENCES camdecmpsmd.submission_availability_code (submission_availability_cd)
ON DELETE NO ACTION;


/*
ALTER TABLE camdecmps.qa_cert_event
ADD CONSTRAINT qa_cert_event_r01 FOREIGN KEY (submission_id) 
REFERENCES camdecmpsaux.submission_log (submission_id)
ON DELETE NO ACTION;
*/