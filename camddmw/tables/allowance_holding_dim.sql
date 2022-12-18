-- Table: camddmw.allowance_holding_dim

-- DROP TABLE camddmw.allowance_holding_dim;

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim
(
    account_number character varying(12) COLLATE pg_catalog."default" NOT NULL,
    prg_code character varying(8) COLLATE pg_catalog."default" NOT NULL,
    start_block numeric(10,0) NOT NULL,
    end_block numeric(10,0) NOT NULL,
    vintage_year numeric(4,0) NOT NULL,
    total_block numeric(10,0),
    allowance_type character varying(35) COLLATE pg_catalog."default",
    originating_acct_number character varying(12) COLLATE pg_catalog."default",
    originating_party character varying(60) COLLATE pg_catalog."default",
    data_source character varying(35) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    account_name character varying(100) COLLATE pg_catalog."default",
    allowance_type_code character varying(3) COLLATE pg_catalog."default",
    last_update_date timestamp without time zone,
    CONSTRAINT allowance_holding_dim_pk PRIMARY KEY (vintage_year, prg_code, start_block)
) PARTITION BY RANGE (vintage_year);


COMMENT ON TABLE camddmw.allowance_holding_dim
    IS 'Current allowance block holdings';

COMMENT ON COLUMN camddmw.allowance_holding_dim.account_number
    IS 'Account number';

COMMENT ON COLUMN camddmw.allowance_holding_dim.prg_code
    IS 'Program code';

COMMENT ON COLUMN camddmw.allowance_holding_dim.start_block
    IS 'Beginning serial number for block of allowances';

COMMENT ON COLUMN camddmw.allowance_holding_dim.end_block
    IS 'Ending serial number for block of allowances';

COMMENT ON COLUMN camddmw.allowance_holding_dim.vintage_year
    IS 'Year in which allowance was issued';

COMMENT ON COLUMN camddmw.allowance_holding_dim.total_block
    IS 'Number of allowances in the block';

COMMENT ON COLUMN camddmw.allowance_holding_dim.allowance_type
    IS 'Type of allowance.  This field only indicates ERC (Early Reduction Credits) allowance types.  All other allowance type values that are stored in ATS/NATS are recorded as nulls in the data mart.';

COMMENT ON COLUMN camddmw.allowance_holding_dim.originating_acct_number
    IS 'Account to which this allowance was first issued';

COMMENT ON COLUMN camddmw.allowance_holding_dim.originating_party
    IS 'Name of owner or state to which allowance was first issued';

COMMENT ON COLUMN camddmw.allowance_holding_dim.data_source
    IS 'Source of the data';

COMMENT ON COLUMN camddmw.allowance_holding_dim.userid
    IS 'Initials of user who last modified data';

COMMENT ON COLUMN camddmw.allowance_holding_dim.add_date
    IS 'Date on which the record was added';

COMMENT ON COLUMN camddmw.allowance_holding_dim.account_name
    IS 'Account name';

COMMENT ON COLUMN camddmw.allowance_holding_dim.allowance_type_code
    IS 'Code for type of allowance.  The warehouse only contains ERC (Early Reduction Credits) allowance types.  All other allowance type values that are stored in ATS/NATS are recorded as nulls in the data mart.';

COMMENT ON COLUMN camddmw.allowance_holding_dim.last_update_date
    IS 'Latest add or update date on source records that are used to populate this record';

-- Index: all_hold_dim_idx1

-- DROP INDEX camddmw.all_hold_dim_idx1;

CREATE INDEX IF NOT EXISTS all_hold_dim_idx1
    ON camddmw.allowance_holding_dim USING btree
    (prg_code COLLATE pg_catalog."default" ASC NULLS LAST, start_block ASC NULLS LAST);

-- Index: allowance_holding_dim_idx002

-- DROP INDEX camddmw.allowance_holding_dim_idx002;

CREATE INDEX IF NOT EXISTS allowance_holding_dim_idx002
    ON camddmw.allowance_holding_dim USING btree
    (account_number COLLATE pg_catalog."default" ASC NULLS LAST, prg_code COLLATE pg_catalog."default" ASC NULLS LAST, allowance_type COLLATE pg_catalog."default" ASC NULLS LAST);

-- Partitions SQL

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p1 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM (MINVALUE) TO ('1996');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p10 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2004') TO ('2005');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p10
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p11 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2005') TO ('2006');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p11
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p12 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2006') TO ('2007');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p12
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p13 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2007') TO ('2008');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p13
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p14 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2008') TO ('2009');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p14
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p15 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2009') TO ('2010');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p15
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p16 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2010') TO ('2011');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p16
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p17 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2011') TO ('2012');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p17
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p18 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2012') TO ('2013');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p18
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p19 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2013') TO ('2014');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p19
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p2 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('1996') TO ('1997');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p20 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2014') TO ('2015');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p20
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p21 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2015') TO ('2016');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p21
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p22 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2016') TO ('2017');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p22
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p23 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2017') TO ('2018');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p23
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p24 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2018') TO ('2019');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p24
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p25 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2019') TO ('2020');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p25
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p26 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2020') TO ('2021');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p26
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p27 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2021') TO ('2022');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p27
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p28 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2022') TO ('2023');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p28
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p29 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2023') TO ('2024');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p29
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p3 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('1997') TO ('1998');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p30 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2024') TO ('2025');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p30
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p31 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2025') TO ('2026');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p31
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p32 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2026') TO ('2027');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p32
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p33 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2027') TO ('2028');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p33
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p34 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2028') TO ('2029');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p34
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p35 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2029') TO ('2030');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p35
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p36 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2030') TO ('2031');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p36
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p37 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2031') TO ('2032');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p37
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p38 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2032') TO ('2033');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p38
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p39 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2033') TO ('2034');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p39
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p4 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('1998') TO ('1999');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p40 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2034') TO ('2035');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p40
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p41 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2035') TO ('2036');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p41
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p42 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2036') TO ('2037');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p42
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p43 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2037') TO ('2038');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p43
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p44 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2038') TO ('2039');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p44
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p45 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2039') TO ('2040');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p45
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p46 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2040') TO ('2041');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p46
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p47 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2041') TO ('2042');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p47
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p48 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2042') TO ('2043');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p48
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p49 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2043') TO ('2044');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p49
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p5 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('1999') TO ('2000');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p5
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p50 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2044') TO ('2045');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p50
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p51 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2045') TO ('2046');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p51
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p52 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2046') TO ('2047');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p52
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p53 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2047') TO ('2048');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p53
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p54 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2048') TO ('2049');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p54
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p55 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2049') TO ('2050');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p55
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p56 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2050') TO ('2051');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p56
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p57 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2051') TO ('2052');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p57
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p58 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2052') TO ('2053');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p58
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p59 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2053') TO ('2054');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p59
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p6 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2000') TO ('2001');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p6
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p60 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2054') TO ('2055');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p60
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p61 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2055') TO ('2056');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p61
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p62 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2056') TO ('2057');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p62
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p63 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2057') TO ('2058');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p63
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p64 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2058') TO ('2059');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p64
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p65 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2059') TO ('2060');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p65
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p66 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2060') TO ('2061');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p66
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p7 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2001') TO ('2002');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p7
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p8 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2002') TO ('2003');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p8
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.allowance_holding_dim_all_hold_dim_p9 PARTITION OF camddmw.allowance_holding_dim
    FOR VALUES FROM ('2003') TO ('2004');

--ALTER TABLE camddmw.allowance_holding_dim_all_hold_dim_p9
--    OWNER to "uImcwuf4K9dyaxeL";
