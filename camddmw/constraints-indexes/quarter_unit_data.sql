-- Table: camddmw.quarter_unit_data

-- DROP TABLE camddmw.quarter_unit_data;

CREATE TABLE IF NOT EXISTS camddmw.quarter_unit_data
(
    unit_id numeric(12,0) NOT NULL,
    op_year numeric(4,0) NOT NULL,
    op_quarter numeric(1,0) NOT NULL,
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
    num_months_reported double precision,
    rpt_period_id numeric(38,0),
    data_source character varying(35) COLLATE pg_catalog."default",
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    CONSTRAINT quarter_unit_data_pk PRIMARY KEY (unit_id, op_year, op_quarter)
) PARTITION BY RANGE (op_year, op_quarter);


COMMENT ON TABLE camddmw.quarter_unit_data
    IS 'Quarterly emissions data at the unit level';

COMMENT ON COLUMN camddmw.quarter_unit_data.unit_id
    IS 'Unique identifier of a unit';

COMMENT ON COLUMN camddmw.quarter_unit_data.op_year
    IS 'Year in which data was collected';

COMMENT ON COLUMN camddmw.quarter_unit_data.op_quarter
    IS 'Quarter in which data was collected';

COMMENT ON COLUMN camddmw.quarter_unit_data.count_op_time
    IS 'Number of hours (>0) during which the unit operated for this time interval';

COMMENT ON COLUMN camddmw.quarter_unit_data.sum_op_time
    IS 'Sum of hours of operation for this time interval';

COMMENT ON COLUMN camddmw.quarter_unit_data.gload
    IS 'Sum of output in megawatts';

COMMENT ON COLUMN camddmw.quarter_unit_data.sload
    IS 'Output measured in lbs of steam';

COMMENT ON COLUMN camddmw.quarter_unit_data.tload
    IS 'Steam output measured in mmBtu/hr';

COMMENT ON COLUMN camddmw.quarter_unit_data.heat_input
    IS 'Amount of heat (mmBtu) produced by burning fuel for the unit';

COMMENT ON COLUMN camddmw.quarter_unit_data.so2_mass
    IS 'Mass of SO2 (tons) emitted by a unit';

COMMENT ON COLUMN camddmw.quarter_unit_data.so2_mass_lbs
    IS 'Mass of SO2 (lbs) emitted by a unit';

COMMENT ON COLUMN camddmw.quarter_unit_data.so2_rate
    IS 'Average SO2 hourly emissions rate (lbs/mmBtu) for a unit';

COMMENT ON COLUMN camddmw.quarter_unit_data.so2_rate_sum
    IS 'Sum of SO2 hourly emissions rate (lbs/mmBtu) for a unit';

COMMENT ON COLUMN camddmw.quarter_unit_data.so2_rate_count
    IS 'Count of SO2 hourly emissions rate for a unit';

COMMENT ON COLUMN camddmw.quarter_unit_data.co2_mass
    IS 'Mass of CO2 (tons) emitted by a unit';

COMMENT ON COLUMN camddmw.quarter_unit_data.co2_rate
    IS 'Average CO2 hourly emissions rate (tons/mmBtu) for a unit';

COMMENT ON COLUMN camddmw.quarter_unit_data.co2_rate_sum
    IS 'Sum of CO2 hourly emissions rate (lbs/mmBtu) for a unit';

COMMENT ON COLUMN camddmw.quarter_unit_data.co2_rate_count
    IS 'Count of CO2 hourly emissions rate for a unit';

COMMENT ON COLUMN camddmw.quarter_unit_data.nox_mass
    IS 'Mass of NOx (tons) emitted by a unit';

COMMENT ON COLUMN camddmw.quarter_unit_data.nox_mass_lbs
    IS 'Mass of NOx (lbs) emitted by a unit';

COMMENT ON COLUMN camddmw.quarter_unit_data.nox_rate
    IS 'Average NOx hourly emissions rate (lbs/mmBtu) for a unit';

COMMENT ON COLUMN camddmw.quarter_unit_data.nox_rate_sum
    IS 'Sum of NOx hourly emissions rate (lbs/mmBtu) for a unit';

COMMENT ON COLUMN camddmw.quarter_unit_data.nox_rate_count
    IS 'Count of NOx hourly emissions rate for a unit';

COMMENT ON COLUMN camddmw.quarter_unit_data.num_months_reported
    IS 'Count of months in the quarter for which the unit has reported emissions';

COMMENT ON COLUMN camddmw.quarter_unit_data.rpt_period_id
    IS 'Reporting Period table id for the data';

COMMENT ON COLUMN camddmw.quarter_unit_data.data_source
    IS 'Source of the data';

COMMENT ON COLUMN camddmw.quarter_unit_data.userid
    IS 'Initials of user who last modified data';

COMMENT ON COLUMN camddmw.quarter_unit_data.add_date
    IS 'Date on which the record was added';

-- Index: idx_quarter_unit_data_rpt_period_id

-- DROP INDEX camddmw.idx_quarter_unit_data_rpt_period_id;

CREATE INDEX IF NOT EXISTS idx_quarter_unit_data_rpt_period_id
    ON camddmw.quarter_unit_data USING btree
    (rpt_period_id ASC NULLS LAST);

-- Partitions SQL

CREATE TABLE IF NOT EXISTS camddmw.quarter_unit_data_dm_em_uq_2017q1 PARTITION OF camddmw.quarter_unit_data
    FOR VALUES FROM (MINVALUE, MINVALUE) TO ('2017', '2');

