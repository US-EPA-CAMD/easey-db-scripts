-- Table: camddmw_arch.hour_unit_mats_data_a

-- DROP TABLE camddmw_arch.hour_unit_mats_data_a;

CREATE TABLE IF NOT EXISTS camddmw_arch.hour_unit_mats_data_a
(
    unit_id numeric(38,0) NOT NULL,
    op_date date NOT NULL,
    op_hour numeric(2,0) NOT NULL,
    op_time numeric(3,2),
    gload numeric(8,2),
    sload numeric(8,2),
    tload numeric(8,2),
    heat_input numeric(15,3),
    heat_input_measure_flg character varying(60) COLLATE pg_catalog."default",
    hg_rate_eo numeric(22,10),
    hg_rate_hi numeric(22,10),
    hg_mass numeric(22,10),
    hg_measure_flg character varying(60) COLLATE pg_catalog."default",
    hcl_rate_eo numeric(22,10),
    hcl_rate_hi numeric(22,10),
    hcl_mass numeric(22,10),
    hcl_measure_flg character varying(60) COLLATE pg_catalog."default",
    hf_rate_eo numeric(22,10),
    hf_rate_hi numeric(22,10),
    hf_mass numeric(22,10),
    hf_measure_flg character varying(60) COLLATE pg_catalog."default",
    rpt_period_id numeric(38,0) NOT NULL,
    op_year numeric(4,0) NOT NULL,
    data_source character varying(35) COLLATE pg_catalog."default" NOT NULL,
    userid character varying(160) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp(0) without time zone NOT NULL,
    CONSTRAINT pk_hour_unit_mats_data PRIMARY KEY (unit_id, op_date, op_hour)
) PARTITION BY RANGE (op_date);


COMMENT ON TABLE camddmw_arch.hour_unit_mats_data_a
    IS 'Hourly emissions data for individual MATS monitor locations.';

COMMENT ON COLUMN camddmw_arch.hour_unit_mats_data_a.unit_id
    IS 'Unique identifier of a unit';

COMMENT ON COLUMN camddmw_arch.hour_unit_mats_data_a.op_date
    IS 'Date on which the hourly data was collected';

COMMENT ON COLUMN camddmw_arch.hour_unit_mats_data_a.op_hour
    IS 'Hour during which data was collected (range is 0 - 23)';

COMMENT ON COLUMN camddmw_arch.hour_unit_mats_data_a.op_time
    IS 'Fraction of hourly time unit was operating';

COMMENT ON COLUMN camddmw_arch.hour_unit_mats_data_a.gload
    IS 'Output measured in Megawatts';

COMMENT ON COLUMN camddmw_arch.hour_unit_mats_data_a.sload
    IS 'Output measured in 1000 lbs/hr of steam';

COMMENT ON COLUMN camddmw_arch.hour_unit_mats_data_a.tload
    IS 'Output measured in mmBtu/hr';

COMMENT ON COLUMN camddmw_arch.hour_unit_mats_data_a.heat_input
    IS 'Amount of heat (mmBtu) produced by burning fuel for the unit';

COMMENT ON COLUMN camddmw_arch.hour_unit_mats_data_a.heat_input_measure_flg
    IS 'Indicates whether the value for this parameter was measured or derived due to missing data';

COMMENT ON COLUMN camddmw_arch.hour_unit_mats_data_a.hg_rate_eo
    IS 'The Electrical Output Based Mercury (Hg) Rate for the time period. (lb/GWh)';

COMMENT ON COLUMN camddmw_arch.hour_unit_mats_data_a.hg_rate_hi
    IS 'The Heat Input Based Mercury (Hg) Rate for the time period. (lb/TBtu)';

COMMENT ON COLUMN camddmw_arch.hour_unit_mats_data_a.hg_mass
    IS 'The Mercury (Hg) Mass for the time period. (lb)';

COMMENT ON COLUMN camddmw_arch.hour_unit_mats_data_a.hg_measure_flg
    IS 'Indicates whether the values for Mercury (Hg) were measured or unavailable due to missing data';

COMMENT ON COLUMN camddmw_arch.hour_unit_mats_data_a.hcl_rate_eo
    IS 'The Electrical Output Based Hydrogen Chloride (HCl) Rate for the time period. (lb/MWh)';

COMMENT ON COLUMN camddmw_arch.hour_unit_mats_data_a.hcl_rate_hi
    IS 'The Heat Input Based Hydrogen Chloride (HCl) Rate for the time period. (lb/mmBtu)';

COMMENT ON COLUMN camddmw_arch.hour_unit_mats_data_a.hcl_mass
    IS 'The Hydrogen Chloride (HCl) Mass for the time period. (lb)';

COMMENT ON COLUMN camddmw_arch.hour_unit_mats_data_a.hcl_measure_flg
    IS 'Indicates whether the values for Hydrogen Chloride (HCl) were measured or unavailable due to missing data';

COMMENT ON COLUMN camddmw_arch.hour_unit_mats_data_a.hf_rate_eo
    IS 'The Electrical Output Based Hydrogen Fluoride (HF) Rate for the time period. (lb/MWh)';

COMMENT ON COLUMN camddmw_arch.hour_unit_mats_data_a.hf_rate_hi
    IS 'The Heat Input Based Hydrogen Fluoride (HF) Rate for the time period. (lb/mmBtu)';

