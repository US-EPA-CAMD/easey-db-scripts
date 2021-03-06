-- Table: camdecmps.qa_supp_data

-- DROP TABLE camdecmps.qa_supp_data;

CREATE TABLE IF NOT EXISTS camdecmps.qa_supp_data
(
    qa_supp_data_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_sys_id character varying(45) COLLATE pg_catalog."default",
    component_id character varying(45) COLLATE pg_catalog."default",
    test_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default",
    test_reason_cd character varying(7) COLLATE pg_catalog."default",
    test_num character varying(18) COLLATE pg_catalog."default",
    span_scale character varying(10) COLLATE pg_catalog."default",
    begin_date date,
    begin_hour numeric(2,0),
    begin_min numeric(2,0),
    end_date date,
    end_hour numeric(2,0),
    end_min numeric(2,0),
    rpt_period_id numeric(38,0),
    test_result_cd character varying(7) COLLATE pg_catalog."default",
    gp_ind numeric(38,0),
    reinstallation_date date,
    reinstallation_hour numeric(2,0),
    test_expire_date date,
    test_expire_hour numeric(2,0),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    op_level_cd character varying(7) COLLATE pg_catalog."default",
    submission_id numeric(38,0),
    submission_availability_cd character varying(7) COLLATE pg_catalog."default",
    chk_session_id character varying(45) COLLATE pg_catalog."default",
    operating_condition_cd character varying(7) COLLATE pg_catalog."default",
    fuel_cd character varying(7) COLLATE pg_catalog."default",
    CONSTRAINT pk_qa_supp_data PRIMARY KEY (qa_supp_data_id),
    CONSTRAINT fk_component_qa_supp_data FOREIGN KEY (component_id)
        REFERENCES camdecmps.component (component_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_fuel_code_qa_supp_data FOREIGN KEY (fuel_cd)
        REFERENCES camdecmpsmd.fuel_code (fuel_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_locat_qa_supp_data FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_syste_qa_supp_data FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_operating_con_qa_supp_data FOREIGN KEY (operating_condition_cd)
        REFERENCES camdecmpsmd.operating_condition_code (operating_condition_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_operating_lev_qa_supp_data FOREIGN KEY (op_level_cd)
        REFERENCES camdecmpsmd.operating_level_code (op_level_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_reporting_per_qa_supp_data FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_submission_av_qa_supplement FOREIGN KEY (submission_availability_cd)
        REFERENCES camdecmpsmd.submission_availability_code (submission_availability_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_test_reason_c_qa_supp_data FOREIGN KEY (test_reason_cd)
        REFERENCES camdecmpsmd.test_reason_code (test_reason_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_test_result_c_qa_supp_data FOREIGN KEY (test_result_cd)
        REFERENCES camdecmpsmd.test_result_code (test_result_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_test_type_cod_qa_supp_data FOREIGN KEY (test_type_cd)
        REFERENCES camdecmpsmd.test_type_code (test_type_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT qa_supp_data_r01 FOREIGN KEY (test_sum_id)
        REFERENCES camdecmps.test_summary (test_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmps.qa_supp_data
    IS 'Contains all test summary information needed to evaluate hourly data';

COMMENT ON COLUMN camdecmps.qa_supp_data.qa_supp_data_id
    IS 'Unique combination of DB_Token and identity key generated by sequence generator. ';

COMMENT ON COLUMN camdecmps.qa_supp_data.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmps.qa_supp_data.mon_sys_id
    IS 'Unique identifier of a monitoring system record. ';

COMMENT ON COLUMN camdecmps.qa_supp_data.component_id
    IS 'Unique identifier of a monitoring component record. ';

COMMENT ON COLUMN camdecmps.qa_supp_data.test_type_cd
    IS 'Code used to identify test type. ';

COMMENT ON COLUMN camdecmps.qa_supp_data.test_sum_id
    IS 'Unique identifier of a test summary record. ';

COMMENT ON COLUMN camdecmps.qa_supp_data.test_reason_cd
    IS 'Code used to identify test reason. ';

COMMENT ON COLUMN camdecmps.qa_supp_data.test_num
    IS 'Test number. ';

COMMENT ON COLUMN camdecmps.qa_supp_data.span_scale
    IS 'Span scale. ';

COMMENT ON COLUMN camdecmps.qa_supp_data.begin_date
    IS 'Date in which information became effective or activity started. ';

COMMENT ON COLUMN camdecmps.qa_supp_data.begin_hour
    IS 'Hour in which information became effective or activity started. ';

COMMENT ON COLUMN camdecmps.qa_supp_data.begin_min
    IS 'Minute in which information became effective or activity started.';

COMMENT ON COLUMN camdecmps.qa_supp_data.end_date
    IS 'Last date in which information was effective or date in which activity ended. ';

COMMENT ON COLUMN camdecmps.qa_supp_data.end_hour
    IS 'Last hour n which information was effective or hour in which activity ended. ';

COMMENT ON COLUMN camdecmps.qa_supp_data.end_min
    IS 'Last minute in which information was effective or minute in which activity ended.';

COMMENT ON COLUMN camdecmps.qa_supp_data.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmps.qa_supp_data.test_result_cd
    IS 'Code used to identify reported test result. ';

COMMENT ON COLUMN camdecmps.qa_supp_data.gp_ind
    IS 'Indication that test was performed in a grace period. ';

COMMENT ON COLUMN camdecmps.qa_supp_data.reinstallation_date
    IS 'Date in which information became effective or activity started.  Applicable for fuel flowmeter test data only. ';

COMMENT ON COLUMN camdecmps.qa_supp_data.reinstallation_hour
    IS 'Hour in which information became effective or activity started. Applicable of fuel flowmeter test data only. ';

COMMENT ON COLUMN camdecmps.qa_supp_data.test_expire_date
    IS 'Test Expiration Date. ';

COMMENT ON COLUMN camdecmps.qa_supp_data.test_expire_hour
    IS 'Hour in which information became effective or activity started. ';

COMMENT ON COLUMN camdecmps.qa_supp_data.userid
    IS 'User account or source of data that added or updated record.';

COMMENT ON COLUMN camdecmps.qa_supp_data.add_date
    IS 'Date and time in which record was added.';

COMMENT ON COLUMN camdecmps.qa_supp_data.update_date
    IS 'Date and time in which record was last updated.';

COMMENT ON COLUMN camdecmps.qa_supp_data.op_level_cd
    IS 'Code used to identify the operating level. ';

COMMENT ON COLUMN camdecmps.qa_supp_data.submission_id
    IS 'Unique identifier of a submission.';

COMMENT ON COLUMN camdecmps.qa_supp_data.submission_availability_cd
    IS 'Unique code value for a lookup table.';

COMMENT ON COLUMN camdecmps.qa_supp_data.chk_session_id
    IS 'Unique combination of DB_Token and identity key generated by sequence generator.';

COMMENT ON COLUMN camdecmps.qa_supp_data.operating_condition_cd
    IS 'Code used to identify the operating condition. ';

COMMENT ON COLUMN camdecmps.qa_supp_data.fuel_cd
    IS 'Code used to identify the type of fuel. ';

-- Index: idx_qa_supp_data_001

-- DROP INDEX camdecmps.idx_qa_supp_data_001;

CREATE INDEX idx_qa_supp_data_001
    ON camdecmps.qa_supp_data USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_qa_supp_data_chk_sessio

-- DROP INDEX camdecmps.idx_qa_supp_data_chk_sessio;

CREATE INDEX idx_qa_supp_data_chk_sessio
    ON camdecmps.qa_supp_data USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_qa_supp_data_component

-- DROP INDEX camdecmps.idx_qa_supp_data_component;

CREATE INDEX idx_qa_supp_data_component
    ON camdecmps.qa_supp_data USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_qa_supp_data_fuel_cd

-- DROP INDEX camdecmps.idx_qa_supp_data_fuel_cd;

CREATE INDEX idx_qa_supp_data_fuel_cd
    ON camdecmps.qa_supp_data USING btree
    (fuel_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_qa_supp_data_mon_loc_id

-- DROP INDEX camdecmps.idx_qa_supp_data_mon_loc_id;

CREATE INDEX idx_qa_supp_data_mon_loc_id
    ON camdecmps.qa_supp_data USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_qa_supp_data_mon_sys_id

-- DROP INDEX camdecmps.idx_qa_supp_data_mon_sys_id;

CREATE INDEX idx_qa_supp_data_mon_sys_id
    ON camdecmps.qa_supp_data USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_qa_supp_data_op_level_c

-- DROP INDEX camdecmps.idx_qa_supp_data_op_level_c;

CREATE INDEX idx_qa_supp_data_op_level_c
    ON camdecmps.qa_supp_data USING btree
    (op_level_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_qa_supp_data_operating_

-- DROP INDEX camdecmps.idx_qa_supp_data_operating_;

CREATE INDEX idx_qa_supp_data_operating_
    ON camdecmps.qa_supp_data USING btree
    (operating_condition_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_qa_supp_data_submission

-- DROP INDEX camdecmps.idx_qa_supp_data_submission;

CREATE INDEX idx_qa_supp_data_submission
    ON camdecmps.qa_supp_data USING btree
    (submission_availability_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_qa_supp_data_submission1

-- DROP INDEX camdecmps.idx_qa_supp_data_submission1;

CREATE INDEX idx_qa_supp_data_submission1
    ON camdecmps.qa_supp_data USING btree
    (submission_id ASC NULLS LAST);

-- Index: idx_qa_supp_data_test_reaso

-- DROP INDEX camdecmps.idx_qa_supp_data_test_reaso;

CREATE INDEX idx_qa_supp_data_test_reaso
    ON camdecmps.qa_supp_data USING btree
    (test_reason_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_qa_supp_data_test_resul

-- DROP INDEX camdecmps.idx_qa_supp_data_test_resul;

CREATE INDEX idx_qa_supp_data_test_resul
    ON camdecmps.qa_supp_data USING btree
    (test_result_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_qa_supp_data_test_type

-- DROP INDEX camdecmps.idx_qa_supp_data_test_type;

CREATE INDEX idx_qa_supp_data_test_type
    ON camdecmps.qa_supp_data USING btree
    (test_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: qa_supp_data_idx001

-- DROP INDEX camdecmps.qa_supp_data_idx001;

CREATE INDEX qa_supp_data_idx001
    ON camdecmps.qa_supp_data USING btree
    (rpt_period_id ASC NULLS LAST);
