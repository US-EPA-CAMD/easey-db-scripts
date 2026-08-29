CREATE TABLE IF NOT EXISTS camdeasey.monitor_plan_location
(
    mon_plan_id varchar(45) NOT NULL,
    mon_loc_id varchar(45) NOT NULL,
    load_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (mon_plan_id, mon_loc_id)
);
COMMENT ON TABLE camdeasey.monitor_plan_location
    IS 'Identifies the location identity key associated with a plan.';
COMMENT ON COLUMN camdeasey.monitor_plan_location.mon_plan_id
    IS 'Unique identifier of a monitoring plan record. ';
COMMENT ON COLUMN camdeasey.monitor_plan_location.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';
COMMENT ON COLUMN camdeasey.monitor_plan_location.load_date
    IS 'Date and time at which record was loaded from source. ';