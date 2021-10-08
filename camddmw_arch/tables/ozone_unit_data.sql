CREATE TABLE camddmw_arch.ozone_unit_data_a
(
    unit_id numeric(12,0) NOT NULL,
    op_year numeric(4,0) NOT NULL,
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
    num_months_reported double precision,
    data_source character varying(35) COLLATE pg_catalog."default",
    userid character varying(8) COLLATE pg_catalog."default",
    add_date date,
    CONSTRAINT ozone_unit_data_a_pk PRIMARY KEY (op_year, unit_id)
) PARTITION BY RANGE (op_year);

--ALTER TABLE camddmw_arch.ozone_unit_data_a
--    OWNER to "uImcwuf4K9dyaxeL";

COMMENT ON TABLE camddmw_arch.ozone_unit_data_a
    IS 'Ozone season emissions data at the unit level';

COMMENT ON COLUMN camddmw_arch.ozone_unit_data_a.unit_id
    IS 'Unique identifier of a unit';

COMMENT ON COLUMN camddmw_arch.ozone_unit_data_a.op_year
    IS 'Year in which data was collected';

COMMENT ON COLUMN camddmw_arch.ozone_unit_data_a.count_op_time
    IS 'Number of hours (>0) during which the unit operated for this time interval';

COMMENT ON COLUMN camddmw_arch.ozone_unit_data_a.sum_op_time
    IS 'Sum of hours of operation for this time interval';

COMMENT ON COLUMN camddmw_arch.ozone_unit_data_a.gload
    IS 'Sum of output in megawatts';

COMMENT ON COLUMN camddmw_arch.ozone_unit_data_a.sload
    IS 'Steam output measured in lbs/hr';

COMMENT ON COLUMN camddmw_arch.ozone_unit_data_a.tload
    IS 'Steam output measured in mmBtu/hr';

COMMENT ON COLUMN camddmw_arch.ozone_unit_data_a.heat_input
    IS 'Amount of heat (mmBtu) produced by burning fuel for the unit';

COMMENT ON COLUMN camddmw_arch.ozone_unit_data_a.so2_mass
    IS 'Mass of SO2 (tons) emitted by a unit';

COMMENT ON COLUMN camddmw_arch.ozone_unit_data_a.so2_mass_lbs
    IS 'Mass of SO2 (lbs) emitted by a unit';

COMMENT ON COLUMN camddmw_arch.ozone_unit_data_a.so2_rate
    IS 'Average SO2 hourly emissions rate (lbs/mmBtu) for a unit';

COMMENT ON COLUMN camddmw_arch.ozone_unit_data_a.so2_rate_sum
    IS 'Sum of SO2 hourly emissions rate (lbs/mmBtu) for a unit';

COMMENT ON COLUMN camddmw_arch.ozone_unit_data_a.so2_rate_count
    IS 'Count of SO2 hourly emissions rate for a unit';

COMMENT ON COLUMN camddmw_arch.ozone_unit_data_a.co2_mass
    IS 'Mass of CO2 (tons) emitted by a unit';

COMMENT ON COLUMN camddmw_arch.ozone_unit_data_a.co2_rate
    IS 'Average CO2 hourly emissions rate (tons/mmBtu) for a unit';

COMMENT ON COLUMN camddmw_arch.ozone_unit_data_a.co2_rate_sum
    IS 'Sum of CO2 hourly emissions rate (lbs/mmBtu) for a unit';

COMMENT ON COLUMN camddmw_arch.ozone_unit_data_a.co2_rate_count
    IS 'Count of CO2 hourly emissions rate for a unit';

COMMENT ON COLUMN camddmw_arch.ozone_unit_data_a.nox_mass
    IS 'Mass of NOx (tons) emitted by a unit';

COMMENT ON COLUMN camddmw_arch.ozone_unit_data_a.nox_mass_lbs
    IS 'Mass of NOx (lbs) emitted by a unit';

COMMENT ON COLUMN camddmw_arch.ozone_unit_data_a.nox_rate
    IS 'Average NOx hourly emissions rate (lbs/mmBtu) for a unit';

COMMENT ON COLUMN camddmw_arch.ozone_unit_data_a.nox_rate_sum
    IS 'Sum of NOx hourly emissions rate (lbs/mmBtu) for a unit';

COMMENT ON COLUMN camddmw_arch.ozone_unit_data_a.nox_rate_count
    IS 'Count of NOx hourly emissions rate for a unit';

