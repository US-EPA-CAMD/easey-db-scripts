CREATE TABLE IF NOT EXISTS camdecmpswks.daily_fuel
(
    daily_fuel_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    daily_emission_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    fuel_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    daily_fuel_feed numeric(13,1),
    carbon_content_used numeric(5,1),
    fuel_carbon_burned numeric(13,1),
    calc_fuel_carbon_burned numeric(13,1),
    userid character varying(25) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone,
    rpt_period_id numeric(38,0) NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpswks.daily_fuel
    IS 'The daily fuel data for Appendix G CO2 reporting.';

COMMENT ON COLUMN camdecmpswks.daily_fuel.daily_fuel_id
    IS 'Unique identifier of a daily fuel record.';

COMMENT ON COLUMN camdecmpswks.daily_fuel.daily_emission_id
    IS 'Unique identifier of a daily emission record.';

COMMENT ON COLUMN camdecmpswks.daily_fuel.fuel_cd
    IS 'Code used to identify the type of fuel. ';

COMMENT ON COLUMN camdecmpswks.daily_fuel.daily_fuel_feed
    IS 'Feed rate of fuel.';

COMMENT ON COLUMN camdecmpswks.daily_fuel.carbon_content_used
    IS 'Amount of carbon burned as a percentage of the daily feed rate';

COMMENT ON COLUMN camdecmpswks.daily_fuel.fuel_carbon_burned
    IS 'Amount of carbon burned.';

COMMENT ON COLUMN camdecmpswks.daily_fuel.calc_fuel_carbon_burned
    IS 'Calculated total amount of carbon burned.';

COMMENT ON COLUMN camdecmpswks.daily_fuel.userid
    IS 'User account or source of data that added or updated record.';

COMMENT ON COLUMN camdecmpswks.daily_fuel.add_date
    IS 'Date and time in which record was added.';

COMMENT ON COLUMN camdecmpswks.daily_fuel.update_date
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmpswks.daily_fuel.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmpswks.daily_fuel.mon_loc_id
    IS 'Unique identifier of a monitor location record. ';
