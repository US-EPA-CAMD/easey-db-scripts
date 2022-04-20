-- Table: camddmw.month_unit_data

-- DROP TABLE camddmw.month_unit_data;

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data
(
    unit_id numeric(12,0) NOT NULL,
    op_year numeric(4,0) NOT NULL,
    op_month numeric(2,0) NOT NULL,
    month_description character varying(35) COLLATE pg_catalog."default",
    count_op_time numeric(10,0),
    sum_op_time numeric(10,2),
    gload numeric(12,2),
    sload numeric(12,2),
    tload numeric(12,2),
    heat_input numeric(15,3),
    so2_mass numeric(12,3),
    so2_mass_lbs numeric(15,3),
    so2_rate numeric(16,4),
    so2_rate_sum numeric(15,3),
    so2_rate_count numeric(4,0),
    co2_mass numeric(12,3),
    co2_rate numeric(16,4),
    co2_rate_sum numeric(15,3),
    co2_rate_count numeric(4,0),
    nox_mass numeric(12,3),
    nox_mass_lbs numeric(15,3),
    nox_rate numeric(16,4),
    nox_rate_sum numeric(15,3),
    nox_rate_count numeric(4,0),
    rpt_period_id numeric(38,0),
    op_quarter numeric(1,0),
    data_source character varying(35) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    CONSTRAINT pk_month_unit_data PRIMARY KEY (unit_id, op_year, op_month)
) PARTITION BY RANGE (op_year, op_month);


COMMENT ON TABLE camddmw.month_unit_data
    IS 'Monthly emissions data at the unit level';

COMMENT ON COLUMN camddmw.month_unit_data.unit_id
    IS 'Unique identifier of a unit';

COMMENT ON COLUMN camddmw.month_unit_data.op_year
    IS 'Year in which data was collected';

COMMENT ON COLUMN camddmw.month_unit_data.op_month
    IS 'Month in which data was collected';

COMMENT ON COLUMN camddmw.month_unit_data.month_description
    IS 'Month name';

COMMENT ON COLUMN camddmw.month_unit_data.count_op_time
    IS 'Number of hours (>0) during which the unit operated for this time interval';

COMMENT ON COLUMN camddmw.month_unit_data.sum_op_time
    IS 'Sum of hours of operation for this time interval';

COMMENT ON COLUMN camddmw.month_unit_data.gload
    IS 'Sum of output in megawatts';

COMMENT ON COLUMN camddmw.month_unit_data.sload
    IS 'Output measured in lbs of steam';

COMMENT ON COLUMN camddmw.month_unit_data.tload
    IS 'Steam output measured in mmBtu/hr';

COMMENT ON COLUMN camddmw.month_unit_data.heat_input
    IS 'Amount of heat (mmBtu) produced by burning fuel for the unit';

COMMENT ON COLUMN camddmw.month_unit_data.so2_mass
    IS 'Mass of SO2 (tons) emitted by a unit';

COMMENT ON COLUMN camddmw.month_unit_data.so2_mass_lbs
    IS 'Mass of SO2 (lbs) emitted by a unit';

COMMENT ON COLUMN camddmw.month_unit_data.so2_rate
    IS 'Average SO2 hourly emissions rate (lbs/mmBtu) for a unit';

COMMENT ON COLUMN camddmw.month_unit_data.so2_rate_sum
    IS 'Sum of SO2 hourly emissions rate (lbs/mmBtu) for a unit';

COMMENT ON COLUMN camddmw.month_unit_data.so2_rate_count
    IS 'Count of SO2 hourly emissions rate for a unit';

COMMENT ON COLUMN camddmw.month_unit_data.co2_mass
    IS 'Mass of CO2 (tons) emitted by a unit';

COMMENT ON COLUMN camddmw.month_unit_data.co2_rate
    IS 'Average CO2 hourly emissions rate (tons/mmBtu) for a unit';

COMMENT ON COLUMN camddmw.month_unit_data.co2_rate_sum
    IS 'Sum of CO2 hourly emissions rate (lbs/mmBtu) for a unit';

COMMENT ON COLUMN camddmw.month_unit_data.co2_rate_count
    IS 'Count of CO2 hourly emissions rate for a unit';

COMMENT ON COLUMN camddmw.month_unit_data.nox_mass
    IS 'Mass of NOx (tons) emitted by a unit';

COMMENT ON COLUMN camddmw.month_unit_data.nox_mass_lbs
    IS 'Mass of NOx (lbs) emitted by a unit';

COMMENT ON COLUMN camddmw.month_unit_data.nox_rate
    IS 'Average NOx hourly emissions rate (lbs/mmBtu) for a unit';

COMMENT ON COLUMN camddmw.month_unit_data.nox_rate_sum
    IS 'Sum of NOx hourly emissions rate (lbs/mmBtu) for a unit';

COMMENT ON COLUMN camddmw.month_unit_data.nox_rate_count
    IS 'Count of NOx hourly emissions rate for a unit';

COMMENT ON COLUMN camddmw.month_unit_data.rpt_period_id
    IS 'Reporting Period table id for the data';

COMMENT ON COLUMN camddmw.month_unit_data.op_quarter
    IS 'Quarter in which data was collected';

COMMENT ON COLUMN camddmw.month_unit_data.data_source
    IS 'Source of the data';

COMMENT ON COLUMN camddmw.month_unit_data.userid
    IS 'Initials of user who last modified data';

