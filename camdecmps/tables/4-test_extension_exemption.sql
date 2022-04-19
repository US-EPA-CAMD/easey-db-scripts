-- ------------ Write CREATE-TABLE-stage scripts -----------

CREATE TABLE IF NOT EXISTS camdecmps.test_extension_exemption(
    test_extension_exemption_id CHARACTER VARYING(45) NOT NULL,
    mon_loc_id CHARACTER VARYING(45) NOT NULL,
    rpt_period_id NUMERIC(38,0) NOT NULL,
    mon_sys_id CHARACTER VARYING(45),
    component_id CHARACTER VARYING(45),
    fuel_cd CHARACTER VARYING(7),
    extens_exempt_cd CHARACTER VARYING(7) NOT NULL,
    last_updated TIMESTAMP WITHOUT TIME ZONE,
    updated_status_flg CHARACTER VARYING(1),
    needs_eval_flg CHARACTER VARYING(1),
    chk_session_id CHARACTER VARYING(45),
    hours_used NUMERIC(4,0),
    userid CHARACTER VARYING(8),
    add_date TIMESTAMP WITHOUT TIME ZONE,
    update_date TIMESTAMP WITHOUT TIME ZONE,
    span_scale_cd CHARACTER VARYING(7),
    submission_id NUMERIC(38,0),
    submission_availability_cd CHARACTER VARYING(7)
)
        WITH (
        OIDS=FALSE
        );
COMMENT ON TABLE camdecmps.test_extension_exemption
     IS 'Test extension or exemption claim information';
COMMENT ON COLUMN camdecmps.test_extension_exemption.test_extension_exemption_id
     IS 'Unique identifier of a test extension exemption record. ';
COMMENT ON COLUMN camdecmps.test_extension_exemption.mon_loc_id
     IS 'Unique identifier of a monitoring location record. ';
COMMENT ON COLUMN camdecmps.test_extension_exemption.rpt_period_id
     IS 'Unique identifier of a reporting period record. ';
COMMENT ON COLUMN camdecmps.test_extension_exemption.mon_sys_id
     IS 'Unique identifier of a monitoring system record. ';
COMMENT ON COLUMN camdecmps.test_extension_exemption.component_id
     IS 'Unique identifier of a monitoring component record. ';
COMMENT ON COLUMN camdecmps.test_extension_exemption.fuel_cd
     IS 'Code used to identify the type of fuel. ';
COMMENT ON COLUMN camdecmps.test_extension_exemption.extens_exempt_cd
     IS 'Code used to identify the extension or exemption. ';
COMMENT ON COLUMN camdecmps.test_extension_exemption.last_updated
     IS 'Date and time in which record was last updated. ';
COMMENT ON COLUMN camdecmps.test_extension_exemption.updated_status_flg
     IS 'If set to true, identifies that changes have been made to the QA certification event data from within the client tool, consequently data must be submitted to the Host. ';
COMMENT ON COLUMN camdecmps.test_extension_exemption.needs_eval_flg
     IS 'Identifies whether the data need to have checks run against it. ';
COMMENT ON COLUMN camdecmps.test_extension_exemption.chk_session_id
     IS 'Identifies the most recent check session used for the evaluation. ';
COMMENT ON COLUMN camdecmps.test_extension_exemption.hours_used
     IS 'Hours of use for non-redundant backup or other type of claim for QA schedule extension. ';
COMMENT ON COLUMN camdecmps.test_extension_exemption.userid
     IS 'User account or source of data that added or updated record.';
COMMENT ON COLUMN camdecmps.test_extension_exemption.add_date
     IS 'Date and time in which record was added.';
COMMENT ON COLUMN camdecmps.test_extension_exemption.update_date
     IS 'Date and time in which record was last updated.';
COMMENT ON COLUMN camdecmps.test_extension_exemption.span_scale_cd
     IS 'Code used to identify the span scale. ';
COMMENT ON COLUMN camdecmps.test_extension_exemption.submission_id
     IS 'Unique identifier of a submission.';
COMMENT ON COLUMN camdecmps.test_extension_exemption.submission_availability_cd
     IS 'Unique code value for a lookup table.';



-- ------------ Write CREATE-INDEX-stage scripts -----------

