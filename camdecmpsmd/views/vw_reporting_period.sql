-- View: camdecmpsmd.vw_reporting_period

DROP VIEW IF EXISTS camdecmpsmd.vw_reporting_period;

CREATE OR REPLACE VIEW camdecmpsmd.vw_reporting_period
 AS
 SELECT reporting_period.rpt_period_id,
    reporting_period.calendar_year,
    reporting_period.quarter,
    reporting_period.period_description AS year_quarter,
    reporting_period.period_description,
    reporting_period.period_abbreviation AS year_quarter_short,
    reporting_period.period_abbreviation,
    reporting_period.begin_date AS quarter_begin_date,
    reporting_period.end_date AS quarter_end_date
   FROM camdecmpsmd.reporting_period;
