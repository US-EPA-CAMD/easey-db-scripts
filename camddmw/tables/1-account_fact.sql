-- Table: camddmw.account_fact

-- DROP TABLE camddmw.account_fact;

CREATE TABLE IF NOT EXISTS camddmw.account_fact
(
    account_number character varying(12) COLLATE pg_catalog."default" NOT NULL,
    prg_code character varying(8) COLLATE pg_catalog."default" NOT NULL,
    account_name character varying(100) COLLATE pg_catalog."default",
    account_type character varying(35) COLLATE pg_catalog."default",
    unit_id numeric(38,0),
    unitid character varying(6) COLLATE pg_catalog."default",
    op_status_info character varying(1000) COLLATE pg_catalog."default",
    primary_fuel_info character varying(1000) COLLATE pg_catalog."default",
    secondary_fuel_info character varying(1000) COLLATE pg_catalog."default",
    own_display character varying(4000) COLLATE pg_catalog."default",
    unit_type_info character varying(1000) COLLATE pg_catalog."default",
    prm_display_name character varying(100) COLLATE pg_catalog."default",
    prm_display_block character varying(2000) COLLATE pg_catalog."default",
    alt_display_name character varying(100) COLLATE pg_catalog."default",
    alt_display_block character varying(2000) COLLATE pg_catalog."default",
    epa_region numeric(2,0),
    epa_region_description character varying(35) COLLATE pg_catalog."default",
    state character(2) COLLATE pg_catalog."default",
    state_name character varying(20) COLLATE pg_catalog."default",
    source_cat character varying(30) COLLATE pg_catalog."default",
    fac_id numeric(12,0),
    facility_name character varying(40) COLLATE pg_catalog."default",
    orispl_code numeric(6,0),
    phase1_allocation numeric(10,0),
    phase2a_allocation numeric(10,0),
    phase2b_allocation numeric(10,0),
    data_source character varying(35) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    userid character varying(25) COLLATE pg_catalog."default",
    so2_control_info character varying(1000) COLLATE pg_catalog."default",
    nox_control_info character varying(1000) COLLATE pg_catalog."default",
    part_control_info character varying(1000) COLLATE pg_catalog."default",
    nerc_region character varying(7) COLLATE pg_catalog."default",
    nerc_description character varying(1000) COLLATE pg_catalog."default",
    account_type_code character varying(7) COLLATE pg_catalog."default",
    op_status character varying(7) COLLATE pg_catalog."default",
    hg_control_info character varying(1000) COLLATE pg_catalog."default",
    last_update_date timestamp without time zone,
    CONSTRAINT pk_account_fact PRIMARY KEY (account_number, prg_code)
);

COMMENT ON TABLE camddmw.account_fact
    IS 'Warehouse containing account information';

COMMENT ON COLUMN camddmw.account_fact.account_number
    IS 'Account number';

COMMENT ON COLUMN camddmw.account_fact.prg_code
    IS 'Program code';

COMMENT ON COLUMN camddmw.account_fact.account_name
    IS 'Account name';

COMMENT ON COLUMN camddmw.account_fact.account_type
    IS 'Full name for the account type';

COMMENT ON COLUMN camddmw.account_fact.unit_id
    IS 'Unique identifier of a unit';

COMMENT ON COLUMN camddmw.account_fact.unitid
    IS 'Unique identifier for each unit at a facility.';

COMMENT ON COLUMN camddmw.account_fact.op_status_info
    IS 'Unit operating status information for the year';

COMMENT ON COLUMN camddmw.account_fact.primary_fuel_info
    IS 'Primary fuel type information for the year';

COMMENT ON COLUMN camddmw.account_fact.secondary_fuel_info
    IS 'Secondary fuel type information for the year';

COMMENT ON COLUMN camddmw.account_fact.own_display
    IS 'Formatted list of owners/operators';

COMMENT ON COLUMN camddmw.account_fact.unit_type_info
    IS 'Type of unit or boiler';

COMMENT ON COLUMN camddmw.account_fact.prm_display_name
    IS 'Formatted display of alternate representative name';

COMMENT ON COLUMN camddmw.account_fact.prm_display_block
    IS 'Formatted display of primary representative information, including name, affiliation, address, phone and fax number';

COMMENT ON COLUMN camddmw.account_fact.alt_display_name
    IS 'Formatted display of alternate representative name';

COMMENT ON COLUMN camddmw.account_fact.alt_display_block
    IS 'Formatted display of alternate representative information, including name, affiliation, address, phone and fax number';

COMMENT ON COLUMN camddmw.account_fact.epa_region
    IS 'EPA region code';

