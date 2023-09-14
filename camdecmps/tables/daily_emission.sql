CREATE TABLE IF NOT EXISTS camdecmps.daily_emission
(
    daily_emission_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    parameter_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    begin_date date NOT NULL,
    total_daily_emission numeric(10,1),
    adjusted_daily_emission numeric(10,1),
    sorbent_mass_emission numeric(10,1),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    unadjusted_daily_emission numeric(10,1),
    total_carbon_burned numeric(13,1),
    calc_total_daily_emission numeric(10,1),
    calc_total_op_time numeric(4,2)
);

COMMENT ON TABLE camdecmps.daily_emission
    IS 'Daily total massEmissions.  Currently CO2 only from Record Type 331.';

COMMENT ON COLUMN camdecmps.daily_emission.daily_emission_id
    IS 'Unique identifier of a daily emission record. ';

COMMENT ON COLUMN camdecmps.daily_emission.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmps.daily_emission.mon_loc_id
    IS 'Unique identifier of a monitor location record. ';

COMMENT ON COLUMN camdecmps.daily_emission.parameter_cd
    IS 'Code used to identify the parameter. ';

COMMENT ON COLUMN camdecmps.daily_emission.begin_date
    IS 'Date corresponding to the daily emissions. ';

COMMENT ON COLUMN camdecmps.daily_emission.total_daily_emission
    IS 'Total daily CO2 mass emissions. ';

COMMENT ON COLUMN camdecmps.daily_emission.adjusted_daily_emission
    IS 'CO2 mass emissions adjusted for CO2 retained in fly ash. ';

COMMENT ON COLUMN camdecmps.daily_emission.sorbent_mass_emission
    IS 'Total daily sorbent-related CO2 mass emissions. ';

COMMENT ON COLUMN camdecmps.daily_emission.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.daily_emission.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.daily_emission.update_date
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmps.daily_emission.unadjusted_daily_emission
    IS 'CO2 mass emissions. ';

COMMENT ON COLUMN camdecmps.daily_emission.total_carbon_burned
    IS 'Total amount of carbon burned.';

COMMENT ON COLUMN camdecmps.daily_emission.calc_total_daily_emission
    IS 'Calculated total daily CO2 mass emissions. ';

COMMENT ON COLUMN camdecmps.daily_emission.calc_total_op_time
    IS 'Calculated total operating time.';
