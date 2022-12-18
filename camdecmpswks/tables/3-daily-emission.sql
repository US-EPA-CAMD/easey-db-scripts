-- Table: camdecmpswks.daily_emission

-- DROP TABLE camdecmpswks.daily_emission;

CREATE TABLE camdecmpswks.daily_emission
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
    calc_total_op_time numeric(4,2),
    CONSTRAINT pk_daily_emission PRIMARY KEY (daily_emission_id),
    CONSTRAINT fk_daily_emission_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_daily_emission_parameter_code FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_daily_emission_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmpswks.daily_emission
    IS 'Daily total massEmissions.  Currently CO2 only from Record Type 331.';

COMMENT ON COLUMN camdecmpswks.daily_emission.daily_emission_id
    IS 'Unique identifier of a daily emission record. ';

COMMENT ON COLUMN camdecmpswks.daily_emission.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmpswks.daily_emission.mon_loc_id
    IS 'Unique identifier of a monitor location record. ';

COMMENT ON COLUMN camdecmpswks.daily_emission.parameter_cd
    IS 'Code used to identify the parameter. ';

COMMENT ON COLUMN camdecmpswks.daily_emission.begin_date
    IS 'Date corresponding to the daily emissions. ';

COMMENT ON COLUMN camdecmpswks.daily_emission.total_daily_emission
    IS 'Total daily CO2 mass emissions. ';

COMMENT ON COLUMN camdecmpswks.daily_emission.adjusted_daily_emission
    IS 'CO2 mass emissions adjusted for CO2 retained in fly ash. ';

COMMENT ON COLUMN camdecmpswks.daily_emission.sorbent_mass_emission
    IS 'Total daily sorbent-related CO2 mass emissions. ';

COMMENT ON COLUMN camdecmpswks.daily_emission.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmpswks.daily_emission.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmpswks.daily_emission.update_date
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmpswks.daily_emission.unadjusted_daily_emission
    IS 'CO2 mass emissions. ';

COMMENT ON COLUMN camdecmpswks.daily_emission.total_carbon_burned
    IS 'Total amount of carbon burned.';

COMMENT ON COLUMN camdecmpswks.daily_emission.calc_total_daily_emission
    IS 'Calculated total daily CO2 mass emissions. ';

COMMENT ON COLUMN camdecmpswks.daily_emission.calc_total_op_time
    IS 'Calculated total operating time.';
-- Index: daily_emission_idx001

-- DROP INDEX camdecmpswks.daily_emission_idx001;

CREATE INDEX IF NOT EXISTS daily_emission_idx001
    ON camdecmpswks.daily_emission USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: daily_emission_idx003

-- DROP INDEX camdecmpswks.daily_emission_idx003;

CREATE INDEX IF NOT EXISTS daily_emission_idx003
    ON camdecmpswks.daily_emission USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_daily_emission_mon_loc_id

-- DROP INDEX camdecmpswks.idx_daily_emission_mon_loc_id;

CREATE INDEX IF NOT EXISTS idx_daily_emission_mon_loc_id
    ON camdecmpswks.daily_emission USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_de_add_date

-- DROP INDEX camdecmpswks.idx_de_add_date;

CREATE INDEX IF NOT EXISTS idx_de_add_date
    ON camdecmpswks.daily_emission USING btree
    (add_date ASC NULLS LAST)
    TABLESPACE pg_default;