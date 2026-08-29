CREATE TABLE IF NOT EXISTS camdeasey.operating_supp_data
(
    op_supp_data_id varchar(45) NOT NULL,
    mon_loc_id varchar(45) NOT NULL,
    fuel_cd varchar(7),
    op_type_cd varchar(7) NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    op_value numeric(13,3)
);
COMMENT ON TABLE camdeasey.operating_supp_data
    IS 'Contains summary information about unit/stack/pipe operating hours and fuel hours by quarter for use by the emissions evaluation routines';
COMMENT ON COLUMN camdeasey.operating_supp_data.op_supp_data_id
    IS 'Unique identifier of an operating supplemental data record. ';
COMMENT ON COLUMN camdeasey.operating_supp_data.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';
COMMENT ON COLUMN camdeasey.operating_supp_data.fuel_cd
    IS 'Code used to identify the type of fuel. ';
COMMENT ON COLUMN camdeasey.operating_supp_data.op_type_cd
    IS 'Code used to identify the operating type. ';
COMMENT ON COLUMN camdeasey.operating_supp_data.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';
COMMENT ON COLUMN camdeasey.operating_supp_data.op_value
    IS 'Number of hours (or other units) corresponding to the calendar year, quarter and operating type code. ';