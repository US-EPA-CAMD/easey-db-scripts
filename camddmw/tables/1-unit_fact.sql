-- Table: camddmw.unit_fact

-- DROP TABLE camddmw.unit_fact;

CREATE TABLE IF NOT EXISTS camddmw.unit_fact
(
    unit_id numeric(12,0) NOT NULL,
    op_year numeric(4,0) NOT NULL,
    fac_id numeric(12,0),
    facility_name character varying(40) COLLATE pg_catalog."default",
    orispl_code numeric(6,0),
    unitid character varying(6) COLLATE pg_catalog."default",
    county_code character varying(8) COLLATE pg_catalog."default",
    county character varying(45) COLLATE pg_catalog."default",
    fips_code character varying(3) COLLATE pg_catalog."default",
    comm_op_date date,
    comr_op_date date,
    source_cat character varying(1000) COLLATE pg_catalog."default",
    capacity_input numeric(7,1),
    capacity_output numeric(7,1),
    state character(2) COLLATE pg_catalog."default",
    state_name character varying(20) COLLATE pg_catalog."default",
    latitude numeric(7,4),
    longitude numeric(8,4),
    epa_region numeric(2,0),
    epa_region_description character varying(1000) COLLATE pg_catalog."default",
    naics_code numeric(6,0),
    naic_code_description character varying(1000) COLLATE pg_catalog."default",
    sic_code numeric(4,0),
    sic_code_description character varying(1000) COLLATE pg_catalog."default",
    nerc_region character varying(7) COLLATE pg_catalog."default",
    nerc_description character varying(1000) COLLATE pg_catalog."default",
    prg_code_info character varying(1000) COLLATE pg_catalog."default",
    op_status_info character varying(1000) COLLATE pg_catalog."default",
    primary_fuel_info character varying(1000) COLLATE pg_catalog."default",
    secondary_fuel_info character varying(1000) COLLATE pg_catalog."default",
    unit_type_info character varying(1000) COLLATE pg_catalog."default",
    data_source character varying(35) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    userid character varying(25) COLLATE pg_catalog."default",
    so2_control_info character varying(1000) COLLATE pg_catalog."default",
    nox_control_info character varying(1000) COLLATE pg_catalog."default",
    part_control_info character varying(1000) COLLATE pg_catalog."default",
    nox_phase character varying(1000) COLLATE pg_catalog."default",
    so2_phase character varying(1000) COLLATE pg_catalog."default",
    assoc_stacks character varying(250) COLLATE pg_catalog."default",
    hg_control_info character varying(1000) COLLATE pg_catalog."default",
    last_update_date timestamp without time zone,
    CONSTRAINT pk_unit_fact PRIMARY KEY (unit_id, op_year)
) PARTITION BY RANGE (op_year);


COMMENT ON TABLE camddmw.unit_fact
    IS 'Unit characteristics aggregated by year';

COMMENT ON COLUMN camddmw.unit_fact.unit_id
    IS 'Unique identifier of a unit';

COMMENT ON COLUMN camddmw.unit_fact.op_year
    IS 'Year in which data was collected';

COMMENT ON COLUMN camddmw.unit_fact.fac_id
    IS 'Unique identifier of a facility';

COMMENT ON COLUMN camddmw.unit_fact.facility_name
    IS 'Name of the facility, as reported by representative on Certification of Representation forms or equivalent';

COMMENT ON COLUMN camddmw.unit_fact.orispl_code
    IS 'EIA-assigned identifier or FACILITY ID assigned by CAMD (if EIA number is not applicable)';

COMMENT ON COLUMN camddmw.unit_fact.unitid
    IS 'Public identifier used for unit for program identification purposes';

COMMENT ON COLUMN camddmw.unit_fact.county_code
    IS 'Concatenation of state and FIPS code';

COMMENT ON COLUMN camddmw.unit_fact.county
    IS 'Full county name';

COMMENT ON COLUMN camddmw.unit_fact.fips_code
    IS 'The FIPS county code for the county in which the facility is located';

COMMENT ON COLUMN camddmw.unit_fact.comm_op_date
    IS 'First day of operation that a unit generated electricity for sale, including the sale of test generation';

COMMENT ON COLUMN camddmw.unit_fact.comr_op_date
    IS 'First day of commercial operation for a UNIT';

COMMENT ON COLUMN camddmw.unit_fact.source_cat
    IS 'Source category of the unit';

COMMENT ON COLUMN camddmw.unit_fact.capacity_input
    IS 'The maximum hourly heat input (mmBtu/hr) associated with a unit';

COMMENT ON COLUMN camddmw.unit_fact.capacity_output
    IS 'The maximum hourly heat output (mmBtu/hr) associated with a unit';

COMMENT ON COLUMN camddmw.unit_fact.state
    IS 'State abbreviation';

COMMENT ON COLUMN camddmw.unit_fact.state_name
    IS 'State name';

COMMENT ON COLUMN camddmw.unit_fact.latitude
    IS 'Facility latitude';

COMMENT ON COLUMN camddmw.unit_fact.longitude
    IS 'Facility longitude';

COMMENT ON COLUMN camddmw.unit_fact.epa_region
    IS 'EPA region code';

COMMENT ON COLUMN camddmw.unit_fact.epa_region_description
    IS 'EPA region name';

COMMENT ON COLUMN camddmw.unit_fact.naics_code
    IS 'North American Industry Classification System (NAICS) code.  Provides information about the economic sector and specific industry, on a FACILITY level.';

COMMENT ON COLUMN camddmw.unit_fact.naic_code_description
    IS 'Description of North American Industry Classification System (NAICS) code';

COMMENT ON COLUMN camddmw.unit_fact.sic_code
    IS 'Standard Industrial Classification (SIC) System code';

