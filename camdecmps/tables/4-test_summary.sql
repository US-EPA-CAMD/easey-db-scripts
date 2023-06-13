-- Table: camdecmps.test_summary

-- DROP TABLE camdecmps.test_summary;

CREATE TABLE IF NOT EXISTS camdecmps.test_summary
(
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_sys_id character varying(45) COLLATE pg_catalog."default",
    component_id character varying(45) COLLATE pg_catalog."default",
    test_num character varying(18) COLLATE pg_catalog."default" NOT NULL,
    gp_ind numeric(38,0),
    calc_gp_ind numeric(38,0),
    test_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    test_reason_cd character varying(7) COLLATE pg_catalog."default",
    test_result_cd character varying(7) COLLATE pg_catalog."default",
    calc_test_result_cd character varying(7) COLLATE pg_catalog."default",
    rpt_period_id numeric(38,0),
    test_description character varying(100) COLLATE pg_catalog."default",
    begin_date date,
    begin_hour numeric(2,0),
    begin_min numeric(2,0),
    end_date date,
    end_hour numeric(2,0),
    end_min numeric(2,0),
    calc_span_value numeric(13,3),
    test_comment character varying(1000) COLLATE pg_catalog."default",
    last_updated date,
    updated_status_flg character varying(1) COLLATE pg_catalog."default",
    needs_eval_flg character varying(1) COLLATE pg_catalog."default",
    chk_session_id character varying(45) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    span_scale_cd character varying(7) COLLATE pg_catalog."default",
    injection_protocol_cd character varying(7) COLLATE pg_catalog."default",
    CONSTRAINT pk_test_summary PRIMARY KEY (test_sum_id),
    CONSTRAINT uq_test_summary UNIQUE (mon_loc_id, test_num, test_type_cd),
    CONSTRAINT fk_test_summary_component FOREIGN KEY (component_id)
        REFERENCES camdecmps.component (component_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_test_summary_injection_protocol_code FOREIGN KEY (injection_protocol_cd)
        REFERENCES camdecmpsmd.injection_protocol_code (injection_protocol_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_test_summary_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_test_summary_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_test_summary_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_test_summary_span_scale_code FOREIGN KEY (span_scale_cd)
        REFERENCES camdecmpsmd.span_scale_code (span_scale_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_test_summary_test_reason_code FOREIGN KEY (test_reason_cd)
        REFERENCES camdecmpsmd.test_reason_code (test_reason_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_test_summary_test_result_code FOREIGN KEY (test_result_cd)
        REFERENCES camdecmpsmd.test_result_code (test_result_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_test_summary_test_result_code_calc FOREIGN KEY (calc_test_result_cd)
        REFERENCES camdecmpsmd.test_result_code (test_result_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_test_summary_test_type_code FOREIGN KEY (test_type_cd)
        REFERENCES camdecmpsmd.test_type_code (test_type_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmps.test_summary
    IS 'Summary of test data reported by source.  All test types.  (Includes all data for record types 603 and 624.)';

COMMENT ON COLUMN camdecmps.test_summary.test_sum_id
    IS 'Unique identifier of a test summary record. ';

COMMENT ON COLUMN camdecmps.test_summary.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmps.test_summary.mon_sys_id
    IS 'Unique identifier of a monitoring system record. ';

COMMENT ON COLUMN camdecmps.test_summary.component_id
    IS 'Unique identifier of a monitoring component record. ';

COMMENT ON COLUMN camdecmps.test_summary.test_num
    IS 'Test number. ';

COMMENT ON COLUMN camdecmps.test_summary.gp_ind
    IS 'Used to indicate whether the test was performed in a grace period. ';

COMMENT ON COLUMN camdecmps.test_summary.calc_gp_ind
    IS 'Used to indicate whether the test was performed in a grace period. ';

COMMENT ON COLUMN camdecmps.test_summary.test_type_cd
    IS 'Code used to identify test type. ';

COMMENT ON COLUMN camdecmps.test_summary.test_reason_cd
    IS 'Code used to identify test reason. ';

COMMENT ON COLUMN camdecmps.test_summary.test_result_cd
    IS 'Code used to identify reported test result. ';

COMMENT ON COLUMN camdecmps.test_summary.calc_test_result_cd
    IS 'Code used to identify reported test result. ';

COMMENT ON COLUMN camdecmps.test_summary.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmps.test_summary.test_description
    IS 'Test activity description. ';

COMMENT ON COLUMN camdecmps.test_summary.begin_date
    IS 'Date in which information became effective or activity started. ';

COMMENT ON COLUMN camdecmps.test_summary.begin_hour
    IS 'Hour in which information became effective or activity started. ';

COMMENT ON COLUMN camdecmps.test_summary.begin_min
    IS 'Minute in which the test began. ';

COMMENT ON COLUMN camdecmps.test_summary.end_date
    IS 'Last date in which information was effective or date in which activity ended. ';

COMMENT ON COLUMN camdecmps.test_summary.end_hour
    IS 'Last hour in which information was effective or hour in which activity ended. ';

COMMENT ON COLUMN camdecmps.test_summary.end_min
    IS 'Last minute in which information was effective or minute in which activity ended. ';

COMMENT ON COLUMN camdecmps.test_summary.calc_span_value
    IS 'Calculated span value in units of daily calibration. ';

COMMENT ON COLUMN camdecmps.test_summary.test_comment
    IS 'Test comment. ';

COMMENT ON COLUMN camdecmps.test_summary.last_updated
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmps.test_summary.updated_status_flg
    IS 'If set to true, identifies that changes have been made to the Supplemental data from within the client tool, consequently data most be submitted to the Host. ';

COMMENT ON COLUMN camdecmps.test_summary.needs_eval_flg
    IS 'Identifies whether the data needs to have checks run against it. ';

COMMENT ON COLUMN camdecmps.test_summary.chk_session_id
    IS 'Identifies the most recent check session used for the evaluation. ';

COMMENT ON COLUMN camdecmps.test_summary.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.test_summary.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.test_summary.update_date
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmps.test_summary.span_scale_cd
    IS 'Code used to identify the span scale. ';

COMMENT ON COLUMN camdecmps.test_summary.injection_protocol_cd
    IS 'Injection protocol code to indicate the use of either elemental or oxidized NIST-traceable Hg standards. ';

-- Index: idx_test_summary_calc_test

-- DROP INDEX camdecmps.idx_test_summary_calc_test;

CREATE INDEX IF NOT EXISTS idx_test_summary_calc_test
    ON camdecmps.test_summary USING btree
    (calc_test_result_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_test_summary_chk_sessio

-- DROP INDEX camdecmps.idx_test_summary_chk_sessio;

CREATE INDEX IF NOT EXISTS idx_test_summary_chk_sessio
    ON camdecmps.test_summary USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_test_summary_component

-- DROP INDEX camdecmps.idx_test_summary_component;

CREATE INDEX IF NOT EXISTS idx_test_summary_component
    ON camdecmps.test_summary USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_test_summary_mon_loc_id

-- DROP INDEX camdecmps.idx_test_summary_mon_loc_id;

CREATE INDEX IF NOT EXISTS idx_test_summary_mon_loc_id
    ON camdecmps.test_summary USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_test_summary_mon_sys_id

-- DROP INDEX camdecmps.idx_test_summary_mon_sys_id;

CREATE INDEX IF NOT EXISTS idx_test_summary_mon_sys_id
    ON camdecmps.test_summary USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_test_summary_rpt_period

-- DROP INDEX camdecmps.idx_test_summary_rpt_period;

CREATE INDEX IF NOT EXISTS idx_test_summary_rpt_period
    ON camdecmps.test_summary USING btree
    (rpt_period_id ASC NULLS LAST);

-- Index: idx_test_summary_span_scale

-- DROP INDEX camdecmps.idx_test_summary_span_scale;

CREATE INDEX IF NOT EXISTS idx_test_summary_span_scale
    ON camdecmps.test_summary USING btree
    (span_scale_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_test_summary_test_reaso

-- DROP INDEX camdecmps.idx_test_summary_test_reaso;

CREATE INDEX IF NOT EXISTS idx_test_summary_test_reaso
    ON camdecmps.test_summary USING btree
    (test_reason_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_test_summary_test_resul

-- DROP INDEX camdecmps.idx_test_summary_test_resul;

CREATE INDEX IF NOT EXISTS idx_test_summary_test_resul
    ON camdecmps.test_summary USING btree
    (test_result_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_test_summary_test_type

-- DROP INDEX camdecmps.idx_test_summary_test_type;

CREATE INDEX IF NOT EXISTS idx_test_summary_test_type
    ON camdecmps.test_summary USING btree
    (test_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);