CREATE INDEX idx_test_extension__chk_sessio
ON camdecmps.test_extension_exemption
USING BTREE (chk_session_id ASC);



CREATE INDEX idx_test_extension__submission
ON camdecmps.test_extension_exemption
USING BTREE (submission_id ASC);



CREATE INDEX idx_test_extension_component
ON camdecmps.test_extension_exemption
USING BTREE (component_id ASC);



CREATE INDEX idx_test_extension_extens_exe
ON camdecmps.test_extension_exemption
USING BTREE (extens_exempt_cd ASC);



CREATE INDEX idx_test_extension_fuel_cd
ON camdecmps.test_extension_exemption
USING BTREE (fuel_cd ASC);



CREATE INDEX idx_test_extension_mon_loc_id
ON camdecmps.test_extension_exemption
USING BTREE (mon_loc_id ASC);



CREATE INDEX idx_test_extension_mon_sys_id
ON camdecmps.test_extension_exemption
USING BTREE (mon_sys_id ASC);



CREATE INDEX idx_test_extension_span_scale
ON camdecmps.test_extension_exemption
USING BTREE (span_scale_cd ASC);



CREATE INDEX idx_test_extension_submission
ON camdecmps.test_extension_exemption
USING BTREE (submission_availability_cd ASC);



CREATE INDEX test_ext_exempt_idx001
ON camdecmps.test_extension_exemption
USING BTREE (rpt_period_id ASC);



-- ------------ Write CREATE-CONSTRAINT-stage scripts -----------

ALTER TABLE camdecmps.test_extension_exemption
ADD CONSTRAINT pk_test_extension_exemption PRIMARY KEY (test_extension_exemption_id);



-- ------------ Write CREATE-FOREIGN-KEY-CONSTRAINT-stage scripts -----------

ALTER TABLE camdecmps.test_extension_exemption
ADD CONSTRAINT fk_component_test_extensio FOREIGN KEY (component_id) 
REFERENCES camdecmps.component (component_id)
ON DELETE NO ACTION;



ALTER TABLE camdecmps.test_extension_exemption
ADD CONSTRAINT fk_extension_exe_test_extensio FOREIGN KEY (extens_exempt_cd) 
REFERENCES camdecmpsmd.extension_exemption_code (extens_exempt_cd)
ON DELETE NO ACTION;



ALTER TABLE camdecmps.test_extension_exemption
ADD CONSTRAINT fk_fuel_code_test_extensio FOREIGN KEY (fuel_cd) 
REFERENCES camdecmpsmd.fuel_code (fuel_cd)
ON DELETE NO ACTION;



ALTER TABLE camdecmps.test_extension_exemption
ADD CONSTRAINT fk_monitor_locat_test_extensio FOREIGN KEY (mon_loc_id) 
REFERENCES camdecmps.monitor_location (mon_loc_id)
ON DELETE NO ACTION;



ALTER TABLE camdecmps.test_extension_exemption
ADD CONSTRAINT fk_monitor_syste_test_extensio FOREIGN KEY (mon_sys_id) 
REFERENCES camdecmps.monitor_system (mon_sys_id)
ON DELETE NO ACTION;



ALTER TABLE camdecmps.test_extension_exemption
ADD CONSTRAINT fk_reporting_per_test_extensio FOREIGN KEY (rpt_period_id) 
REFERENCES camdecmpsmd.reporting_period (rpt_period_id)
ON DELETE NO ACTION;



ALTER TABLE camdecmps.test_extension_exemption
ADD CONSTRAINT fk_span_scale_test_extensio FOREIGN KEY (span_scale_cd) 
REFERENCES camdecmpsmd.span_scale_code (span_scale_cd)
ON DELETE NO ACTION;



ALTER TABLE camdecmps.test_extension_exemption
ADD CONSTRAINT fk_submission_av_test_extensio FOREIGN KEY (submission_availability_cd) 
REFERENCES camdecmpsmd.submission_availability_code (submission_availability_cd)
ON DELETE NO ACTION;


/*
ALTER TABLE camdecmps.test_extension_exemption
ADD CONSTRAINT test_extension_exemption_r01 FOREIGN KEY (submission_id) 
REFERENCES camdecmpsaux.submission_log (submission_id)
ON DELETE NO ACTION;
*/