COMMENT ON COLUMN camddmw.account_fact.epa_region_description
    IS 'EPA region name';

COMMENT ON COLUMN camddmw.account_fact.state
    IS 'State abbreviation for which FACILITY, CONTACT, AGENCY, ACCOUNT REQUEST, PROGRAM, or STAFF is located.';

COMMENT ON COLUMN camddmw.account_fact.state_name
    IS 'Name of the State for which FACILITY, CONTACT, AGENCY, ACCOUNT REQUEST, PROGRAM, or STAFF is located.';

COMMENT ON COLUMN camddmw.account_fact.source_cat
    IS 'Source category of the unit';

COMMENT ON COLUMN camddmw.account_fact.fac_id
    IS 'Unique identifier of a facility';

COMMENT ON COLUMN camddmw.account_fact.facility_name
    IS 'The name given by the owners and operators to a facility';

COMMENT ON COLUMN camddmw.account_fact.orispl_code
    IS 'EIA-assigned identifier or FACILITY ID assigned by CAMD (if EIA number is not applicable)';

COMMENT ON COLUMN camddmw.account_fact.phase1_allocation
    IS 'Number of allowances allocated in Phase 1';

COMMENT ON COLUMN camddmw.account_fact.phase2a_allocation
    IS 'Number of allowances allocated in Phase 2A';

COMMENT ON COLUMN camddmw.account_fact.phase2b_allocation
    IS 'Number of allowances allocated in Phase 2B';

COMMENT ON COLUMN camddmw.account_fact.data_source
    IS 'Source of the data';

COMMENT ON COLUMN camddmw.account_fact.add_date
    IS 'Date on which the record was added';

COMMENT ON COLUMN camddmw.account_fact.userid
    IS 'Initials of user who last modified data';

COMMENT ON COLUMN camddmw.account_fact.so2_control_info
    IS 'Formatted list of all SO2 controls for a unit';

COMMENT ON COLUMN camddmw.account_fact.nox_control_info
    IS 'Formatted list of all NOx controls for a unit';

COMMENT ON COLUMN camddmw.account_fact.part_control_info
    IS 'Formatted list of all particulate controls for a unit';

COMMENT ON COLUMN camddmw.account_fact.nerc_region
    IS 'Code for one of thirteen regions as specified by the North American Electric Reliability Council (NERC)';

COMMENT ON COLUMN camddmw.account_fact.nerc_description
    IS 'Full name of one of the thirteen regions in the North American Electric Reliability Council';

COMMENT ON COLUMN camddmw.account_fact.account_type_code
    IS 'Code for the account type';

COMMENT ON COLUMN camddmw.account_fact.op_status
    IS 'Operating status code of unit for a given year';

COMMENT ON COLUMN camddmw.account_fact.hg_control_info
    IS 'Formatted list of all mercury controls for a unit';

COMMENT ON COLUMN camddmw.account_fact.last_update_date
    IS 'Latest add or update date on source records that are used to populate this record';

-- Index: account_fact_idx001

-- DROP INDEX camddmw.account_fact_idx001;

CREATE UNIQUE INDEX account_fact_idx001
    ON camddmw.account_fact USING btree
    (state COLLATE pg_catalog."default" ASC NULLS LAST, account_number COLLATE pg_catalog."default" ASC NULLS LAST, prg_code COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: account_fact_idx002

-- DROP INDEX camddmw.account_fact_idx002;

CREATE INDEX account_fact_idx002
    ON camddmw.account_fact USING btree
    (fac_id ASC NULLS LAST);

-- Index: account_fact_idx003

-- DROP INDEX camddmw.account_fact_idx003;

CREATE INDEX account_fact_idx003
    ON camddmw.account_fact USING btree
    (epa_region ASC NULLS LAST, op_status_info COLLATE pg_catalog."default" ASC NULLS LAST, source_cat COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: account_fact_idx004

-- DROP INDEX camddmw.account_fact_idx004;

CREATE INDEX account_fact_idx004
    ON camddmw.account_fact USING btree
    (nerc_region COLLATE pg_catalog."default" ASC NULLS LAST, op_status_info COLLATE pg_catalog."default" ASC NULLS LAST, source_cat COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: account_fact_idx005

-- DROP INDEX camddmw.account_fact_idx005;

CREATE INDEX account_fact_idx005
    ON camddmw.account_fact USING btree
    (prg_code COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: account_fact_idx_unit

-- DROP INDEX camddmw.account_fact_idx_unit;

CREATE INDEX account_fact_idx_unit
    ON camddmw.account_fact USING btree
    (unit_id ASC NULLS LAST);
