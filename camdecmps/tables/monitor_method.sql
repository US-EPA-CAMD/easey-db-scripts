CREATE TABLE IF NOT EXISTS camdecmps.monitor_method
(
    mon_method_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    parameter_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    sub_data_cd character varying(7) COLLATE pg_catalog."default",
    bypass_approach_cd character varying(7) COLLATE pg_catalog."default",
    method_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    begin_date date NOT NULL,
    begin_hour numeric(2,0) NOT NULL,
    end_date date,
    end_hour numeric(2,0),
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);

COMMENT ON TABLE camdecmps.monitor_method
    IS 'Identifies each parameter that a specific monitoring plan is monitoring.';

COMMENT ON COLUMN camdecmps.monitor_method.mon_method_id
    IS 'Unique identifier of a monitoring method record. ';

COMMENT ON COLUMN camdecmps.monitor_method.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmps.monitor_method.parameter_cd
    IS 'Code used to identify the parameter. ';

COMMENT ON COLUMN camdecmps.monitor_method.sub_data_cd
    IS 'Code used to identify the substitute data approach type. ';

COMMENT ON COLUMN camdecmps.monitor_method.bypass_approach_cd
    IS 'Code used to identify the value to be used for an unmonitored bypass stack. ';

COMMENT ON COLUMN camdecmps.monitor_method.method_cd
    IS 'Code used to identify the monitoring methodology. ';

COMMENT ON COLUMN camdecmps.monitor_method.begin_date
    IS 'Date on which information became effective or activity started. ';

COMMENT ON COLUMN camdecmps.monitor_method.begin_hour
    IS 'Hour in which information became effective. ';

COMMENT ON COLUMN camdecmps.monitor_method.end_date
    IS 'Last date in which information was effective.  This date will be null for active records. ';

COMMENT ON COLUMN camdecmps.monitor_method.end_hour
    IS 'Last hour in which information was effective.  This value will be null for active records. ';

COMMENT ON COLUMN camdecmps.monitor_method.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.monitor_method.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.monitor_method.update_date
    IS 'Date and time in which record was last updated. ';
