-- Table: camddmw_arch.month_unit_data_a

-- DROP TABLE camddmw_arch.month_unit_data_a;

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a
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
    so2_rate numeric(15,4),
    so2_rate_sum numeric(15,3),
    so2_rate_count numeric(4,0),
    co2_mass numeric(12,3),
    co2_rate numeric(15,4),
    co2_rate_sum numeric(15,3),
    co2_rate_count numeric(4,0),
    nox_mass numeric(12,3),
    nox_mass_lbs numeric(15,3),
    nox_rate numeric(15,4),
    nox_rate_sum numeric(15,3),
    nox_rate_count numeric(4,0),
    rpt_period_id numeric(38,0),
    op_quarter numeric(1,0),
    data_source character varying(35) COLLATE pg_catalog."default",
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    CONSTRAINT pk_month_unit_data PRIMARY KEY (unit_id, op_year, op_month)
) PARTITION BY RANGE (op_year, op_month);


COMMENT ON TABLE camddmw_arch.month_unit_data_a
    IS 'Monthly emissions data at the unit level';

COMMENT ON COLUMN camddmw_arch.month_unit_data_a.unit_id
    IS 'Unique identifier of a unit';

COMMENT ON COLUMN camddmw_arch.month_unit_data_a.op_year
    IS 'Year in which data was collected';

COMMENT ON COLUMN camddmw_arch.month_unit_data_a.op_month
    IS 'Month in which data was collected';

COMMENT ON COLUMN camddmw_arch.month_unit_data_a.month_description
    IS 'Month name';

COMMENT ON COLUMN camddmw_arch.month_unit_data_a.count_op_time
    IS 'Number of hours (>0) during which the unit operated for this time interval';

COMMENT ON COLUMN camddmw_arch.month_unit_data_a.sum_op_time
    IS 'Sum of hours of operation for this time interval';

COMMENT ON COLUMN camddmw_arch.month_unit_data_a.gload
    IS 'Sum of output in megawatts';

COMMENT ON COLUMN camddmw_arch.month_unit_data_a.sload
    IS 'Steam output measured in lbs/hr';

COMMENT ON COLUMN camddmw_arch.month_unit_data_a.tload
    IS 'Steam output measured in mmBtu/hr';

COMMENT ON COLUMN camddmw_arch.month_unit_data_a.heat_input
    IS 'Amount of heat (mmBtu) produced by burning fuel for the unit';

COMMENT ON COLUMN camddmw_arch.month_unit_data_a.so2_mass
    IS 'Mass of SO2 (tons) emitted by a unit';

COMMENT ON COLUMN camddmw_arch.month_unit_data_a.so2_mass_lbs
    IS 'Mass of SO2 (lbs) emitted by a unit';

COMMENT ON COLUMN camddmw_arch.month_unit_data_a.so2_rate
    IS 'Average SO2 hourly emissions rate (lbs/mmBtu) for a unit';

COMMENT ON COLUMN camddmw_arch.month_unit_data_a.so2_rate_sum
    IS 'Sum of SO2 hourly emissions rate (lbs/mmBtu) for a unit';

COMMENT ON COLUMN camddmw_arch.month_unit_data_a.so2_rate_count
    IS 'Count of SO2 hourly emissions rate for a unit';

COMMENT ON COLUMN camddmw_arch.month_unit_data_a.co2_mass
    IS 'Mass of CO2 (tons) emitted by a unit';

COMMENT ON COLUMN camddmw_arch.month_unit_data_a.co2_rate
    IS 'Average CO2 hourly emissions rate (tons/mmBtu) for a unit';

COMMENT ON COLUMN camddmw_arch.month_unit_data_a.co2_rate_sum
    IS 'Sum of CO2 hourly emissions rate (lbs/mmBtu) for a unit';

COMMENT ON COLUMN camddmw_arch.month_unit_data_a.co2_rate_count
    IS 'Count of CO2 hourly emissions rate for a unit';

COMMENT ON COLUMN camddmw_arch.month_unit_data_a.nox_mass
    IS 'Mass of NOx (tons) emitted by a unit';

COMMENT ON COLUMN camddmw_arch.month_unit_data_a.nox_mass_lbs
    IS 'Mass of NOx (lbs) emitted by a unit';

