CREATE TABLE IF NOT EXISTS camdecmps.summary_value
(
    sum_value_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    parameter_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    current_rpt_period_total numeric(13,3),
    calc_current_rpt_period_total numeric(13,3),
    os_total numeric(13,3),
    calc_os_total numeric(13,3),
    year_total numeric(13,3),
    calc_year_total numeric(13,3),
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
) PARTITION BY RANGE (rpt_period_id);

COMMENT ON TABLE camdecmps.summary_value
    IS 'Cumulative Emissions data. Record Types 301 and 307.';

COMMENT ON COLUMN camdecmps.summary_value.sum_value_id
    IS 'Unique identifier of a summary value record. ';

COMMENT ON COLUMN camdecmps.summary_value.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmps.summary_value.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmps.summary_value.parameter_cd
    IS 'Code used to identify the parameter. ';

COMMENT ON COLUMN camdecmps.summary_value.current_rpt_period_total
    IS 'Total value for current reporting period. ';

COMMENT ON COLUMN camdecmps.summary_value.calc_current_rpt_period_total
    IS 'Total value for current reporting period. ';

COMMENT ON COLUMN camdecmps.summary_value.os_total
    IS 'Ozone season year to date total. ';

COMMENT ON COLUMN camdecmps.summary_value.calc_os_total
    IS 'Ozone season year to date total. ';

COMMENT ON COLUMN camdecmps.summary_value.year_total
    IS 'Year to date total. ';

COMMENT ON COLUMN camdecmps.summary_value.calc_year_total
    IS 'Year to date total. ';

COMMENT ON COLUMN camdecmps.summary_value.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.summary_value.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.summary_value.update_date
    IS 'Date and time in which record was last updated. ';