COMMENT ON COLUMN camddmw.month_unit_data.add_date
    IS 'Date on which the record was added';

-- Index: idx_month_unit_data_op_quarter

-- DROP INDEX camddmw.idx_month_unit_data_op_quarter;

CREATE INDEX idx_month_unit_data_op_quarter
    ON camddmw.month_unit_data USING btree
    (op_quarter ASC NULLS LAST);

-- Index: idx_month_unit_data_rpt_period_id

-- DROP INDEX camddmw.idx_month_unit_data_rpt_period_id;

CREATE INDEX idx_month_unit_data_rpt_period_id
    ON camddmw.month_unit_data USING btree
    (rpt_period_id ASC NULLS LAST);

-- Partitions SQL

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2017m01 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM (MINVALUE, MINVALUE) TO ('2017', '2');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2017m01
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2017m02 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2017', '2') TO ('2017', '3');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2017m02
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2017m03 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2017', '3') TO ('2017', '4');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2017m03
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2017m04 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2017', '4') TO ('2017', '5');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2017m04
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2017m05 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2017', '5') TO ('2017', '6');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2017m05
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2017m06 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2017', '6') TO ('2017', '7');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2017m06
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2017m07 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2017', '7') TO ('2017', '8');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2017m07
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2017m08 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2017', '8') TO ('2017', '9');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2017m08
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2017m09 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2017', '9') TO ('2017', '10');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2017m09
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2017m10 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2017', '10') TO ('2017', '11');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2017m10
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2017m11 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2017', '11') TO ('2017', '12');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2017m11
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2017m12 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2017', '12') TO ('2017', '13');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2017m12
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2018m01 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2017', '13') TO ('2018', '2');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2018m01
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2018m02 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2018', '2') TO ('2018', '3');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2018m02
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2018m03 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2018', '3') TO ('2018', '4');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2018m03
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2018m04 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2018', '4') TO ('2018', '5');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2018m04
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2018m05 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2018', '5') TO ('2018', '6');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2018m05
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2018m06 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2018', '6') TO ('2018', '7');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2018m06
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2018m07 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2018', '7') TO ('2018', '8');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2018m07
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2018m08 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2018', '8') TO ('2018', '9');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2018m08
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2018m09 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2018', '9') TO ('2018', '10');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2018m09
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2018m10 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2018', '10') TO ('2018', '11');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2018m10
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2018m11 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2018', '11') TO ('2018', '12');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2018m11
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2018m12 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2018', '12') TO ('2018', '13');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2018m12
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2019m01 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2018', '13') TO ('2019', '2');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2019m01
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2019m02 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2019', '2') TO ('2019', '3');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2019m02
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2019m03 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2019', '3') TO ('2019', '4');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2019m03
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2019m04 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2019', '4') TO ('2019', '5');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2019m04
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2019m05 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2019', '5') TO ('2019', '6');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2019m05
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2019m06 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2019', '6') TO ('2019', '7');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2019m06
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2019m07 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2019', '7') TO ('2019', '8');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2019m07
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2019m08 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2019', '8') TO ('2019', '9');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2019m08
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2019m09 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2019', '9') TO ('2019', '10');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2019m09
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2019m10 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2019', '10') TO ('2019', '11');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2019m10
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2019m11 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2019', '11') TO ('2019', '12');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2019m11
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2019m12 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2019', '12') TO ('2019', '13');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2019m12
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2020m01 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2019', '13') TO ('2020', '2');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2020m01
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2020m02 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2020', '2') TO ('2020', '3');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2020m02
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2020m03 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2020', '3') TO ('2020', '4');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2020m03
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2020m04 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2020', '4') TO ('2020', '5');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2020m04
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2020m05 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2020', '5') TO ('2020', '6');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2020m05
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2020m06 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2020', '6') TO ('2020', '7');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2020m06
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2020m07 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2020', '7') TO ('2020', '8');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2020m07
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2020m08 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2020', '8') TO ('2020', '9');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2020m08
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2020m09 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2020', '9') TO ('2020', '10');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2020m09
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2020m10 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2020', '10') TO ('2020', '11');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2020m10
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2020m11 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2020', '11') TO ('2020', '12');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2020m11
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2020m12 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2020', '12') TO ('2020', '13');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2020m12
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2021m01 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2020', '13') TO ('2021', '2');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2021m01
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2021m02 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2021', '2') TO ('2021', '3');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2021m02
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2021m03 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2021', '3') TO ('2021', '4');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2021m03
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2021m04 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2021', '4') TO ('2021', '5');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2021m04
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2021m05 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2021', '5') TO ('2021', '6');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2021m05
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2021m06 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2021', '6') TO ('2021', '7');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2021m06
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2021m07 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2021', '7') TO ('2021', '8');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2021m07
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2021m08 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2021', '8') TO ('2021', '9');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2021m08
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2021m09 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2021', '9') TO ('2021', '10');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2021m09
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2021m10 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2021', '10') TO ('2021', '11');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2021m10
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2021m11 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2021', '11') TO ('2021', '12');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2021m11
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.month_unit_data_dm_em_um_2021m12 PARTITION OF camddmw.month_unit_data
    FOR VALUES FROM ('2021', '12') TO ('2021', '13');

--ALTER TABLE camddmw.month_unit_data_dm_em_um_2021m12
--    OWNER to "uImcwuf4K9dyaxeL";