COMMENT ON COLUMN camddmw.unit_fact.sic_code_description
    IS 'Description of Standard Industrial Classification (SIC) System code';

COMMENT ON COLUMN camddmw.unit_fact.nerc_region
    IS 'Code for one of thirteen regions as specified by the North American Electric Reliability Council (NERC)';

COMMENT ON COLUMN camddmw.unit_fact.nerc_description
    IS 'Full name of one of the thirteen regions in the North American Electric Reliability Council';

COMMENT ON COLUMN camddmw.unit_fact.prg_code_info
    IS 'Program participation information for the year';

COMMENT ON COLUMN camddmw.unit_fact.op_status_info
    IS 'Unit operating status information for the year';

COMMENT ON COLUMN camddmw.unit_fact.primary_fuel_info
    IS 'Primary fuel type information for the year';

COMMENT ON COLUMN camddmw.unit_fact.secondary_fuel_info
    IS 'Secondary fuel type information for the year';

COMMENT ON COLUMN camddmw.unit_fact.unit_type_info
    IS 'Type of unit or boiler';

COMMENT ON COLUMN camddmw.unit_fact.data_source
    IS 'Source of the data';

COMMENT ON COLUMN camddmw.unit_fact.add_date
    IS 'Date on which the record was added';

COMMENT ON COLUMN camddmw.unit_fact.userid
    IS 'Initials of user who last modified data';

COMMENT ON COLUMN camddmw.unit_fact.so2_control_info
    IS 'Formatted list of all SO2 controls for a unit';

COMMENT ON COLUMN camddmw.unit_fact.nox_control_info
    IS 'Formatted list of all NOx controls for a unit';

COMMENT ON COLUMN camddmw.unit_fact.part_control_info
    IS 'Formatted list of all particulate controls for a unit';

COMMENT ON COLUMN camddmw.unit_fact.nox_phase
    IS 'NOx phase of the unit';

COMMENT ON COLUMN camddmw.unit_fact.so2_phase
    IS 'SO2 phase of the unit';

COMMENT ON COLUMN camddmw.unit_fact.assoc_stacks
    IS 'Stacks linked to a unit';

COMMENT ON COLUMN camddmw.unit_fact.hg_control_info
    IS 'Formatted list of all mercury controls for a unit';

COMMENT ON COLUMN camddmw.unit_fact.last_update_date
    IS 'Latest add or update date on source records that are used to populate this record';

-- Index: idx_unit_fact_fac_id

-- DROP INDEX camddmw.idx_unit_fact_fac_id;

CREATE INDEX idx_unit_fact_fac_id
    ON camddmw.unit_fact USING btree
    (fac_id ASC NULLS LAST);

-- Index: idx_unit_fact_orispl_code

-- DROP INDEX camddmw.idx_unit_fact_orispl_code;

CREATE INDEX idx_unit_fact_orispl_code
    ON camddmw.unit_fact USING btree
    (orispl_code ASC NULLS LAST);

-- Index: idx_unit_fact_state

-- DROP INDEX camddmw.idx_unit_fact_state;

CREATE INDEX idx_unit_fact_state
    ON camddmw.unit_fact USING btree
    (state COLLATE pg_catalog."default" ASC NULLS LAST);

-- Partitions SQL

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p1 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM (MINVALUE) TO ('1981');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p10 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('1989') TO ('1990');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p10
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p11 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('1990') TO ('1991');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p11
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p12 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('1991') TO ('1992');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p12
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p13 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('1992') TO ('1993');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p13
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p14 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('1993') TO ('1994');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p14
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p15 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('1994') TO ('1995');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p15
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p16 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('1995') TO ('1996');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p16
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p17 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('1996') TO ('1997');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p17
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p18 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('1997') TO ('1998');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p18
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p19 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('1998') TO ('1999');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p19
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p2 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('1981') TO ('1982');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p20 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('1999') TO ('2000');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p20
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p21 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('2000') TO ('2001');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p21
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p22 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('2001') TO ('2002');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p22
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p23 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('2002') TO ('2003');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p23
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p24 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('2003') TO ('2004');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p24
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p25 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('2004') TO ('2005');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p25
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p26 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('2005') TO ('2006');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p26
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p27 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('2006') TO ('2007');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p27
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p28 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('2007') TO ('2008');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p28
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p29 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('2008') TO ('2009');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p29
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p3 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('1982') TO ('1983');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p3
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p30 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('2009') TO ('2010');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p30
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p31 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('2010') TO ('2011');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p31
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p32 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('2011') TO ('2012');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p32
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p33 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('2012') TO ('2013');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p33
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p34 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('2013') TO ('2014');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p34
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p35 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('2014') TO ('2015');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p35
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p36 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('2015') TO ('2016');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p36
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p37 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('2016') TO ('2017');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p37
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p38 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('2017') TO ('2018');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p38
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p39 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('2018') TO ('2019');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p39
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p4 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('1983') TO ('1984');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p4
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p40 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('2019') TO ('2020');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p40
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p41 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('2020') TO ('2021');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p41
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p42 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('2021') TO ('2022');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p42
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p43 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('2022') TO ('2023');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p43
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p5 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('1984') TO ('1985');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p5
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p6 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('1985') TO ('1986');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p6
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p7 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('1986') TO ('1987');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p7
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p8 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('1987') TO ('1988');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p8
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.unit_fact_unit_fact_tmp_p9 PARTITION OF camddmw.unit_fact
    FOR VALUES FROM ('1988') TO ('1989');

--ALTER TABLE camddmw.unit_fact_unit_fact_tmp_p9
--    OWNER to "uImcwuf4K9dyaxeL";
