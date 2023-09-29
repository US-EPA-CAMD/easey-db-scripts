CREATE TABLE IF NOT EXISTS camdecmpswks.emission_evaluation
(
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    last_updated timestamp without time zone,
    updated_status_flg character varying(1) COLLATE pg_catalog."default",
    needs_eval_flg character varying(1) COLLATE pg_catalog."default" DEFAULT 'Y'::character varying,
    chk_session_id character varying(45) COLLATE pg_catalog."default",
    submission_id numeric(38,0),
    submission_availability_cd character varying(7) COLLATE pg_catalog."default" DEFAULT 'GRANTED'::character varying,
    eval_status_cd character varying(7) COLLATE pg_catalog."default" NOT NULL DEFAULT 'EVAL'::character varying,
    pending_status_cd character varying(7) COLLATE pg_catalog."default"
);

COMMENT ON TABLE camdecmpswks.emission_evaluation
    IS 'Tracks the status of emissions data evaluations.';

COMMENT ON COLUMN camdecmpswks.emission_evaluation.mon_plan_id
    IS 'Unique identifier of a monitoring plan record. ';

COMMENT ON COLUMN camdecmpswks.emission_evaluation.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmpswks.emission_evaluation.last_updated
    IS 'Date and time the quarterly emissions data was last updated (imported). ';

COMMENT ON COLUMN camdecmpswks.emission_evaluation.updated_status_flg
    IS 'If set to true, identifies that changes have been made to the Emissions data from within the client tool, consequently data most be submitted to the Host. ';

COMMENT ON COLUMN camdecmpswks.emission_evaluation.needs_eval_flg
    IS 'Identifies whether the data needs to have checks run against it. ';

COMMENT ON COLUMN camdecmpswks.emission_evaluation.chk_session_id
    IS 'Identifies the most recent check session used for the evaluation. ';

COMMENT ON COLUMN camdecmpswks.emission_evaluation.submission_id
    IS 'Unique identifier of a submission.';

COMMENT ON COLUMN camdecmpswks.emission_evaluation.submission_availability_cd
    IS 'Unique code value for a lookup table.';
