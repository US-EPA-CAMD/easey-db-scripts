CREATE TABLE camddmw.fuel_year_dim
(
    fuel_yr_dim numeric(10,0) NOT NULL,
    unit_id numeric(12,0) NOT NULL,
    op_year numeric(4,0) NOT NULL,
    fuel_code character varying(10) COLLATE pg_catalog."default",
    fuel_type_description character varying(35) COLLATE pg_catalog."default",
    indicator character varying(2) COLLATE pg_catalog."default",
    data_source character varying(35) COLLATE pg_catalog."default",
    userid character varying(8) COLLATE pg_catalog."default",
    add_date date,
    CONSTRAINT uk_fuel_year_1 UNIQUE (unit_id, fuel_code, op_year, indicator)
) PARTITION BY RANGE (op_year);

-- ALTER TABLE camddmw.fuel_year_dim
--    OWNER to "uImcwuf4K9dyaxeL";

COMMENT ON TABLE camddmw.fuel_year_dim
    IS 'Primary and secondary unit fuels for an operating year';

COMMENT ON COLUMN camddmw.fuel_year_dim.fuel_yr_dim
    IS 'Identity key of FUEL_YEAR_DIM table';

COMMENT ON COLUMN camddmw.fuel_year_dim.unit_id
    IS 'Unique identifier of a unit';

COMMENT ON COLUMN camddmw.fuel_year_dim.op_year
    IS 'Year in which data was collected';

COMMENT ON COLUMN camddmw.fuel_year_dim.fuel_code
    IS 'Fuel type code';

COMMENT ON COLUMN camddmw.fuel_year_dim.fuel_type_description
    IS 'Fuel type description';

COMMENT ON COLUMN camddmw.fuel_year_dim.indicator
    IS 'Indicates whether the parameter was used as a primary or secondary source';

COMMENT ON COLUMN camddmw.fuel_year_dim.data_source
    IS 'Source of the data';

COMMENT ON COLUMN camddmw.fuel_year_dim.userid
    IS 'Initials of user who last modified data';

COMMENT ON COLUMN camddmw.fuel_year_dim.add_date
    IS 'Date on which the record was added';
-- Index: fuel_year_dim_idx2

-- DROP INDEX camddmw.fuel_year_dim_idx2;

