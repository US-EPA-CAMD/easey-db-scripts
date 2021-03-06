-- Table: camdecmps.test_extension_exemption

-- DROP TABLE camdecmps.test_extension_exemption;

CREATE TABLE IF NOT EXISTS camdecmps.test_extension_exemption
(
    test_extension_exemption_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    mon_sys_id character varying(45) COLLATE pg_catalog."default",
    component_id character varying(45) COLLATE pg_catalog."default",
    fuel_cd character varying(7) COLLATE pg_catalog."default",
    extens_exempt_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    last_updated timestamp without time zone,
    updated_status_flg character varying(1) COLLATE pg_catalog."default",
    needs_eval_flg character varying(1) COLLATE pg_catalog."default",
    chk_session_id character varying(45) COLLATE pg_catalog."default",
    hours_used numeric(4,0),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    span_scale_cd character varying(7) COLLATE pg_catalog."default",
    submission_id numeric(38,0),
    submission_availability_cd character varying(7) COLLATE pg_catalog."default",
    CONSTRAINT pk_test_extension_exemption PRIMARY KEY (test_extension_exemption_id),
    CONSTRAINT fk_component_test_extensio FOREIGN KEY (component_id)
        REFERENCES camdecmps.component (component_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_extension_exe_test_extensio FOREIGN KEY (extens_exempt_cd)
        REFERENCES camdecmpsmd.extension_exemption_code (extens_exempt_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_fuel_code_test_extensio FOREIGN KEY (fuel_cd)
        REFERENCES camdecmpsmd.fuel_code (fuel_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_locat_test_extensio FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_syste_test_extensio FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_reporting_per_test_extensio FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_span_scale_test_extensio FOREIGN KEY (span_scale_cd)
        REFERENCES camdecmpsmd.span_scale_code (span_scale_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_submission_av_test_extensio FOREIGN KEY (submission_availability_cd)
        REFERENCES camdecmpsmd.submission_availability_code (submission_availability_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
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

-- Index: idx_test_extension__chk_sessio

-- DROP INDEX camdecmps.idx_test_extension__chk_sessio;

CREATE INDEX idx_test_extension__chk_sessio
    ON camdecmps.test_extension_exemption USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_test_extension__submission

-- DROP INDEX camdecmps.idx_test_extension__submission;

CREATE INDEX idx_test_extension__submission
    ON camdecmps.test_extension_exemption USING btree
    (submission_id ASC NULLS LAST);

-- Index: idx_test_extension_component

-- DROP INDEX camdecmps.idx_test_extension_component;

CREATE INDEX idx_test_extension_component
    ON camdecmps.test_extension_exemption USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_test_extension_extens_exe

-- DROP INDEX camdecmps.idx_test_extension_extens_exe;

CREATE INDEX idx_test_extension_extens_exe
    ON camdecmps.test_extension_exemption USING btree
    (extens_exempt_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_test_extension_fuel_cd

-- DROP INDEX camdecmps.idx_test_extension_fuel_cd;

CREATE INDEX idx_test_extension_fuel_cd
    ON camdecmps.test_extension_exemption USING btree
    (fuel_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_test_extension_mon_loc_id

-- DROP INDEX camdecmps.idx_test_extension_mon_loc_id;

CREATE INDEX idx_test_extension_mon_loc_id
    ON camdecmps.test_extension_exemption USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_test_extension_mon_sys_id

-- DROP INDEX camdecmps.idx_test_extension_mon_sys_id;

CREATE INDEX idx_test_extension_mon_sys_id
    ON camdecmps.test_extension_exemption USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_test_extension_span_scale

-- DROP INDEX camdecmps.idx_test_extension_span_scale;

CREATE INDEX idx_test_extension_span_scale
    ON camdecmps.test_extension_exemption USING btree
    (span_scale_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_test_extension_submission

-- DROP INDEX camdecmps.idx_test_extension_submission;

CREATE INDEX idx_test_extension_submission
    ON camdecmps.test_extension_exemption USING btree
    (submission_availability_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: test_ext_exempt_idx001

-- DROP INDEX camdecmps.test_ext_exempt_idx001;

CREATE INDEX test_ext_exempt_idx001
    ON camdecmps.test_extension_exemption USING btree
    (rpt_period_id ASC NULLS LAST);
