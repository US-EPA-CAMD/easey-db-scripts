-- Table: camdecmps.emission_evaluation

-- DROP TABLE camdecmps.emission_evaluation;

CREATE TABLE IF NOT EXISTS camdecmps.emission_evaluation
(
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    last_updated timestamp without time zone,
    updated_status_flg character varying(1) COLLATE pg_catalog."default",
    needs_eval_flg character varying(1) COLLATE pg_catalog."default",
    chk_session_id character varying(45) COLLATE pg_catalog."default",
    submission_id numeric(38,0),
    submission_availability_cd character varying(7) COLLATE pg_catalog."default",
    CONSTRAINT pk_emission_evaluation PRIMARY KEY (mon_plan_id, rpt_period_id),
    CONSTRAINT fk_emission_evaluation_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmps.monitor_plan (mon_plan_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_emission_evaluation_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_emission_evaluation_submission_availability_code FOREIGN KEY (submission_availability_cd)
        REFERENCES camdecmpsmd.submission_availability_code (submission_availability_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmps.emission_evaluation
    IS 'Tracks the status of emissions data evaluations.';

COMMENT ON COLUMN camdecmps.emission_evaluation.mon_plan_id
    IS 'Unique identifier of a monitoring plan record. ';

COMMENT ON COLUMN camdecmps.emission_evaluation.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmps.emission_evaluation.last_updated
    IS 'Date and time the quarterly emissions data was last updated (imported). ';

COMMENT ON COLUMN camdecmps.emission_evaluation.updated_status_flg
    IS 'If set to true, identifies that changes have been made to the Emissions data from within the client tool, consequently data most be submitted to the Host. ';

COMMENT ON COLUMN camdecmps.emission_evaluation.needs_eval_flg
    IS 'Identifies whether the data needs to have checks run against it. ';

COMMENT ON COLUMN camdecmps.emission_evaluation.chk_session_id
    IS 'Identifies the most recent check session used for the evaluation. ';

COMMENT ON COLUMN camdecmps.emission_evaluation.submission_id
    IS 'Unique identifier of a submission.';

COMMENT ON COLUMN camdecmps.emission_evaluation.submission_availability_cd
    IS 'Unique code value for a lookup table.';

-- Index: emission_evaluation_idx001

-- DROP INDEX camdecmps.emission_evaluation_idx001;

CREATE INDEX IF NOT EXISTS emission_evaluation_idx001
    ON camdecmps.emission_evaluation USING btree
    (rpt_period_id ASC NULLS LAST);

-- Index: idx_emission_evalua1

-- DROP INDEX camdecmps.idx_emission_evalua1;

CREATE INDEX IF NOT EXISTS idx_emission_evalua1
    ON camdecmps.emission_evaluation USING btree
    (submission_id ASC NULLS LAST);

-- Index: idx_emission_evalua_chk_sessio

-- DROP INDEX camdecmps.idx_emission_evalua_chk_sessio;

CREATE INDEX IF NOT EXISTS idx_emission_evalua_chk_sessio
    ON camdecmps.emission_evaluation USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_emission_evalua_submission

-- DROP INDEX camdecmps.idx_emission_evalua_submission;

CREATE INDEX IF NOT EXISTS idx_emission_evalua_submission
    ON camdecmps.emission_evaluation USING btree
    (submission_availability_cd COLLATE pg_catalog."default" ASC NULLS LAST);