COMMENT ON COLUMN camddmw_arch.month_unit_data_a.nox_rate
    IS 'Average NOx hourly emissions rate (lbs/mmBtu) for a unit';

COMMENT ON COLUMN camddmw_arch.month_unit_data_a.nox_rate_sum
    IS 'Sum of NOx hourly emissions rate (lbs/mmBtu) for a unit';

COMMENT ON COLUMN camddmw_arch.month_unit_data_a.nox_rate_count
    IS 'Count of NOx hourly emissions rate for a unit';

COMMENT ON COLUMN camddmw_arch.month_unit_data_a.rpt_period_id
    IS 'Reporting Period table id for the data';

COMMENT ON COLUMN camddmw_arch.month_unit_data_a.op_quarter
    IS 'Quarter in which data was collected';

COMMENT ON COLUMN camddmw_arch.month_unit_data_a.data_source
    IS 'Source of the data';

COMMENT ON COLUMN camddmw_arch.month_unit_data_a.userid
    IS 'Initials of user who last modified data';

COMMENT ON COLUMN camddmw_arch.month_unit_data_a.add_date
    IS 'Date on which the record was added';

-- Index: idx_month_unit_data_op_quarter

-- DROP INDEX camddmw_arch.idx_month_unit_data_op_quarter;

CREATE INDEX IF NOT EXISTS idx_month_unit_data_op_quarter
    ON camddmw_arch.month_unit_data_a USING btree
    (op_quarter ASC NULLS LAST);

-- Index: idx_month_unit_data_rpt_period_id

-- DROP INDEX camddmw_arch.idx_month_unit_data_rpt_period_id;

CREATE INDEX IF NOT EXISTS idx_month_unit_data_rpt_period_id
    ON camddmw_arch.month_unit_data_a USING btree
    (rpt_period_id ASC NULLS LAST);