CREATE INDEX fuel_year_dim_idx2
    ON camddmw.fuel_year_dim USING btree
    (fuel_code COLLATE pg_catalog."default" ASC NULLS LAST, indicator COLLATE pg_catalog."default" ASC NULLS LAST, unit_id ASC NULLS LAST, fuel_type_description COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

-- Partitions SQL

CREATE TABLE camddmw.fuel_year_dim_fuel_yr_dim_p1 PARTITION OF camddmw.fuel_year_dim
    FOR VALUES FROM (MINVALUE) TO ('1996');

-- ALTER TABLE camddmw.fuel_year_dim_fuel_yr_dim_p1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw.fuel_year_dim_fuel_yr_dim_p10 PARTITION OF camddmw.fuel_year_dim
    FOR VALUES FROM ('2004') TO ('2005');

-- ALTER TABLE camddmw.fuel_year_dim_fuel_yr_dim_p10
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw.fuel_year_dim_fuel_yr_dim_p11 PARTITION OF camddmw.fuel_year_dim
    FOR VALUES FROM ('2005') TO ('2006');

-- ALTER TABLE camddmw.fuel_year_dim_fuel_yr_dim_p11
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw.fuel_year_dim_fuel_yr_dim_p12 PARTITION OF camddmw.fuel_year_dim
    FOR VALUES FROM ('2006') TO ('2007');

-- ALTER TABLE camddmw.fuel_year_dim_fuel_yr_dim_p12
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw.fuel_year_dim_fuel_yr_dim_p13 PARTITION OF camddmw.fuel_year_dim
    FOR VALUES FROM ('2007') TO ('2008');

-- ALTER TABLE camddmw.fuel_year_dim_fuel_yr_dim_p13
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw.fuel_year_dim_fuel_yr_dim_p14 PARTITION OF camddmw.fuel_year_dim
    FOR VALUES FROM ('2008') TO ('2009');

-- ALTER TABLE camddmw.fuel_year_dim_fuel_yr_dim_p14
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw.fuel_year_dim_fuel_yr_dim_p15 PARTITION OF camddmw.fuel_year_dim
    FOR VALUES FROM ('2009') TO ('2010');

-- ALTER TABLE camddmw.fuel_year_dim_fuel_yr_dim_p15
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw.fuel_year_dim_fuel_yr_dim_p16 PARTITION OF camddmw.fuel_year_dim
    FOR VALUES FROM ('2010') TO ('2011');

-- ALTER TABLE camddmw.fuel_year_dim_fuel_yr_dim_p16
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw.fuel_year_dim_fuel_yr_dim_p17 PARTITION OF camddmw.fuel_year_dim
    FOR VALUES FROM ('2011') TO ('2012');

-- ALTER TABLE camddmw.fuel_year_dim_fuel_yr_dim_p17
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw.fuel_year_dim_fuel_yr_dim_p18 PARTITION OF camddmw.fuel_year_dim
    FOR VALUES FROM ('2012') TO ('2013');

-- ALTER TABLE camddmw.fuel_year_dim_fuel_yr_dim_p18
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw.fuel_year_dim_fuel_yr_dim_p19 PARTITION OF camddmw.fuel_year_dim
    FOR VALUES FROM ('2013') TO ('2014');

-- ALTER TABLE camddmw.fuel_year_dim_fuel_yr_dim_p19
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw.fuel_year_dim_fuel_yr_dim_p2 PARTITION OF camddmw.fuel_year_dim
    FOR VALUES FROM ('1996') TO ('1997');

-- ALTER TABLE camddmw.fuel_year_dim_fuel_yr_dim_p2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw.fuel_year_dim_fuel_yr_dim_p20 PARTITION OF camddmw.fuel_year_dim
    FOR VALUES FROM ('2014') TO ('2015');

-- ALTER TABLE camddmw.fuel_year_dim_fuel_yr_dim_p20
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw.fuel_year_dim_fuel_yr_dim_p21 PARTITION OF camddmw.fuel_year_dim
    FOR VALUES FROM ('2015') TO ('2016');

-- ALTER TABLE camddmw.fuel_year_dim_fuel_yr_dim_p21
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw.fuel_year_dim_fuel_yr_dim_p22 PARTITION OF camddmw.fuel_year_dim
    FOR VALUES FROM ('2016') TO ('2017');

-- ALTER TABLE camddmw.fuel_year_dim_fuel_yr_dim_p22
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw.fuel_year_dim_fuel_yr_dim_p23 PARTITION OF camddmw.fuel_year_dim
    FOR VALUES FROM ('2017') TO ('2018');

-- ALTER TABLE camddmw.fuel_year_dim_fuel_yr_dim_p23
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw.fuel_year_dim_fuel_yr_dim_p24 PARTITION OF camddmw.fuel_year_dim
    FOR VALUES FROM ('2018') TO ('2019');

-- ALTER TABLE camddmw.fuel_year_dim_fuel_yr_dim_p24
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw.fuel_year_dim_fuel_yr_dim_p25 PARTITION OF camddmw.fuel_year_dim
    FOR VALUES FROM ('2019') TO ('2020');

-- ALTER TABLE camddmw.fuel_year_dim_fuel_yr_dim_p25
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw.fuel_year_dim_fuel_yr_dim_p26 PARTITION OF camddmw.fuel_year_dim
    FOR VALUES FROM ('2020') TO ('2021');

-- ALTER TABLE camddmw.fuel_year_dim_fuel_yr_dim_p26
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw.fuel_year_dim_fuel_yr_dim_p27 PARTITION OF camddmw.fuel_year_dim
    FOR VALUES FROM ('2021') TO ('2022');

-- ALTER TABLE camddmw.fuel_year_dim_fuel_yr_dim_p27
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw.fuel_year_dim_fuel_yr_dim_p3 PARTITION OF camddmw.fuel_year_dim
    FOR VALUES FROM ('1997') TO ('1998');

-- ALTER TABLE camddmw.fuel_year_dim_fuel_yr_dim_p3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw.fuel_year_dim_fuel_yr_dim_p4 PARTITION OF camddmw.fuel_year_dim
    FOR VALUES FROM ('1998') TO ('1999');

-- ALTER TABLE camddmw.fuel_year_dim_fuel_yr_dim_p4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw.fuel_year_dim_fuel_yr_dim_p5 PARTITION OF camddmw.fuel_year_dim
    FOR VALUES FROM ('1999') TO ('2000');

-- ALTER TABLE camddmw.fuel_year_dim_fuel_yr_dim_p5
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw.fuel_year_dim_fuel_yr_dim_p6 PARTITION OF camddmw.fuel_year_dim
    FOR VALUES FROM ('2000') TO ('2001');

-- ALTER TABLE camddmw.fuel_year_dim_fuel_yr_dim_p6
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw.fuel_year_dim_fuel_yr_dim_p7 PARTITION OF camddmw.fuel_year_dim
    FOR VALUES FROM ('2001') TO ('2002');

-- ALTER TABLE camddmw.fuel_year_dim_fuel_yr_dim_p7
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw.fuel_year_dim_fuel_yr_dim_p8 PARTITION OF camddmw.fuel_year_dim
    FOR VALUES FROM ('2002') TO ('2003');

-- ALTER TABLE camddmw.fuel_year_dim_fuel_yr_dim_p8
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE camddmw.fuel_year_dim_fuel_yr_dim_p9 PARTITION OF camddmw.fuel_year_dim
    FOR VALUES FROM ('2003') TO ('2004');

-- ALTER TABLE camddmw.fuel_year_dim_fuel_yr_dim_p9
--    OWNER to "uImcwuf4K9dyaxeL";