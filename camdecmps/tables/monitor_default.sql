CREATE TABLE IF NOT EXISTS camdecmps.monitor_default
(
    mondef_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    parameter_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    begin_date date NOT NULL,
    begin_hour numeric(2,0) NOT NULL,
    end_date date,
    end_hour numeric(2,0),
    operating_condition_cd character varying(7) COLLATE pg_catalog."default",
    default_value numeric(15,4) NOT NULL,
    default_purpose_cd character varying(7) COLLATE pg_catalog."default",
    default_source_cd character varying(7) COLLATE pg_catalog."default",
    fuel_cd character varying(7) COLLATE pg_catalog."default",
    group_id character varying(10) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    default_uom_cd character varying(7) COLLATE pg_catalog."default"
);

COMMENT ON TABLE camdecmps.monitor_default
    IS 'List of unit-specific and fuel-specific constants used in Emissions calculations.  Record Type 531.';

COMMENT ON COLUMN camdecmps.monitor_default.mondef_id
    IS 'Unique identifier of a monitoring default record. ';

COMMENT ON COLUMN camdecmps.monitor_default.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmps.monitor_default.parameter_cd
    IS 'Code used to identify the parameter. ';

COMMENT ON COLUMN camdecmps.monitor_default.begin_date
    IS 'Date on which information became effective or activity started. ';

COMMENT ON COLUMN camdecmps.monitor_default.begin_hour
    IS 'Hour in which information became effective. ';

COMMENT ON COLUMN camdecmps.monitor_default.end_date
    IS 'Last date in which information was effective.  This date will be null for active records. ';

COMMENT ON COLUMN camdecmps.monitor_default.end_hour
    IS 'Last hour in which information was effective.  This value will be null for active records. ';

COMMENT ON COLUMN camdecmps.monitor_default.operating_condition_cd
    IS 'Code used to identify the operating condition. ';

COMMENT ON COLUMN camdecmps.monitor_default.default_value
    IS 'Value of default, maximum, minimum or constant. ';

COMMENT ON COLUMN camdecmps.monitor_default.default_purpose_cd
    IS 'Code used to identify the purpose or intended use of defaults, maximums and constants. ';

COMMENT ON COLUMN camdecmps.monitor_default.default_source_cd
    IS 'Code used to identify the source of the default value. ';

COMMENT ON COLUMN camdecmps.monitor_default.fuel_cd
    IS 'Code used to identify the type of fuel. ';

COMMENT ON COLUMN camdecmps.monitor_default.group_id
    IS 'For a group of identical units using testing to determine default NOx rate, this ID identifies the group. ';

COMMENT ON COLUMN camdecmps.monitor_default.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.monitor_default.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.monitor_default.update_date
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmps.monitor_default.default_uom_cd
    IS 'Code used to identify the hourly parameter units of measure. ';
