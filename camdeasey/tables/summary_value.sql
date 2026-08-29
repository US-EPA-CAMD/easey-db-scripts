CREATE TABLE IF NOT EXISTS camdeasey.summary_value
(
    sum_value_id varchar(45) NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    mon_loc_id varchar(45) NOT NULL,
    parameter_cd varchar(7) NOT NULL,
    current_rpt_period_total numeric(13,3),
    os_total numeric(13,3),
    year_total numeric(13,3),
    PRIMARY KEY (sum_value_id)
);
COMMENT ON TABLE camdeasey.summary_value
    IS 'Cumulative Emissions data.';
COMMENT ON COLUMN camdeasey.summary_value.sum_value_id
    IS 'Unique identifier of a summary value record. ';
COMMENT ON COLUMN camdeasey.summary_value.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';
COMMENT ON COLUMN camdeasey.summary_value.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';
COMMENT ON COLUMN camdeasey.summary_value.parameter_cd
    IS 'Code used to identify the parameter. ';
COMMENT ON COLUMN camdeasey.summary_value.current_rpt_period_total
    IS 'Total value for current reporting period. ';
COMMENT ON COLUMN camdeasey.summary_value.os_total
    IS 'Ozone season year to date total. ';
COMMENT ON COLUMN camdeasey.summary_value.year_total
    IS 'Year to date total. ';