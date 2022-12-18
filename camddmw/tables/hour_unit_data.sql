-- Table: camddmw.hour_unit_data

-- DROP TABLE camddmw.hour_unit_data;

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data
(
    unit_id numeric(38,0) NOT NULL,
    op_date date NOT NULL,
    op_hour numeric(2,0) NOT NULL,
    op_time numeric(4,2),
    gload numeric(8,2),
    sload numeric(8,2),
    tload numeric(8,2),
    heat_input numeric(15,3),
    heat_input_measure_flg character varying(60) COLLATE pg_catalog."default",
    so2_mass numeric(15,3),
    so2_mass_measure_flg character varying(60) COLLATE pg_catalog."default",
    so2_rate numeric(15,3),
    so2_rate_measure_flg character varying(60) COLLATE pg_catalog."default",
    co2_mass numeric(15,3),
    co2_mass_measure_flg character varying(60) COLLATE pg_catalog."default",
    co2_rate numeric(15,3),
    co2_rate_measure_flg character varying(60) COLLATE pg_catalog."default",
    nox_mass numeric(15,3),
    nox_mass_measure_flg character varying(60) COLLATE pg_catalog."default",
    nox_rate numeric(15,3),
    nox_rate_measure_flg character varying(60) COLLATE pg_catalog."default",
    rpt_period_id numeric(38,0),
    op_year numeric(4,0),
    data_source character varying(35) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    CONSTRAINT pk_hour_unit_data PRIMARY KEY (unit_id, op_date, op_hour)
) PARTITION BY RANGE (op_date);


COMMENT ON TABLE camddmw.hour_unit_data
    IS 'Hourly emissions data at the unit level';

COMMENT ON COLUMN camddmw.hour_unit_data.unit_id
    IS 'Unique identifier of a unit';

COMMENT ON COLUMN camddmw.hour_unit_data.op_date
    IS 'Date on which the hourly data was collected';

COMMENT ON COLUMN camddmw.hour_unit_data.op_hour
    IS 'Hour during which data was collected (range is 0 - 23)';

COMMENT ON COLUMN camddmw.hour_unit_data.op_time
    IS 'Fraction of hourly time unit was operating';

COMMENT ON COLUMN camddmw.hour_unit_data.gload
    IS 'Sum of output in megawatts';

COMMENT ON COLUMN camddmw.hour_unit_data.sload
    IS 'Steam output measured in lbs/hr';

COMMENT ON COLUMN camddmw.hour_unit_data.tload
    IS 'Steam output measured in mmBtu/hr';

COMMENT ON COLUMN camddmw.hour_unit_data.heat_input
    IS 'Amount of heat (mmBtu) produced by burning fuel for the unit';

COMMENT ON COLUMN camddmw.hour_unit_data.heat_input_measure_flg
    IS 'Indicates whether the value for this parameter was measured or derived due to missing data';

COMMENT ON COLUMN camddmw.hour_unit_data.so2_mass
    IS 'Mass of SO2 (lbs) emitted by a unit';

COMMENT ON COLUMN camddmw.hour_unit_data.so2_mass_measure_flg
    IS 'Indicates whether the value for this parameter was measured or derived due to missing data';

COMMENT ON COLUMN camddmw.hour_unit_data.so2_rate
    IS 'Average SO2 hourly emissions rate (lbs/mmBtu) for a unit';

COMMENT ON COLUMN camddmw.hour_unit_data.so2_rate_measure_flg
    IS 'Indicates whether the value for this parameter was measured or derived due to missing data';

COMMENT ON COLUMN camddmw.hour_unit_data.co2_mass
    IS 'CO2 mass emissions (short tons).';

COMMENT ON COLUMN camddmw.hour_unit_data.co2_mass_measure_flg
    IS 'Indicates whether the value for this parameter was measured or derived due to missing data';

COMMENT ON COLUMN camddmw.hour_unit_data.co2_rate
    IS 'Average CO2 hourly emissions rate (tons/mmBtu) for a unit';

COMMENT ON COLUMN camddmw.hour_unit_data.co2_rate_measure_flg
    IS 'Indicates whether the value for this parameter was measured or derived due to missing data';

COMMENT ON COLUMN camddmw.hour_unit_data.nox_mass
    IS 'Mass of NOx (lbs) emitted by a unit';

COMMENT ON COLUMN camddmw.hour_unit_data.nox_mass_measure_flg
    IS 'Indicates whether the value for this parameter was measured or derived due to missing data';

COMMENT ON COLUMN camddmw.hour_unit_data.nox_rate
    IS 'Average NOx hourly emissions rate (lbs/mmBtu) for a unit';

