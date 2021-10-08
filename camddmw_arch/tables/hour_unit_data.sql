CREATE TABLE camddmw_arch.hour_unit_data_a
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
    userid character varying(8) COLLATE pg_catalog."default",
    add_date date,
    CONSTRAINT hour_unit_data_a_pk PRIMARY KEY (op_date, unit_id, op_hour)
) PARTITION BY RANGE (op_date);

--ALTER TABLE camddmw_arch.hour_unit_data_a
--    OWNER to "uImcwuf4K9dyaxeL";

COMMENT ON TABLE camddmw_arch.hour_unit_data_a
    IS 'Hourly emissions data at the unit level';

COMMENT ON COLUMN camddmw_arch.hour_unit_data_a.unit_id
    IS 'Unique identifier of a unit';

COMMENT ON COLUMN camddmw_arch.hour_unit_data_a.op_date
    IS 'Date on which the hourly data was collected';

COMMENT ON COLUMN camddmw_arch.hour_unit_data_a.op_hour
    IS 'Hour during which data was collected (range is 0 - 23)';

COMMENT ON COLUMN camddmw_arch.hour_unit_data_a.op_time
    IS 'Fraction of hourly time unit was operating';

COMMENT ON COLUMN camddmw_arch.hour_unit_data_a.gload
    IS 'Sum of output in megawatts';

COMMENT ON COLUMN camddmw_arch.hour_unit_data_a.sload
    IS 'Steam output measured in lbs/hr';

COMMENT ON COLUMN camddmw_arch.hour_unit_data_a.tload
    IS 'Steam output measured in mmBtu/hr';

COMMENT ON COLUMN camddmw_arch.hour_unit_data_a.heat_input
    IS 'Amount of heat (mmBtu) produced by burning fuel for the unit';

COMMENT ON COLUMN camddmw_arch.hour_unit_data_a.heat_input_measure_flg
    IS 'Indicates whether the value for this parameter was measured or derived due to missing data';

COMMENT ON COLUMN camddmw_arch.hour_unit_data_a.so2_mass
    IS 'Mass of SO2 (tons) emitted by a unit';

COMMENT ON COLUMN camddmw_arch.hour_unit_data_a.so2_mass_measure_flg
    IS 'Indicates whether the value for this parameter was measured or derived due to missing data';

COMMENT ON COLUMN camddmw_arch.hour_unit_data_a.so2_rate
    IS 'Average SO2 hourly emissions rate (lbs/mmBtu) for a unit';

COMMENT ON COLUMN camddmw_arch.hour_unit_data_a.so2_rate_measure_flg
    IS 'Indicates whether the value for this parameter was measured or derived due to missing data';

COMMENT ON COLUMN camddmw_arch.hour_unit_data_a.co2_mass
    IS 'Mass of CO2 (tons) emitted by a unit';

COMMENT ON COLUMN camddmw_arch.hour_unit_data_a.co2_mass_measure_flg
    IS 'Indicates whether the value for this parameter was measured or derived due to missing data';

COMMENT ON COLUMN camddmw_arch.hour_unit_data_a.co2_rate
    IS 'Average CO2 hourly emissions rate (tons/mmBtu) for a unit';

COMMENT ON COLUMN camddmw_arch.hour_unit_data_a.co2_rate_measure_flg
    IS 'Indicates whether the value for this parameter was measured or derived due to missing data';

COMMENT ON COLUMN camddmw_arch.hour_unit_data_a.nox_mass
    IS 'Mass of NOx (pounds) emitted by a unit';

COMMENT ON COLUMN camddmw_arch.hour_unit_data_a.nox_mass_measure_flg
    IS 'Indicates whether the value for this parameter was measured or derived due to missing data';

COMMENT ON COLUMN camddmw_arch.hour_unit_data_a.nox_rate
    IS 'Average NOx hourly emissions rate (lbs/mmBtu) for a unit';

COMMENT ON COLUMN camddmw_arch.hour_unit_data_a.nox_rate_measure_flg
    IS 'Indicates whether the value for this parameter was measured or derived due to missing data';

COMMENT ON COLUMN camddmw_arch.hour_unit_data_a.rpt_period_id
    IS 'Reporting Period table id for the data';

COMMENT ON COLUMN camddmw_arch.hour_unit_data_a.op_year
    IS 'Year in which data was collected';

COMMENT ON COLUMN camddmw_arch.hour_unit_data_a.data_source
    IS 'Source of the data';

COMMENT ON COLUMN camddmw_arch.hour_unit_data_a.userid
    IS 'Initials of user who last modified data';

COMMENT ON COLUMN camddmw_arch.hour_unit_data_a.add_date
    IS 'Date on which the record was added';

