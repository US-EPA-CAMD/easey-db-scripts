-- Table: camddmw.rep_year_dim

-- DROP TABLE camddmw.rep_year_dim;

CREATE TABLE IF NOT EXISTS camddmw.rep_year_dim
(
    rep_yr_id double precision NOT NULL,
    unit_id numeric(12,0),
    op_year numeric(4,0),
    ppl_id numeric(12,0),
    prg_code character varying(8) COLLATE pg_catalog."default",
    rep_code character varying(6) COLLATE pg_catalog."default",
    data_source character varying(35) COLLATE pg_catalog."default",
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp(0) without time zone,
    begin_date timestamp(0) without time zone,
    end_date timestamp(0) without time zone,
    CONSTRAINT rep_year_dim_u01 UNIQUE (unit_id, op_year, ppl_id, prg_code, rep_code, begin_date)
) PARTITION BY RANGE (op_year);

COMMENT ON TABLE camddmw.rep_year_dim
    IS 'Representatives of units for an operating year at the individual representative level';

COMMENT ON COLUMN camddmw.rep_year_dim.rep_yr_id
    IS 'Identity key for REP_YEAR_DIM';

COMMENT ON COLUMN camddmw.rep_year_dim.unit_id
    IS 'Unique identifier of a unit';

COMMENT ON COLUMN camddmw.rep_year_dim.op_year
    IS 'Year in which data was collected';

COMMENT ON COLUMN camddmw.rep_year_dim.ppl_id
    IS 'Unique identifier of a record in the PEOPLE table';

COMMENT ON COLUMN camddmw.rep_year_dim.prg_code
    IS 'Program code';

COMMENT ON COLUMN camddmw.rep_year_dim.rep_code
    IS 'Code indicating alternate or primary representative';

COMMENT ON COLUMN camddmw.rep_year_dim.data_source
    IS 'Source of the data';

COMMENT ON COLUMN camddmw.rep_year_dim.userid
    IS 'Initials of user who last modified data';

COMMENT ON COLUMN camddmw.rep_year_dim.add_date
    IS 'Date on which the record was added';

COMMENT ON COLUMN camddmw.rep_year_dim.begin_date
    IS 'Date on which the individual began as the representative';

COMMENT ON COLUMN camddmw.rep_year_dim.end_date
    IS 'Date on which the individual ended as the representative';
-- Index: rep_year_dim_idx003

-- DROP INDEX camddmw.rep_year_dim_idx003;

CREATE INDEX IF NOT EXISTS rep_year_dim_idx003
    ON camddmw.rep_year_dim USING btree
    (unit_id ASC NULLS LAST, op_year ASC NULLS LAST);
-- Index: rep_year_dim_idx1

-- DROP INDEX camddmw.rep_year_dim_idx1;

CREATE INDEX IF NOT EXISTS rep_year_dim_idx1
    ON camddmw.rep_year_dim USING btree
    (unit_id ASC NULLS LAST, ppl_id ASC NULLS LAST);
-- Index: rep_year_dim_idx2

-- DROP INDEX camddmw.rep_year_dim_idx2;

CREATE INDEX IF NOT EXISTS rep_year_dim_idx2
    ON camddmw.rep_year_dim USING btree
    (ppl_id ASC NULLS LAST);

-- Partitions SQL

CREATE TABLE IF NOT EXISTS camddmw.rep_year_dim_rep_year_dm_p1 PARTITION OF camddmw.rep_year_dim
    FOR VALUES FROM (MINVALUE) TO ('1996');

CREATE TABLE IF NOT EXISTS camddmw.rep_year_dim_rep_year_dm_p10 PARTITION OF camddmw.rep_year_dim
    FOR VALUES FROM ('2004') TO ('2005');

CREATE TABLE IF NOT EXISTS camddmw.rep_year_dim_rep_year_dm_p11 PARTITION OF camddmw.rep_year_dim
    FOR VALUES FROM ('2005') TO ('2006');

CREATE TABLE IF NOT EXISTS camddmw.rep_year_dim_rep_year_dm_p12 PARTITION OF camddmw.rep_year_dim
    FOR VALUES FROM ('2006') TO ('2007');

CREATE TABLE IF NOT EXISTS camddmw.rep_year_dim_rep_year_dm_p13 PARTITION OF camddmw.rep_year_dim
    FOR VALUES FROM ('2007') TO ('2008');

CREATE TABLE IF NOT EXISTS camddmw.rep_year_dim_rep_year_dm_p14 PARTITION OF camddmw.rep_year_dim
    FOR VALUES FROM ('2008') TO ('2009');