COMMENT ON COLUMN camddmw.hour_unit_data.nox_rate_measure_flg
    IS 'Indicates whether the value for this parameter was measured or derived due to missing data';

COMMENT ON COLUMN camddmw.hour_unit_data.rpt_period_id
    IS 'Unique identifier of a reporting period';

COMMENT ON COLUMN camddmw.hour_unit_data.op_year
    IS 'Year in which data was collected';

COMMENT ON COLUMN camddmw.hour_unit_data.data_source
    IS 'Source of the data';

COMMENT ON COLUMN camddmw.hour_unit_data.userid
    IS 'Initials of user who last modified data';

COMMENT ON COLUMN camddmw.hour_unit_data.add_date
    IS 'Date on which the record was added';

-- Index: idx_hour_unit_data_op_time

-- DROP INDEX camddmw.idx_hour_unit_data_op_time;

CREATE INDEX IF NOT EXISTS idx_hour_unit_data_op_time
    ON camddmw.hour_unit_data USING btree
    (op_time ASC NULLS LAST);

-- Index: idx_hour_unit_data_op_year

-- DROP INDEX camddmw.idx_hour_unit_data_op_year;

CREATE INDEX IF NOT EXISTS idx_hour_unit_data_op_year
    ON camddmw.hour_unit_data USING btree
    (op_year ASC NULLS LAST);

-- Index: idx_hour_unit_data_rpt_period_id

-- DROP INDEX camddmw.idx_hour_unit_data_rpt_period_id;

CREATE INDEX IF NOT EXISTS idx_hour_unit_data_rpt_period_id
    ON camddmw.hour_unit_data USING btree
    (rpt_period_id ASC NULLS LAST);