COMMENT ON COLUMN camddmw_arch.ozone_unit_data_a.num_months_reported
    IS 'Count of months in the ozone season for which the unit has reported emissions';

COMMENT ON COLUMN camddmw_arch.ozone_unit_data_a.data_source
    IS 'Source of the data';

COMMENT ON COLUMN camddmw_arch.ozone_unit_data_a.userid
    IS 'Initials of user who last modified data';

COMMENT ON COLUMN camddmw_arch.ozone_unit_data_a.add_date
    IS 'Date on which the record was added';

-- Partitions SQL

CREATE TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_1995 PARTITION OF camddmw_arch.ozone_unit_data_a
    FOR VALUES FROM ('1995') TO ('1996');

--ALTER TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_1995
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_1996 PARTITION OF camddmw_arch.ozone_unit_data_a
    FOR VALUES FROM ('1996') TO ('1997');

--ALTER TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_1996
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_1997 PARTITION OF camddmw_arch.ozone_unit_data_a
    FOR VALUES FROM ('1997') TO ('1998');

--ALTER TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_1997
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_1998 PARTITION OF camddmw_arch.ozone_unit_data_a
    FOR VALUES FROM ('1998') TO ('1999');

--ALTER TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_1998
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_1999 PARTITION OF camddmw_arch.ozone_unit_data_a
    FOR VALUES FROM ('1999') TO ('2000');

--ALTER TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_1999
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_2000 PARTITION OF camddmw_arch.ozone_unit_data_a
    FOR VALUES FROM ('2000') TO ('2001');

--ALTER TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_2000
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_2001 PARTITION OF camddmw_arch.ozone_unit_data_a
    FOR VALUES FROM ('2001') TO ('2002');

--ALTER TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_2001
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_2002 PARTITION OF camddmw_arch.ozone_unit_data_a
    FOR VALUES FROM ('2002') TO ('2003');

--ALTER TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_2002
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_2003 PARTITION OF camddmw_arch.ozone_unit_data_a
    FOR VALUES FROM ('2003') TO ('2004');

--ALTER TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_2003
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_2004 PARTITION OF camddmw_arch.ozone_unit_data_a
    FOR VALUES FROM ('2004') TO ('2005');

--ALTER TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_2004
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_2005 PARTITION OF camddmw_arch.ozone_unit_data_a
    FOR VALUES FROM ('2005') TO ('2006');

--ALTER TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_2005
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_2006 PARTITION OF camddmw_arch.ozone_unit_data_a
    FOR VALUES FROM ('2006') TO ('2007');

--ALTER TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_2006
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_2007 PARTITION OF camddmw_arch.ozone_unit_data_a
    FOR VALUES FROM ('2007') TO ('2008');

--ALTER TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_2007
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_2008 PARTITION OF camddmw_arch.ozone_unit_data_a
    FOR VALUES FROM ('2008') TO ('2009');

--ALTER TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_2008
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_2009 PARTITION OF camddmw_arch.ozone_unit_data_a
    FOR VALUES FROM ('2009') TO ('2010');

--ALTER TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_2009
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_2010 PARTITION OF camddmw_arch.ozone_unit_data_a
    FOR VALUES FROM ('2010') TO ('2011');

--ALTER TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_2010
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_2011 PARTITION OF camddmw_arch.ozone_unit_data_a
    FOR VALUES FROM ('2011') TO ('2012');

--ALTER TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_2011
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_2012 PARTITION OF camddmw_arch.ozone_unit_data_a
    FOR VALUES FROM ('2012') TO ('2013');

--ALTER TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_2012
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_2013 PARTITION OF camddmw_arch.ozone_unit_data_a
    FOR VALUES FROM ('2013') TO ('2014');

--ALTER TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_2013
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_2014 PARTITION OF camddmw_arch.ozone_unit_data_a
    FOR VALUES FROM ('2014') TO ('2015');

--ALTER TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_2014
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_2015 PARTITION OF camddmw_arch.ozone_unit_data_a
    FOR VALUES FROM ('2015') TO ('2016');

--ALTER TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_2015
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_2016 PARTITION OF camddmw_arch.ozone_unit_data_a
    FOR VALUES FROM ('2016') TO ('2017');

--ALTER TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_2016
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_before PARTITION OF camddmw_arch.ozone_unit_data_a
    FOR VALUES FROM (MINVALUE) TO ('1995');

--ALTER TABLE camddmw_arch.ozone_unit_data_a_dm_em_uo_before
--    OWNER to "uImcwuf4K9dyaxeL";