CREATE TABLE IF NOT EXISTS camddmw.rep_year_dim_rep_year_dm_p15 PARTITION OF camddmw.rep_year_dim
    FOR VALUES FROM ('2009') TO ('2010');

CREATE TABLE IF NOT EXISTS camddmw.rep_year_dim_rep_year_dm_p16 PARTITION OF camddmw.rep_year_dim
    FOR VALUES FROM ('2010') TO ('2011');

CREATE TABLE IF NOT EXISTS camddmw.rep_year_dim_rep_year_dm_p17 PARTITION OF camddmw.rep_year_dim
    FOR VALUES FROM ('2011') TO ('2012');

CREATE TABLE IF NOT EXISTS camddmw.rep_year_dim_rep_year_dm_p18 PARTITION OF camddmw.rep_year_dim
    FOR VALUES FROM ('2012') TO ('2013');

CREATE TABLE IF NOT EXISTS camddmw.rep_year_dim_rep_year_dm_p19 PARTITION OF camddmw.rep_year_dim
    FOR VALUES FROM ('2013') TO ('2014');

CREATE TABLE IF NOT EXISTS camddmw.rep_year_dim_rep_year_dm_p2 PARTITION OF camddmw.rep_year_dim
    FOR VALUES FROM ('1996') TO ('1997');

CREATE TABLE IF NOT EXISTS camddmw.rep_year_dim_rep_year_dm_p20 PARTITION OF camddmw.rep_year_dim
    FOR VALUES FROM ('2014') TO ('2015');

CREATE TABLE IF NOT EXISTS camddmw.rep_year_dim_rep_year_dm_p21 PARTITION OF camddmw.rep_year_dim
    FOR VALUES FROM ('2015') TO ('2016');

CREATE TABLE IF NOT EXISTS camddmw.rep_year_dim_rep_year_dm_p22 PARTITION OF camddmw.rep_year_dim
    FOR VALUES FROM ('2016') TO ('2017');

CREATE TABLE IF NOT EXISTS camddmw.rep_year_dim_rep_year_dm_p23 PARTITION OF camddmw.rep_year_dim
    FOR VALUES FROM ('2017') TO ('2018');

CREATE TABLE IF NOT EXISTS camddmw.rep_year_dim_rep_year_dm_p24 PARTITION OF camddmw.rep_year_dim
    FOR VALUES FROM ('2018') TO ('2019');

CREATE TABLE IF NOT EXISTS camddmw.rep_year_dim_rep_year_dm_p25 PARTITION OF camddmw.rep_year_dim
    FOR VALUES FROM ('2019') TO ('2020');

CREATE TABLE IF NOT EXISTS camddmw.rep_year_dim_rep_year_dm_p26 PARTITION OF camddmw.rep_year_dim
    FOR VALUES FROM ('2020') TO ('2021');

CREATE TABLE IF NOT EXISTS camddmw.rep_year_dim_rep_year_dm_p27 PARTITION OF camddmw.rep_year_dim
    FOR VALUES FROM ('2021') TO ('2022');

CREATE TABLE IF NOT EXISTS camddmw.rep_year_dim_rep_year_dm_p28 PARTITION OF camddmw.rep_year_dim
    FOR VALUES FROM ('2022') TO ('2023');

CREATE TABLE IF NOT EXISTS camddmw.rep_year_dim_rep_year_dm_p3 PARTITION OF camddmw.rep_year_dim
    FOR VALUES FROM ('1997') TO ('1998');

CREATE TABLE IF NOT EXISTS camddmw.rep_year_dim_rep_year_dm_p4 PARTITION OF camddmw.rep_year_dim
    FOR VALUES FROM ('1998') TO ('1999');

CREATE TABLE IF NOT EXISTS camddmw.rep_year_dim_rep_year_dm_p5 PARTITION OF camddmw.rep_year_dim
    FOR VALUES FROM ('1999') TO ('2000');

CREATE TABLE IF NOT EXISTS camddmw.rep_year_dim_rep_year_dm_p6 PARTITION OF camddmw.rep_year_dim
    FOR VALUES FROM ('2000') TO ('2001');

CREATE TABLE IF NOT EXISTS camddmw.rep_year_dim_rep_year_dm_p7 PARTITION OF camddmw.rep_year_dim
    FOR VALUES FROM ('2001') TO ('2002');

CREATE TABLE IF NOT EXISTS camddmw.rep_year_dim_rep_year_dm_p8 PARTITION OF camddmw.rep_year_dim
    FOR VALUES FROM ('2002') TO ('2003');

CREATE TABLE IF NOT EXISTS camddmw.rep_year_dim_rep_year_dm_p9 PARTITION OF camddmw.rep_year_dim
    FOR VALUES FROM ('2003') TO ('2004');