-- Partitions SQL

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2007w52 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM (MINVALUE) TO ('2008-01-06');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2007w52
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w01 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2008-01-06') TO ('2017-01-08');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w01
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w02 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-01-08') TO ('2017-01-15');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w02
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w03 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-01-15') TO ('2017-01-22');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w03
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w04 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-01-22') TO ('2017-01-29');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w04
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w05 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-01-29') TO ('2017-02-05');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w05
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w06 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-02-05') TO ('2017-02-12');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w06
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w07 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-02-12') TO ('2017-02-19');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w07
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w08 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-02-19') TO ('2017-02-26');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w08
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w09 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-02-26') TO ('2017-03-05');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w09
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w10 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-03-05') TO ('2017-03-12');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w10
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w11 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-03-12') TO ('2017-03-19');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w11
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w12 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-03-19') TO ('2017-03-26');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w12
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w13 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-03-26') TO ('2017-04-02');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w13
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w14 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-04-02') TO ('2017-04-09');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w14
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w15 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-04-09') TO ('2017-04-16');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w15
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w16 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-04-16') TO ('2017-04-23');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w16
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w17 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-04-23') TO ('2017-04-30');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w17
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w18 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-04-30') TO ('2017-05-07');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w18
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w19 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-05-07') TO ('2017-05-14');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w19
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w20 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-05-14') TO ('2017-05-21');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w20
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w21 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-05-21') TO ('2017-05-28');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w21
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w22 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-05-28') TO ('2017-06-04');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w22
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w23 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-06-04') TO ('2017-06-11');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w23
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w24 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-06-11') TO ('2017-06-18');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w24
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w25 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-06-18') TO ('2017-06-25');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w25
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w26 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-06-25') TO ('2017-07-02');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w26
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w27 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-07-02') TO ('2017-07-09');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w27
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w28 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-07-09') TO ('2017-07-16');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w28
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w29 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-07-16') TO ('2017-07-23');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w29
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w30 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-07-23') TO ('2017-07-30');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w30
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w31 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-07-30') TO ('2017-08-06');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w31
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w32 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-08-06') TO ('2017-08-13');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w32
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w33 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-08-13') TO ('2017-08-20');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w33
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w34 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-08-20') TO ('2017-08-27');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w34
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w35 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-08-27') TO ('2017-09-03');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w35
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w36 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-09-03') TO ('2017-09-10');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w36
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w37 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-09-10') TO ('2017-09-17');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w37
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w38 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-09-17') TO ('2017-09-24');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w38
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w39 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-09-24') TO ('2017-10-01');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w39
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w40 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-10-01') TO ('2017-10-08');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w40
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w41 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-10-08') TO ('2017-10-15');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w41
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w42 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-10-15') TO ('2017-10-22');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w42
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w43 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-10-22') TO ('2017-10-29');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w43
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w44 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-10-29') TO ('2017-11-05');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w44
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w45 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-11-05') TO ('2017-11-12');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w45
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w46 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-11-12') TO ('2017-11-19');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w46
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w47 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-11-19') TO ('2017-11-26');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w47
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w48 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-11-26') TO ('2017-12-03');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w48
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w49 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-12-03') TO ('2017-12-10');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w49
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w50 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-12-10') TO ('2017-12-17');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w50
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w51 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-12-17') TO ('2017-12-24');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w51
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w52 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-12-24') TO ('2017-12-31');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w52
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2017w53 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2017-12-31') TO ('2018-01-07');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2017w53
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w01 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-01-07') TO ('2018-01-14');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w01
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w02 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-01-14') TO ('2018-01-21');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w02
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w03 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-01-21') TO ('2018-01-28');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w03
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w04 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-01-28') TO ('2018-02-04');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w04
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w05 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-02-04') TO ('2018-02-11');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w05
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w06 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-02-11') TO ('2018-02-18');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w06
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w07 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-02-18') TO ('2018-02-25');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w07
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w08 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-02-25') TO ('2018-03-04');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w08
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w09 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-03-04') TO ('2018-03-11');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w09
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w10 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-03-11') TO ('2018-03-18');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w10
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w11 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-03-18') TO ('2018-03-25');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w11
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w12 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-03-25') TO ('2018-04-01');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w12
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w13 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-04-01') TO ('2018-04-08');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w13
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w14 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-04-08') TO ('2018-04-15');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w14
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w15 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-04-15') TO ('2018-04-22');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w15
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w16 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-04-22') TO ('2018-04-29');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w16
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w17 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-04-29') TO ('2018-05-06');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w17
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w18 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-05-06') TO ('2018-05-13');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w18
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w19 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-05-13') TO ('2018-05-20');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w19
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w20 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-05-20') TO ('2018-05-27');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w20
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w21 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-05-27') TO ('2018-06-03');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w21
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w22 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-06-03') TO ('2018-06-10');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w22
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w23 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-06-10') TO ('2018-06-17');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w23
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w24 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-06-17') TO ('2018-06-24');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w24
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w25 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-06-24') TO ('2018-07-01');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w25
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w26 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-07-01') TO ('2018-07-08');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w26
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w27 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-07-08') TO ('2018-07-15');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w27
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w28 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-07-15') TO ('2018-07-22');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w28
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w29 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-07-22') TO ('2018-07-29');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w29
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w30 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-07-29') TO ('2018-08-05');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w30
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w31 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-08-05') TO ('2018-08-12');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w31
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w32 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-08-12') TO ('2018-08-19');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w32
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w33 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-08-19') TO ('2018-08-26');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w33
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w34 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-08-26') TO ('2018-09-02');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w34
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w35 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-09-02') TO ('2018-09-09');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w35
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w36 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-09-09') TO ('2018-09-16');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w36
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w37 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-09-16') TO ('2018-09-23');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w37
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w38 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-09-23') TO ('2018-09-30');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w38
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w39 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-09-30') TO ('2018-10-07');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w39
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w40 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-10-07') TO ('2018-10-14');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w40
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w41 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-10-14') TO ('2018-10-21');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w41
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w42 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-10-21') TO ('2018-10-28');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w42
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w43 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-10-28') TO ('2018-11-04');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w43
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w44 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-11-04') TO ('2018-11-11');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w44
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w45 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-11-11') TO ('2018-11-18');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w45
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w46 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-11-18') TO ('2018-11-25');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w46
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w47 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-11-25') TO ('2018-12-02');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w47
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w48 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-12-02') TO ('2018-12-09');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w48
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w49 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-12-09') TO ('2018-12-16');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w49
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w50 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-12-16') TO ('2018-12-23');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w50
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w51 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-12-23') TO ('2018-12-30');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w51
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2018w52 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2018-12-30') TO ('2019-01-06');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2018w52
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w01 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-01-06') TO ('2019-01-13');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w01
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w02 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-01-13') TO ('2019-01-20');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w02
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w03 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-01-20') TO ('2019-01-27');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w03
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w04 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-01-27') TO ('2019-02-03');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w04
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w05 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-02-03') TO ('2019-02-10');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w05
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w06 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-02-10') TO ('2019-02-17');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w06
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w07 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-02-17') TO ('2019-02-24');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w07
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w08 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-02-24') TO ('2019-03-03');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w08
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w09 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-03-03') TO ('2019-03-10');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w09
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w10 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-03-10') TO ('2019-03-17');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w10
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w11 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-03-17') TO ('2019-03-24');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w11
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w12 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-03-24') TO ('2019-03-31');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w12
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w13 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-03-31') TO ('2019-04-07');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w13
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w14 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-04-07') TO ('2019-04-14');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w14
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w15 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-04-14') TO ('2019-04-21');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w15
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w16 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-04-21') TO ('2019-04-28');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w16
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w17 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-04-28') TO ('2019-05-05');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w17
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w18 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-05-05') TO ('2019-05-12');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w18
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w19 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-05-12') TO ('2019-05-19');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w19
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w20 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-05-19') TO ('2019-05-26');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w20
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w21 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-05-26') TO ('2019-06-02');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w21
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w22 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-06-02') TO ('2019-06-09');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w22
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w23 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-06-09') TO ('2019-06-16');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w23
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w24 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-06-16') TO ('2019-06-23');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w24
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w25 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-06-23') TO ('2019-06-30');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w25
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w26 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-06-30') TO ('2019-07-07');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w26
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w27 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-07-07') TO ('2019-07-14');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w27
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w28 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-07-14') TO ('2019-07-21');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w28
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w29 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-07-21') TO ('2019-07-28');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w29
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w30 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-07-28') TO ('2019-08-04');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w30
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w31 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-08-04') TO ('2019-08-11');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w31
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w32 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-08-11') TO ('2019-08-18');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w32
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w33 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-08-18') TO ('2019-08-25');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w33
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w34 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-08-25') TO ('2019-09-01');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w34
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w35 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-09-01') TO ('2019-09-08');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w35
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w36 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-09-08') TO ('2019-09-15');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w36
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w37 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-09-15') TO ('2019-09-22');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w37
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w38 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-09-22') TO ('2019-09-29');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w38
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w39 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-09-29') TO ('2019-10-06');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w39
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w40 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-10-06') TO ('2019-10-13');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w40
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w41 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-10-13') TO ('2019-10-20');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w41
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w42 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-10-20') TO ('2019-10-27');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w42
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w43 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-10-27') TO ('2019-11-03');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w43
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w44 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-11-03') TO ('2019-11-10');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w44
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w45 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-11-10') TO ('2019-11-17');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w45
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w46 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-11-17') TO ('2019-11-24');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w46
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w47 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-11-24') TO ('2019-12-01');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w47
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w48 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-12-01') TO ('2019-12-08');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w48
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w49 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-12-08') TO ('2019-12-15');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w49
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w50 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-12-15') TO ('2019-12-22');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w50
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w51 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-12-22') TO ('2019-12-29');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w51
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2019w52 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2019-12-29') TO ('2020-01-05');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2019w52
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w01 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-01-05') TO ('2020-01-12');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w01
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w02 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-01-12') TO ('2020-01-19');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w02
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w03 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-01-19') TO ('2020-01-26');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w03
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w04 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-01-26') TO ('2020-02-02');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w04
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w05 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-02-02') TO ('2020-02-09');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w05
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w06 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-02-09') TO ('2020-02-16');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w06
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w07 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-02-16') TO ('2020-02-23');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w07
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w08 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-02-23') TO ('2020-03-01');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w08
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w09 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-03-01') TO ('2020-03-08');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w09
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w10 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-03-08') TO ('2020-03-15');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w10
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w11 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-03-15') TO ('2020-03-22');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w11
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w12 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-03-22') TO ('2020-03-29');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w12
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w13 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-03-29') TO ('2020-04-05');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w13
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w14 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-04-05') TO ('2020-04-12');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w14
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w15 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-04-12') TO ('2020-04-19');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w15
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w16 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-04-19') TO ('2020-04-26');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w16
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w17 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-04-26') TO ('2020-05-03');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w17
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w18 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-05-03') TO ('2020-05-10');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w18
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w19 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-05-10') TO ('2020-05-17');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w19
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w20 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-05-17') TO ('2020-05-24');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w20
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w21 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-05-24') TO ('2020-05-31');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w21
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w22 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-05-31') TO ('2020-06-07');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w22
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w23 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-06-07') TO ('2020-06-14');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w23
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w24 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-06-14') TO ('2020-06-21');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w24
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w25 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-06-21') TO ('2020-06-28');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w25
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w26 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-06-28') TO ('2020-07-05');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w26
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w27 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-07-05') TO ('2020-07-12');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w27
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w28 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-07-12') TO ('2020-07-19');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w28
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w29 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-07-19') TO ('2020-07-26');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w29
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w30 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-07-26') TO ('2020-08-02');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w30
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w31 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-08-02') TO ('2020-08-09');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w31
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w32 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-08-09') TO ('2020-08-16');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w32
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w33 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-08-16') TO ('2020-08-23');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w33
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w34 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-08-23') TO ('2020-08-30');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w34
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w35 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-08-30') TO ('2020-09-06');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w35
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w36 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-09-06') TO ('2020-09-13');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w36
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w37 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-09-13') TO ('2020-09-20');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w37
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w38 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-09-20') TO ('2020-09-27');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w38
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w39 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-09-27') TO ('2020-10-04');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w39
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w40 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-10-04') TO ('2020-10-11');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w40
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w41 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-10-11') TO ('2020-10-18');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w41
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w42 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-10-18') TO ('2020-10-25');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w42
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w43 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-10-25') TO ('2020-11-01');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w43
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w44 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-11-01') TO ('2020-11-08');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w44
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w45 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-11-08') TO ('2020-11-15');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w45
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w46 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-11-15') TO ('2020-11-22');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w46
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w47 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-11-22') TO ('2020-11-29');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w47
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w48 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-11-29') TO ('2020-12-06');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w48
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w49 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-12-06') TO ('2020-12-13');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w49
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w50 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-12-13') TO ('2020-12-20');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w50
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w51 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-12-20') TO ('2020-12-27');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w51
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2020w52 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2020-12-27') TO ('2021-01-03');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2020w52
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w01 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-01-03') TO ('2021-01-10');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w01
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w02 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-01-10') TO ('2021-01-17');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w02
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w03 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-01-17') TO ('2021-01-24');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w03
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w04 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-01-24') TO ('2021-01-31');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w04
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w05 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-01-31') TO ('2021-02-07');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w05
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w06 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-02-07') TO ('2021-02-14');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w06
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w07 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-02-14') TO ('2021-02-21');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w07
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w08 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-02-21') TO ('2021-02-28');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w08
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w09 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-02-28') TO ('2021-03-07');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w09
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w10 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-03-07') TO ('2021-03-14');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w10
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w11 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-03-14') TO ('2021-03-21');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w11
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w12 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-03-21') TO ('2021-03-28');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w12
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w13 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-03-28') TO ('2021-04-04');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w13
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w14 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-04-04') TO ('2021-04-11');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w14
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w15 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-04-11') TO ('2021-04-18');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w15
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w16 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-04-18') TO ('2021-04-25');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w16
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w17 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-04-25') TO ('2021-05-02');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w17
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w18 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-05-02') TO ('2021-05-09');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w18
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w19 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-05-09') TO ('2021-05-16');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w19
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w20 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-05-16') TO ('2021-05-23');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w20
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w21 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-05-23') TO ('2021-05-30');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w21
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w22 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-05-30') TO ('2021-06-06');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w22
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w23 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-06-06') TO ('2021-06-13');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w23
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w24 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-06-13') TO ('2021-06-20');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w24
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w25 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-06-20') TO ('2021-06-27');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w25
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w26 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-06-27') TO ('2021-07-04');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w26
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w27 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-07-04') TO ('2021-07-11');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w27
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w28 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-07-11') TO ('2021-07-18');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w28
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w29 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-07-18') TO ('2021-07-25');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w29
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w30 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-07-25') TO ('2021-08-01');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w30
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w31 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-08-01') TO ('2021-08-08');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w31
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w32 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-08-08') TO ('2021-08-15');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w32
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w33 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-08-15') TO ('2021-08-22');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w33
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w34 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-08-22') TO ('2021-08-29');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w34
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w35 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-08-29') TO ('2021-09-05');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w35
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w36 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-09-05') TO ('2021-09-12');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w36
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w37 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-09-12') TO ('2021-09-19');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w37
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w38 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-09-19') TO ('2021-09-26');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w38
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w39 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-09-26') TO ('2021-10-03');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w39
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w40 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-10-03') TO ('2021-10-10');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w40
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w41 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-10-10') TO ('2021-10-17');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w41
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w42 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-10-17') TO ('2021-10-24');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w42
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w43 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-10-24') TO ('2021-10-31');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w43
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w44 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-10-31') TO ('2021-11-07');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w44
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w45 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-11-07') TO ('2021-11-14');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w45
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w46 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-11-14') TO ('2021-11-21');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w46
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w47 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-11-21') TO ('2021-11-28');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w47
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w48 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-11-28') TO ('2021-12-05');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w48
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w49 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-12-05') TO ('2021-12-12');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w49
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w50 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-12-12') TO ('2021-12-19');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w50
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w51 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-12-19') TO ('2021-12-26');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w51
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.hour_unit_data_dm_em_uh_2021w52 PARTITION OF camddmw.hour_unit_data
    FOR VALUES FROM ('2021-12-26') TO ('2022-01-02');

--ALTER TABLE camddmw.hour_unit_data_dm_em_uh_2021w52
--    OWNER to "uImcwuf4K9dyaxeL";