-- Partitions SQL

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1995q1 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('1995-01-01') TO ('1995-04-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1995q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1995q2 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('1995-04-01') TO ('1995-07-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1995q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1995q3 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('1995-07-01') TO ('1995-10-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1995q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1995q4 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('1995-10-01') TO ('1996-01-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1995q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1996q1 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('1996-01-01') TO ('1996-04-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1996q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1996q2 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('1996-04-01') TO ('1996-07-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1996q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1996q3 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('1996-07-01') TO ('1996-10-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1996q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1996q4 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('1996-10-01') TO ('1997-01-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1996q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1997q1 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('1997-01-01') TO ('1997-04-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1997q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1997q2 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('1997-04-01') TO ('1997-07-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1997q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1997q3 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('1997-07-01') TO ('1997-10-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1997q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1997q4 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('1997-10-01') TO ('1998-01-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1997q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1998q1 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('1998-01-01') TO ('1998-04-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1998q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1998q2 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('1998-04-01') TO ('1998-07-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1998q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1998q3 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('1998-07-01') TO ('1998-10-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1998q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1998q4 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('1998-10-01') TO ('1999-01-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1998q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1999q1 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('1999-01-01') TO ('1999-04-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1999q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1999q2 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('1999-04-01') TO ('1999-07-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1999q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1999q3 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('1999-07-01') TO ('1999-10-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1999q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1999q4 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('1999-10-01') TO ('2000-01-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_1999q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2000q1 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2000-01-01') TO ('2000-04-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2000q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2000q2 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2000-04-01') TO ('2000-07-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2000q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2000q3 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2000-07-01') TO ('2000-10-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2000q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2000q4 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2000-10-01') TO ('2001-01-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2000q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2001q1 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2001-01-01') TO ('2001-04-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2001q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2001q2 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2001-04-01') TO ('2001-07-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2001q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2001q3 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2001-07-01') TO ('2001-10-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2001q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2001q4 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2001-10-01') TO ('2002-01-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2001q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2002q1 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2002-01-01') TO ('2002-04-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2002q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2002q2 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2002-04-01') TO ('2002-07-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2002q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2002q3 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2002-07-01') TO ('2002-10-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2002q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2002q4 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2002-10-01') TO ('2003-01-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2002q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2003q1 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2003-01-01') TO ('2003-04-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2003q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2003q2 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2003-04-01') TO ('2003-07-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2003q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2003q3 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2003-07-01') TO ('2003-10-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2003q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2003q4 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2003-10-01') TO ('2004-01-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2003q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2004q1 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2004-01-01') TO ('2004-04-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2004q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2004q2 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2004-04-01') TO ('2004-07-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2004q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2004q3 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2004-07-01') TO ('2004-10-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2004q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2004q4 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2004-10-01') TO ('2005-01-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2004q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2005q1 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2005-01-01') TO ('2005-04-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2005q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2005q2 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2005-04-01') TO ('2005-07-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2005q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2005q3 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2005-07-01') TO ('2005-10-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2005q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2005q4 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2005-10-01') TO ('2006-01-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2005q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2006q1 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2006-01-01') TO ('2006-04-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2006q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2006q2 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2006-04-01') TO ('2006-07-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2006q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2006q3 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2006-07-01') TO ('2006-10-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2006q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2006q4 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2006-10-01') TO ('2007-01-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2006q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2007q1 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2007-01-01') TO ('2007-04-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2007q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2007q2 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2007-04-01') TO ('2007-07-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2007q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2007q3 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2007-07-01') TO ('2007-10-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2007q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2007q4 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2007-10-01') TO ('2008-01-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2007q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2008q1 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2008-01-01') TO ('2008-04-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2008q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2008q2 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2008-04-01') TO ('2008-07-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2008q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2008q3 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2008-07-01') TO ('2008-10-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2008q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2008q4 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2008-10-01') TO ('2009-01-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2008q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2009q1 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2009-01-01') TO ('2009-04-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2009q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2009q2 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2009-04-01') TO ('2009-07-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2009q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2009q3 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2009-07-01') TO ('2009-10-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2009q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2009q4 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2009-10-01') TO ('2010-01-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2009q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2010q1 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2010-01-01') TO ('2010-04-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2010q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2010q2 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2010-04-01') TO ('2010-07-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2010q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2010q3 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2010-07-01') TO ('2010-10-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2010q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2010q4 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2010-10-01') TO ('2011-01-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2010q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2011q1 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2011-01-01') TO ('2011-04-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2011q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2011q2 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2011-04-01') TO ('2011-07-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2011q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2011q3 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2011-07-01') TO ('2011-10-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2011q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2011q4 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2011-10-01') TO ('2012-01-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2011q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2012q1 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2012-01-01') TO ('2012-04-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2012q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2012q2 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2012-04-01') TO ('2012-07-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2012q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2012q3 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2012-07-01') TO ('2012-10-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2012q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2012q4 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2012-10-01') TO ('2013-01-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2012q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2013q1 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2013-01-01') TO ('2013-04-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2013q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2013q2 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2013-04-01') TO ('2013-07-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2013q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2013q3 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2013-07-01') TO ('2013-10-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2013q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2013q4 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2013-10-01') TO ('2014-01-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2013q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2014q1 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2014-01-01') TO ('2014-04-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2014q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2014q2 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2014-04-01') TO ('2014-07-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2014q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2014q3 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2014-07-01') TO ('2014-10-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2014q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2014q4 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2014-10-01') TO ('2015-01-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2014q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2015q1 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2015-01-01') TO ('2015-04-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2015q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2015q2 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2015-04-01') TO ('2015-07-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2015q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2015q3 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2015-07-01') TO ('2015-10-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2015q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2015q4 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2015-10-01') TO ('2016-01-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2015q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2016q1 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2016-01-01') TO ('2016-04-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2016q1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2016q2 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2016-04-01') TO ('2016-07-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2016q2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2016q3 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2016-07-01') TO ('2016-10-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2016q3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2016q4 PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM ('2016-10-01') TO ('2017-01-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_2016q4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_before PARTITION OF camddmw_arch.hour_unit_data_a
    FOR VALUES FROM (MINVALUE) TO ('1995-01-01');

--ALTER TABLE camddmw_arch.hour_unit_data_a_dm_em_uh_before
--    OWNER to "uImcwuf4K9dyaxeL";