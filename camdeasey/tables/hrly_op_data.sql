CREATE TABLE IF NOT EXISTS camdeasey.hrly_op_data
(
    hour_id varchar(45) NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    mon_loc_id varchar(45) NOT NULL,
    begin_date timestamp without time zone NOT NULL,
    begin_hour numeric(2,0) NOT NULL,
    op_time numeric(3,2),
    hr_load numeric(6,0),
    load_uom_cd varchar(7),
    PRIMARY KEY (hour_id)
);
COMMENT ON TABLE camdeasey.hrly_op_data
    IS 'A collection of data that contains one record for each hour in which a monitor location may or may not have operated. RT 300.';
COMMENT ON COLUMN camdeasey.hrly_op_data.hour_id
    IS 'Unique identifier of an hourly operating data record. ';
COMMENT ON COLUMN camdeasey.hrly_op_data.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';
COMMENT ON COLUMN camdeasey.hrly_op_data.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';
COMMENT ON COLUMN camdeasey.hrly_op_data.begin_date
    IS 'Date of the hourly operating data. ';
COMMENT ON COLUMN camdeasey.hrly_op_data.begin_hour
    IS 'Hour of the hourly operating data. ';
COMMENT ON COLUMN camdeasey.hrly_op_data.op_time
    IS 'The fraction of the clock hour during which the unit (or any unit venting through the stack) combusted any fuel. ';
COMMENT ON COLUMN camdeasey.hrly_op_data.hr_load
    IS 'Gross unit load or steam load value during unit operation. ';
COMMENT ON COLUMN camdeasey.hrly_op_data.load_uom_cd
    IS 'Code used to identify the load units of measure. ';