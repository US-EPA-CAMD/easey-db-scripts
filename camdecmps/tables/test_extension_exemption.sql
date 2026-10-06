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
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    span_scale_cd character varying(7) COLLATE pg_catalog."default",
    submission_id numeric(38,0),
    submission_availability_cd character varying(7) COLLATE pg_catalog."default",
    resub_explanation character varying(4000) COLLATE pg_catalog."default"
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