-- Partitions SQL

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_1995q1 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('1994', '13') TO ('1995', '4');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_1995q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_1995q2 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('1995', '4') TO ('1995', '7');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_1995q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_1995q3 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('1995', '7') TO ('1995', '10');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_1995q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_1995q4 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('1995', '10') TO ('1995', '13');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_1995q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_1996q1 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('1995', '13') TO ('1996', '4');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_1996q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_1996q2 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('1996', '4') TO ('1996', '7');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_1996q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_1996q3 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('1996', '7') TO ('1996', '10');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_1996q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_1996q4 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('1996', '10') TO ('1996', '13');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_1996q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_1997q1 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('1996', '13') TO ('1997', '4');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_1997q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_1997q2 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('1997', '4') TO ('1997', '7');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_1997q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_1997q3 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('1997', '7') TO ('1997', '10');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_1997q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_1997q4 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('1997', '10') TO ('1997', '13');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_1997q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_1998q1 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('1997', '13') TO ('1998', '4');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_1998q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_1998q2 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('1998', '4') TO ('1998', '7');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_1998q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_1998q3 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('1998', '7') TO ('1998', '10');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_1998q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_1998q4 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('1998', '10') TO ('1998', '13');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_1998q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_1999q1 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('1998', '13') TO ('1999', '4');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_1999q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_1999q2 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('1999', '4') TO ('1999', '7');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_1999q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_1999q3 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('1999', '7') TO ('1999', '10');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_1999q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_1999q4 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('1999', '10') TO ('1999', '13');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_1999q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2000q1 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('1999', '13') TO ('2000', '4');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2000q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2000q2 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2000', '4') TO ('2000', '7');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2000q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2000q3 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2000', '7') TO ('2000', '10');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2000q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2000q4 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2000', '10') TO ('2000', '13');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2000q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2001q1 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2000', '13') TO ('2001', '4');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2001q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2001q2 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2001', '4') TO ('2001', '7');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2001q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2001q3 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2001', '7') TO ('2001', '10');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2001q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2001q4 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2001', '10') TO ('2001', '13');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2001q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2002q1 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2001', '13') TO ('2002', '4');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2002q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2002q2 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2002', '4') TO ('2002', '7');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2002q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2002q3 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2002', '7') TO ('2002', '10');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2002q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2002q4 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2002', '10') TO ('2002', '13');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2002q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2003q1 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2002', '13') TO ('2003', '4');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2003q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2003q2 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2003', '4') TO ('2003', '7');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2003q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2003q3 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2003', '7') TO ('2003', '10');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2003q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2003q4 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2003', '10') TO ('2003', '13');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2003q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2004q1 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2003', '13') TO ('2004', '4');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2004q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2004q2 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2004', '4') TO ('2004', '7');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2004q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2004q3 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2004', '7') TO ('2004', '10');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2004q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2004q4 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2004', '10') TO ('2004', '13');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2004q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2005q1 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2004', '13') TO ('2005', '4');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2005q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2005q2 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2005', '4') TO ('2005', '7');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2005q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2005q3 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2005', '7') TO ('2005', '10');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2005q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2005q4 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2005', '10') TO ('2005', '13');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2005q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2006q1 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2005', '13') TO ('2006', '4');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2006q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2006q2 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2006', '4') TO ('2006', '7');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2006q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2006q3 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2006', '7') TO ('2006', '10');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2006q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2006q4 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2006', '10') TO ('2006', '13');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2006q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2007q1 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2006', '13') TO ('2007', '4');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2007q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2007q2 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2007', '4') TO ('2007', '7');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2007q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2007q3 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2007', '7') TO ('2007', '10');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2007q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2007q4 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2007', '10') TO ('2007', '13');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2007q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2008q1 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2007', '13') TO ('2008', '4');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2008q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2008q2 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2008', '4') TO ('2008', '7');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2008q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2008q3 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2008', '7') TO ('2008', '10');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2008q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2008q4 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2008', '10') TO ('2008', '13');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2008q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2009q1 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2008', '13') TO ('2009', '4');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2009q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2009q2 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2009', '4') TO ('2009', '7');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2009q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2009q3 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2009', '7') TO ('2009', '10');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2009q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2009q4 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2009', '10') TO ('2009', '13');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2009q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2010q1 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2009', '13') TO ('2010', '4');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2010q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2010q2 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2010', '4') TO ('2010', '7');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2010q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2010q3 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2010', '7') TO ('2010', '10');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2010q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2010q4 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2010', '10') TO ('2010', '13');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2010q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2011q1 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2010', '13') TO ('2011', '4');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2011q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2011q2 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2011', '4') TO ('2011', '7');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2011q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2011q3 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2011', '7') TO ('2011', '10');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2011q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2011q4 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2011', '10') TO ('2011', '13');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2011q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2012q1 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2011', '13') TO ('2012', '4');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2012q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2012q2 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2012', '4') TO ('2012', '7');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2012q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2012q3 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2012', '7') TO ('2012', '10');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2012q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2012q4 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2012', '10') TO ('2012', '13');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2012q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2013q1 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2012', '13') TO ('2013', '4');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2013q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2013q2 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2013', '4') TO ('2013', '7');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2013q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2013q3 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2013', '7') TO ('2013', '10');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2013q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2013q4 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2013', '10') TO ('2013', '13');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2013q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2014q1 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2013', '13') TO ('2014', '4');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2014q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2014q2 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2014', '4') TO ('2014', '7');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2014q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2014q3 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2014', '7') TO ('2014', '10');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2014q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2014q4 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2014', '10') TO ('2014', '13');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2014q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2015q1 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2014', '13') TO ('2015', '4');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2015q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2015q2 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2015', '4') TO ('2015', '7');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2015q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2015q3 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2015', '7') TO ('2015', '10');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2015q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2015q4 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2015', '10') TO ('2015', '13');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2015q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2016q1 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2015', '13') TO ('2016', '4');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2016q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2016q2 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2016', '4') TO ('2016', '7');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2016q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2016q3 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2016', '7') TO ('2016', '10');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2016q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_2016q4 PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM ('2016', '10') TO ('2016', '13');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_2016q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw_arch.month_unit_data_a_dm_em_um_before PARTITION OF camddmw_arch.month_unit_data_a
    FOR VALUES FROM (MINVALUE, MINVALUE) TO ('1994', '13');

--ALTER TABLE camddmw_arch.month_unit_data_a_dm_em_um_before
--    OWNER to "uImcwuf4K9dyaxeL";
