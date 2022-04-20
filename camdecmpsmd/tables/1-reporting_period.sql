-- Table: camdecmpsmd.reporting_period

-- DROP TABLE camdecmpsmd.reporting_period;

CREATE TABLE IF NOT EXISTS camdecmpsmd.reporting_period
(
    rpt_period_id numeric(38,0) NOT NULL,
    calendar_year numeric(38,0) NOT NULL,
    quarter numeric(38,0) NOT NULL,
    begin_date date NOT NULL,
    end_date date NOT NULL,
    period_description character varying(100) COLLATE pg_catalog."default" NOT NULL,
    period_abbreviation character varying(32) COLLATE pg_catalog."default" NOT NULL,
    archive_ind numeric(1,0) NOT NULL DEFAULT 0,
    CONSTRAINT pk_reporting_period PRIMARY KEY (rpt_period_id),
    CONSTRAINT uq_calendar_yr_qtr UNIQUE (calendar_year, quarter)
);

COMMENT ON TABLE camdecmpsmd.reporting_period
    IS 'Lookup table for reporting periods.';

COMMENT ON COLUMN camdecmpsmd.reporting_period.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmpsmd.reporting_period.calendar_year
    IS 'Reporting Year. ';

COMMENT ON COLUMN camdecmpsmd.reporting_period.quarter
    IS 'Reporting Quarter. ';

COMMENT ON COLUMN camdecmpsmd.reporting_period.begin_date
    IS 'The begin date of the reporting period.';

COMMENT ON COLUMN camdecmpsmd.reporting_period.end_date
    IS 'The end date of the reporting period.';

COMMENT ON COLUMN camdecmpsmd.reporting_period.period_description
    IS 'The description of the reporting period.';

COMMENT ON COLUMN camdecmpsmd.reporting_period.period_abbreviation
    IS 'The abbreviated description of the reporting period.';

COMMENT ON COLUMN camdecmpsmd.reporting_period.archive_ind
    IS 'Used to indicate whether the reporting period has been archived.';

-- Index: uq_reporting_period_begin_date

-- DROP INDEX camdecmpsmd.uq_reporting_period_begin_date;

CREATE UNIQUE INDEX uq_reporting_period_begin_date
    ON camdecmpsmd.reporting_period USING btree
    (begin_date ASC NULLS LAST);
