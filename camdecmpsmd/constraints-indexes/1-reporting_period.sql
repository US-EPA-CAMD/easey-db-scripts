ALTER TABLE IF EXISTS camdecmpsmd.reporting_period
    ADD CONSTRAINT pk_reporting_period PRIMARY KEY (rpt_period_id),
    ADD CONSTRAINT uq_reporting_period_begin_date UNIQUE (begin_date),
    ADD CONSTRAINT uq_reporting_period_year_quarter UNIQUE (calendar_year, quarter);

CREATE INDEX IF NOT EXISTS idx_reporting_period_year
    ON camdecmpsmd.reporting_period USING btree
    (calendar_year ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_reporting_period_quarter
    ON camdecmpsmd.reporting_period USING btree
    (quarter ASC NULLS LAST);
