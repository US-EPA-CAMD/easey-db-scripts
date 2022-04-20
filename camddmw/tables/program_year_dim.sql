-- Table: camddmw.program_year_dim

-- DROP TABLE camddmw.program_year_dim;

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim
(
    unit_id numeric(12,0) NOT NULL,
    prg_code character varying(8) COLLATE pg_catalog."default" NOT NULL,
    program_description character varying(1000) COLLATE pg_catalog."default",
    op_year numeric(4,0) NOT NULL,
    report_freq character varying(2) COLLATE pg_catalog."default",
    data_source character varying(35) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    non_egu_flg character varying(8) COLLATE pg_catalog."default",
    compliance_ind double precision,
    last_update_date timestamp without time zone,
    CONSTRAINT pk_prog_year_dim PRIMARY KEY (unit_id, prg_code, op_year)
) PARTITION BY RANGE (op_year);


COMMENT ON TABLE camddmw.program_year_dim
    IS 'Dimension table of programs that a unit has participated in for a given operating year.';

COMMENT ON COLUMN camddmw.program_year_dim.unit_id
    IS 'Unique identifier of a unit';

COMMENT ON COLUMN camddmw.program_year_dim.prg_code
    IS 'Program code';

COMMENT ON COLUMN camddmw.program_year_dim.program_description
    IS 'Text description of program code';

COMMENT ON COLUMN camddmw.program_year_dim.op_year
    IS 'Year in which data was collected';

COMMENT ON COLUMN camddmw.program_year_dim.report_freq
    IS 'EDR reporting frequency (annual or ozone season) for a UNIT for a PROGRAM';

COMMENT ON COLUMN camddmw.program_year_dim.data_source
    IS 'Source of the data';

COMMENT ON COLUMN camddmw.program_year_dim.userid
    IS 'Initials of user who last modified data';

COMMENT ON COLUMN camddmw.program_year_dim.add_date
    IS 'Date on which the record was added';

COMMENT ON COLUMN camddmw.program_year_dim.non_egu_flg
    IS 'Identifies whether unit is electric-generating';

COMMENT ON COLUMN camddmw.program_year_dim.compliance_ind
    IS 'Indicates whether the unit is expected for compliance for the year and program.  1 is true, 0 is false';

COMMENT ON COLUMN camddmw.program_year_dim.last_update_date
    IS 'Latest add or update date on source records that are used to populate this record';

-- Partitions SQL

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p1 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM (MINVALUE) TO ('1981');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p10 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('1989') TO ('1990');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p10
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p11 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('1990') TO ('1991');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p11
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p12 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('1991') TO ('1992');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p12
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p13 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('1992') TO ('1993');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p13
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p14 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('1993') TO ('1994');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p14
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p15 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('1994') TO ('1995');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p15
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p16 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('1995') TO ('1996');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p16
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p17 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('1996') TO ('1997');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p17
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p18 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('1997') TO ('1998');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p18
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p19 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('1998') TO ('1999');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p19
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p2 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('1981') TO ('1982');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p20 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('1999') TO ('2000');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p20
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p21 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('2000') TO ('2001');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p21
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p22 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('2001') TO ('2002');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p22
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p23 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('2002') TO ('2003');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p23
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p24 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('2003') TO ('2004');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p24
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p25 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('2004') TO ('2005');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p25
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p26 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('2005') TO ('2006');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p26
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p27 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('2006') TO ('2007');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p27
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p28 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('2007') TO ('2008');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p28
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p29 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('2008') TO ('2009');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p29
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p3 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('1982') TO ('1983');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p30 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('2009') TO ('2010');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p30
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p31 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('2010') TO ('2011');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p31
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p32 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('2011') TO ('2012');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p32
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p33 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('2012') TO ('2013');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p33
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p34 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('2013') TO ('2014');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p34
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p35 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('2014') TO ('2015');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p35
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p36 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('2015') TO ('2016');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p36
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p37 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('2016') TO ('2017');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p37
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p38 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('2017') TO ('2018');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p38
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p39 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('2018') TO ('2019');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p39
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p4 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('1983') TO ('1984');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p40 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('2019') TO ('2020');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p40
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p41 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('2020') TO ('2021');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p41
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p42 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('2021') TO ('2022');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p42
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p43 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('2022') TO ('2023');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p43
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p5 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('1984') TO ('1985');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p5
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p6 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('1985') TO ('1986');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p6
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p7 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('1986') TO ('1987');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p7
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p8 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('1987') TO ('1988');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p8
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.program_year_dim_prg_year_dim_p9 PARTITION OF camddmw.program_year_dim
    FOR VALUES FROM ('1988') TO ('1989');

--ALTER TABLE camddmw.program_year_dim_prg_year_dim_p9
--    OWNER to "uImcwuf4K9dyaxeL";