--ALTER TABLE camddmw.quarter_unit_data_dm_em_uq_2017q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.quarter_unit_data_dm_em_uq_2017q2 PARTITION OF camddmw.quarter_unit_data
    FOR VALUES FROM ('2017', '2') TO ('2017', '3');

--ALTER TABLE camddmw.quarter_unit_data_dm_em_uq_2017q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.quarter_unit_data_dm_em_uq_2017q3 PARTITION OF camddmw.quarter_unit_data
    FOR VALUES FROM ('2017', '3') TO ('2017', '4');

--ALTER TABLE camddmw.quarter_unit_data_dm_em_uq_2017q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.quarter_unit_data_dm_em_uq_2017q4 PARTITION OF camddmw.quarter_unit_data
    FOR VALUES FROM ('2017', '4') TO ('2017', '5');

--ALTER TABLE camddmw.quarter_unit_data_dm_em_uq_2017q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.quarter_unit_data_dm_em_uq_2018q1 PARTITION OF camddmw.quarter_unit_data
    FOR VALUES FROM ('2017', '5') TO ('2018', '2');

--ALTER TABLE camddmw.quarter_unit_data_dm_em_uq_2018q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.quarter_unit_data_dm_em_uq_2018q2 PARTITION OF camddmw.quarter_unit_data
    FOR VALUES FROM ('2018', '2') TO ('2018', '3');

--ALTER TABLE camddmw.quarter_unit_data_dm_em_uq_2018q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.quarter_unit_data_dm_em_uq_2018q3 PARTITION OF camddmw.quarter_unit_data
    FOR VALUES FROM ('2018', '3') TO ('2018', '4');

--ALTER TABLE camddmw.quarter_unit_data_dm_em_uq_2018q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.quarter_unit_data_dm_em_uq_2018q4 PARTITION OF camddmw.quarter_unit_data
    FOR VALUES FROM ('2018', '4') TO ('2018', '5');

--ALTER TABLE camddmw.quarter_unit_data_dm_em_uq_2018q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.quarter_unit_data_dm_em_uq_2019q1 PARTITION OF camddmw.quarter_unit_data
    FOR VALUES FROM ('2018', '5') TO ('2019', '2');

--ALTER TABLE camddmw.quarter_unit_data_dm_em_uq_2019q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.quarter_unit_data_dm_em_uq_2019q2 PARTITION OF camddmw.quarter_unit_data
    FOR VALUES FROM ('2019', '2') TO ('2019', '3');

--ALTER TABLE camddmw.quarter_unit_data_dm_em_uq_2019q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.quarter_unit_data_dm_em_uq_2019q3 PARTITION OF camddmw.quarter_unit_data
    FOR VALUES FROM ('2019', '3') TO ('2019', '4');

--ALTER TABLE camddmw.quarter_unit_data_dm_em_uq_2019q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.quarter_unit_data_dm_em_uq_2019q4 PARTITION OF camddmw.quarter_unit_data
    FOR VALUES FROM ('2019', '4') TO ('2019', '5');

--ALTER TABLE camddmw.quarter_unit_data_dm_em_uq_2019q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.quarter_unit_data_dm_em_uq_2020q1 PARTITION OF camddmw.quarter_unit_data
    FOR VALUES FROM ('2019', '5') TO ('2020', '2');

--ALTER TABLE camddmw.quarter_unit_data_dm_em_uq_2020q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.quarter_unit_data_dm_em_uq_2020q2 PARTITION OF camddmw.quarter_unit_data
    FOR VALUES FROM ('2020', '2') TO ('2020', '3');

--ALTER TABLE camddmw.quarter_unit_data_dm_em_uq_2020q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.quarter_unit_data_dm_em_uq_2020q3 PARTITION OF camddmw.quarter_unit_data
    FOR VALUES FROM ('2020', '3') TO ('2020', '4');

--ALTER TABLE camddmw.quarter_unit_data_dm_em_uq_2020q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.quarter_unit_data_dm_em_uq_2020q4 PARTITION OF camddmw.quarter_unit_data
    FOR VALUES FROM ('2020', '4') TO ('2020', '5');

--ALTER TABLE camddmw.quarter_unit_data_dm_em_uq_2020q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.quarter_unit_data_dm_em_uq_2021q1 PARTITION OF camddmw.quarter_unit_data
    FOR VALUES FROM ('2020', '5') TO ('2021', '2');

--ALTER TABLE camddmw.quarter_unit_data_dm_em_uq_2021q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.quarter_unit_data_dm_em_uq_2021q2 PARTITION OF camddmw.quarter_unit_data
    FOR VALUES FROM ('2021', '2') TO ('2021', '3');

--ALTER TABLE camddmw.quarter_unit_data_dm_em_uq_2021q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.quarter_unit_data_dm_em_uq_2021q3 PARTITION OF camddmw.quarter_unit_data
    FOR VALUES FROM ('2021', '3') TO ('2021', '4');

--ALTER TABLE camddmw.quarter_unit_data_dm_em_uq_2021q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.quarter_unit_data_dm_em_uq_2021q4 PARTITION OF camddmw.quarter_unit_data
    FOR VALUES FROM ('2021', '4') TO ('2021', '5');

--ALTER TABLE camddmw.quarter_unit_data_dm_em_uq_2021q4
--    OWNER to "uImcwuf4K9dyaxeL";