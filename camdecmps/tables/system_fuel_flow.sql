CREATE TABLE IF NOT EXISTS camdecmps.system_fuel_flow
(
    sys_fuel_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_sys_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    max_rate numeric(9,1) NOT NULL,
    begin_date date,
    begin_hour numeric(2,0),
    end_date date,
    end_hour numeric(2,0),
    max_rate_source_cd character varying(7) COLLATE pg_catalog."default",
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    sys_fuel_uom_cd character varying(7) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmps.system_fuel_flow
    IS 'Maximum fuel flow for oil and gas system.  Record Type 540.';

COMMENT ON COLUMN camdecmps.system_fuel_flow.sys_fuel_id
    IS 'Unique identifier of a system fuel flow record. ';

COMMENT ON COLUMN camdecmps.system_fuel_flow.mon_sys_id
    IS 'Unique identifier of a monitoring system record. ';

COMMENT ON COLUMN camdecmps.system_fuel_flow.max_rate
    IS 'Maximum fuel flow rate. ';

COMMENT ON COLUMN camdecmps.system_fuel_flow.begin_date
    IS 'Date on which information became effective or activity started. ';

COMMENT ON COLUMN camdecmps.system_fuel_flow.begin_hour
    IS 'Hour in which information became effective. ';

COMMENT ON COLUMN camdecmps.system_fuel_flow.end_date
    IS 'Last date in which information was effective.  This date will be null for active records. ';

COMMENT ON COLUMN camdecmps.system_fuel_flow.end_hour
    IS 'Last hour in which information was effective or hour in which activity ended. This value will be null for active records. ';

COMMENT ON COLUMN camdecmps.system_fuel_flow.max_rate_source_cd
    IS 'Code used to identify the source of maximum fuel flow. ';

COMMENT ON COLUMN camdecmps.system_fuel_flow.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.system_fuel_flow.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.system_fuel_flow.update_date
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmps.system_fuel_flow.sys_fuel_uom_cd
    IS 'Code used to identify the fuel flow units of measure. ';
