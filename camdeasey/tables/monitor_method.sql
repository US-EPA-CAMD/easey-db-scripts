CREATE TABLE IF NOT EXISTS camdeasey.monitor_method
(
    mon_method_id varchar(45) NOT NULL,
    mon_loc_id varchar(45) NOT NULL,
    parameter_cd varchar(7) NOT NULL,
    method_cd varchar(7) NOT NULL,
    sub_data_cd varchar(7),
    bypass_approach_cd varchar(7),
    begin_date timestamp without time zone NOT NULL,
    begin_hour numeric(2,0) NOT NULL,
    end_date timestamp without time zone,
    end_hour numeric(2,0),
    PRIMARY KEY (mon_method_id)
);
COMMENT ON TABLE camdeasey.monitor_method
    IS 'Identifies each parameter that a specific monitoring plan is monitoring.';
COMMENT ON COLUMN camdeasey.monitor_method.mon_method_id
    IS 'Unique identifier of a monitoring method record. ';
COMMENT ON COLUMN camdeasey.monitor_method.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';
COMMENT ON COLUMN camdeasey.monitor_method.parameter_cd
    IS 'Code used to identify the parameter. ';
COMMENT ON COLUMN camdeasey.monitor_method.method_cd
    IS 'Code used to identify the monitoring methodology. ';
COMMENT ON COLUMN camdeasey.monitor_method.sub_data_cd
    IS 'Code used to identify the substitute data approach type. ';
COMMENT ON COLUMN camdeasey.monitor_method.bypass_approach_cd
    IS 'Code used to identify the value to be used for an unmonitored bypass stack. ';
COMMENT ON COLUMN camdeasey.monitor_method.begin_date
    IS 'Date on which information became effective or activity started. ';
COMMENT ON COLUMN camdeasey.monitor_method.begin_hour
    IS 'Hour in which information became effective. ';
COMMENT ON COLUMN camdeasey.monitor_method.end_date
    IS 'Last date in which information was effective.  This date will be null for active records. ';
COMMENT ON COLUMN camdeasey.monitor_method.end_hour
    IS 'Last hour in which information was effective.  This value will be null for active records. ';