COMMENT ON COLUMN camddmw_arch.hour_unit_mats_data_a.hf_mass
    IS 'The Hydrogen Fluoride (HF) Mass for the time period. (lb)';

COMMENT ON COLUMN camddmw_arch.hour_unit_mats_data_a.hf_measure_flg
    IS 'Indicates whether the values for Hydrogen Fluoride (HF) were measured or unavailable due to missing data';

COMMENT ON COLUMN camddmw_arch.hour_unit_mats_data_a.rpt_period_id
    IS 'Reporting Period table id for the data';

COMMENT ON COLUMN camddmw_arch.hour_unit_mats_data_a.op_year
    IS 'Year in which data was collected';

COMMENT ON COLUMN camddmw_arch.hour_unit_mats_data_a.data_source
    IS 'Source of the data';

COMMENT ON COLUMN camddmw_arch.hour_unit_mats_data_a.userid
    IS 'Initials of user who last modified data';

COMMENT ON COLUMN camddmw_arch.hour_unit_mats_data_a.add_date
    IS 'Date on which the record was added';

-- Index: idx_hour_unit_mats_data_op_time

-- DROP INDEX camddmw_arch.idx_hour_unit_mats_data_op_time;

CREATE INDEX IF NOT EXISTS idx_hour_unit_mats_data_op_time
    ON camddmw_arch.hour_unit_mats_data_a USING btree
    (op_time ASC NULLS LAST);

-- Index: idx_hour_unit_mats_data_op_year

-- DROP INDEX camddmw_arch.idx_hour_unit_mats_data_op_year;

CREATE INDEX IF NOT EXISTS idx_hour_unit_mats_data_op_year
    ON camddmw_arch.hour_unit_mats_data_a USING btree
    (op_year ASC NULLS LAST);

-- Index: idx_hour_unit_mats_data_rpt_period_id

-- DROP INDEX camddmw_arch.idx_hour_unit_mats_data_rpt_period_id;

CREATE INDEX IF NOT EXISTS idx_hour_unit_mats_data_rpt_period_id
    ON camddmw_arch.hour_unit_mats_data_a USING btree
    (rpt_period_id ASC NULLS LAST);

-- Partitions SQL

CREATE TABLE IF NOT EXISTS camddmw_arch.hour_unit_mats_data_a_dm_em_uh_2015q1 PARTITION OF camddmw_arch.hour_unit_mats_data_a
    FOR VALUES FROM ('2015-01-01') TO ('2015-04-01');

--ALTER TABLE camddmw_arch.hour_unit_mats_data_a_dm_em_uh_2015q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.hour_unit_mats_data_a_dm_em_uh_2015q2 PARTITION OF camddmw_arch.hour_unit_mats_data_a
    FOR VALUES FROM ('2015-04-01') TO ('2015-07-01');

--ALTER TABLE camddmw_arch.hour_unit_mats_data_a_dm_em_uh_2015q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.hour_unit_mats_data_a_dm_em_uh_2015q3 PARTITION OF camddmw_arch.hour_unit_mats_data_a
    FOR VALUES FROM ('2015-07-01') TO ('2015-10-01');

--ALTER TABLE camddmw_arch.hour_unit_mats_data_a_dm_em_uh_2015q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.hour_unit_mats_data_a_dm_em_uh_2015q4 PARTITION OF camddmw_arch.hour_unit_mats_data_a
    FOR VALUES FROM ('2015-10-01') TO ('2016-01-01');

--ALTER TABLE camddmw_arch.hour_unit_mats_data_a_dm_em_uh_2015q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.hour_unit_mats_data_a_dm_em_uh_2016q1 PARTITION OF camddmw_arch.hour_unit_mats_data_a
    FOR VALUES FROM ('2016-01-01') TO ('2016-04-01');

--ALTER TABLE camddmw_arch.hour_unit_mats_data_a_dm_em_uh_2016q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.hour_unit_mats_data_a_dm_em_uh_2016q2 PARTITION OF camddmw_arch.hour_unit_mats_data_a
    FOR VALUES FROM ('2016-04-01') TO ('2016-07-01');

--ALTER TABLE camddmw_arch.hour_unit_mats_data_a_dm_em_uh_2016q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.hour_unit_mats_data_a_dm_em_uh_2016q3 PARTITION OF camddmw_arch.hour_unit_mats_data_a
    FOR VALUES FROM ('2016-07-01') TO ('2016-10-01');

--ALTER TABLE camddmw_arch.hour_unit_mats_data_a_dm_em_uh_2016q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.hour_unit_mats_data_a_dm_em_uh_2016q4 PARTITION OF camddmw_arch.hour_unit_mats_data_a
    FOR VALUES FROM ('2016-10-01') TO ('2017-01-01');

--ALTER TABLE camddmw_arch.hour_unit_mats_data_a_dm_em_uh_2016q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.hour_unit_mats_data_a_dm_em_uh_before PARTITION OF camddmw_arch.hour_unit_mats_data_a
    FOR VALUES FROM (MINVALUE) TO ('2015-01-01');

--ALTER TABLE camddmw_arch.hour_unit_mats_data_a_dm_em_uh_before
--    OWNER to "uImcwuf4K9dyaxeL";
