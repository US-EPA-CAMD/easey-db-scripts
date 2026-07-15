CREATE TABLE IF NOT EXISTS camdeasey.emission_evaluation
(
    mon_plan_id varchar(45) NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    last_updated timestamp without time zone,
    submission_id numeric(38,0),
    load_date timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (mon_plan_id, rpt_period_id)
);
COMMENT ON TABLE camdeasey.emission_evaluation
    IS 'Tracks the status of emissions data evaluations.';
COMMENT ON COLUMN camdeasey.emission_evaluation.mon_plan_id
    IS 'Unique identifier of a monitoring plan record. ';
COMMENT ON COLUMN camdeasey.emission_evaluation.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';
COMMENT ON COLUMN camdeasey.emission_evaluation.last_updated
    IS 'Date and time the quarterly emissions data was last updated (imported). ';
COMMENT ON COLUMN camdeasey.emission_evaluation.submission_id
    IS 'Unique identifier of a submission.';
COMMENT ON COLUMN camdeasey.emission_evaluation.load_date
    IS 'Date and time in which record was loaded from source.';