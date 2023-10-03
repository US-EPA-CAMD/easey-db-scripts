CREATE TABLE IF NOT EXISTS camddmw.transaction_fact
(
    transaction_id numeric(10,0) NOT NULL,
    prg_code character varying(8) COLLATE pg_catalog."default" NOT NULL,
    transaction_date date,
    transaction_type_code character varying(7) COLLATE pg_catalog."default",
    transaction_type character varying(1000) COLLATE pg_catalog."default",
    transaction_total numeric(10,0),
    buy_acct_number character varying(12) COLLATE pg_catalog."default" NOT NULL,
    buy_ppl_id numeric(10,0),
    buy_display_name character varying(100) COLLATE pg_catalog."default",
    buy_display_block character varying(2000) COLLATE pg_catalog."default",
    buy_own_display_name character varying(2000) COLLATE pg_catalog."default",
    buy_source_cat character varying(30) COLLATE pg_catalog."default",
    buy_epa_region numeric(2,0),
    buy_state character(2) COLLATE pg_catalog."default",
    buy_orispl_code numeric(6,0),
    buy_facility_name character varying(40) COLLATE pg_catalog."default",
    sell_acct_number character varying(12) COLLATE pg_catalog."default" NOT NULL,
    sell_ppl_id numeric(10,0),
    sell_epa_region numeric(2,0),
    sell_source_cat character varying(30) COLLATE pg_catalog."default",
    sell_state character(2) COLLATE pg_catalog."default",
    sell_orispl_code numeric(6,0),
    sell_facility_name character varying(40) COLLATE pg_catalog."default",
    sell_display_name character varying(100) COLLATE pg_catalog."default",
    sell_display_block character varying(2000) COLLATE pg_catalog."default",
    sell_own_display_name character varying(2000) COLLATE pg_catalog."default",
    data_source character varying(35) COLLATE pg_catalog."default",
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    buy_fac_id double precision,
    sell_fac_id double precision,
    buy_acct_name character varying(100) COLLATE pg_catalog."default",
    sell_acct_name character varying(100) COLLATE pg_catalog."default",
    buy_full_name character varying(100) COLLATE pg_catalog."default",
    sell_full_name character varying(100) COLLATE pg_catalog."default",
    buy_nerc_region character varying(7) COLLATE pg_catalog."default",
    sell_nerc_region character varying(7) COLLATE pg_catalog."default",
    buy_account_type character varying(35) COLLATE pg_catalog."default",
    sell_account_type character varying(35) COLLATE pg_catalog."default",
    buy_account_type_code character varying(7) COLLATE pg_catalog."default",
    sell_account_type_code character varying(7) COLLATE pg_catalog."default",
    buy_unit_id double precision,
    sell_unit_id double precision,
    last_update_date timestamp without time zone
) PARTITION BY LIST (prg_code);


COMMENT ON TABLE camddmw.transaction_fact
    IS 'Allowance transactions';

COMMENT ON COLUMN camddmw.transaction_fact.transaction_id
    IS 'Unique identifier of a transaction';

COMMENT ON COLUMN camddmw.transaction_fact.prg_code
    IS 'Program code';

COMMENT ON COLUMN camddmw.transaction_fact.transaction_date
    IS 'Date on which transaction took place';

COMMENT ON COLUMN camddmw.transaction_fact.transaction_type_code
    IS 'Code identifying transaction type';

COMMENT ON COLUMN camddmw.transaction_fact.transaction_type
    IS 'Text description of transaction type';

COMMENT ON COLUMN camddmw.transaction_fact.transaction_total
    IS 'Total number of allowances in this transaction';

COMMENT ON COLUMN camddmw.transaction_fact.buy_acct_number
    IS 'Buyer''s account number';

COMMENT ON COLUMN camddmw.transaction_fact.buy_ppl_id
    IS 'Unique identifier of the buying representative';

COMMENT ON COLUMN camddmw.transaction_fact.buy_display_name
    IS 'Formatted display of buying representative name';

COMMENT ON COLUMN camddmw.transaction_fact.buy_display_block
    IS 'Formatted display of buying representative information, including name, affiliation, address, phone and fax number';

COMMENT ON COLUMN camddmw.transaction_fact.buy_own_display_name
    IS 'Formatted display of buying owner name';

COMMENT ON COLUMN camddmw.transaction_fact.buy_source_cat
    IS 'Source category of the buyer if a unit account';

COMMENT ON COLUMN camddmw.transaction_fact.buy_epa_region
    IS 'EPA region of the buying facility';

COMMENT ON COLUMN camddmw.transaction_fact.buy_state
    IS 'State of the buyer';

COMMENT ON COLUMN camddmw.transaction_fact.buy_orispl_code
    IS 'ORISPL Code of the buying facility';

COMMENT ON COLUMN camddmw.transaction_fact.buy_facility_name
    IS 'Name of the buying facility';

COMMENT ON COLUMN camddmw.transaction_fact.sell_acct_number
    IS 'Seller''s account number';

COMMENT ON COLUMN camddmw.transaction_fact.sell_ppl_id
    IS 'Unique identifier of the selling representative';

COMMENT ON COLUMN camddmw.transaction_fact.sell_epa_region
    IS 'EPA region of the selling facility';

COMMENT ON COLUMN camddmw.transaction_fact.sell_source_cat
    IS 'Source category of the seller if a unit account';

COMMENT ON COLUMN camddmw.transaction_fact.sell_state
    IS 'State of the seller';

COMMENT ON COLUMN camddmw.transaction_fact.sell_orispl_code
    IS 'ORISPL Code of the selling facility';

COMMENT ON COLUMN camddmw.transaction_fact.sell_facility_name
    IS 'Name of the selling facility';

COMMENT ON COLUMN camddmw.transaction_fact.sell_display_name
    IS 'Formatted display of selling representative name';

COMMENT ON COLUMN camddmw.transaction_fact.sell_display_block
    IS 'Formatted display of selling representative information, including name, affiliation, address, phone and fax number';

COMMENT ON COLUMN camddmw.transaction_fact.sell_own_display_name
    IS 'Formatted display of selling owner name';

COMMENT ON COLUMN camddmw.transaction_fact.data_source
    IS 'Source of the data';

COMMENT ON COLUMN camddmw.transaction_fact.userid
    IS 'Initials of user who last modified data';

COMMENT ON COLUMN camddmw.transaction_fact.add_date
    IS 'Date on which the record was added';

COMMENT ON COLUMN camddmw.transaction_fact.buy_fac_id
    IS 'Unique identifier of the buying facility';

COMMENT ON COLUMN camddmw.transaction_fact.sell_fac_id
    IS 'Unique identifier of the selling facility';

COMMENT ON COLUMN camddmw.transaction_fact.buy_acct_name
    IS 'Buyer''s account name';

COMMENT ON COLUMN camddmw.transaction_fact.sell_acct_name
    IS 'Seller''s account name';

COMMENT ON COLUMN camddmw.transaction_fact.buy_full_name
    IS 'Formatted display of buying representative name';

COMMENT ON COLUMN camddmw.transaction_fact.sell_full_name
    IS 'Formatted display of selling representative name';

COMMENT ON COLUMN camddmw.transaction_fact.buy_nerc_region
    IS 'NERC region of the buying facility';

COMMENT ON COLUMN camddmw.transaction_fact.sell_nerc_region
    IS 'NERC region of the selling facility';

COMMENT ON COLUMN camddmw.transaction_fact.buy_account_type
    IS 'Buyer''s account type';

COMMENT ON COLUMN camddmw.transaction_fact.sell_account_type
    IS 'Seller''s account type';

COMMENT ON COLUMN camddmw.transaction_fact.buy_account_type_code
    IS 'Buyer''s account type code';

COMMENT ON COLUMN camddmw.transaction_fact.sell_account_type_code
    IS 'Seller''s account type code';

COMMENT ON COLUMN camddmw.transaction_fact.buy_unit_id
    IS 'Unit ID of the buyer if a unit account';

COMMENT ON COLUMN camddmw.transaction_fact.sell_unit_id
    IS 'Unit ID of the seller if a unit account';

COMMENT ON COLUMN camddmw.transaction_fact.last_update_date
    IS 'Latest add or update date on source records that are used to populate this record';

-- Index: transaction_fact_idx002

-- DROP INDEX camddmw.transaction_fact_idx002;

CREATE INDEX IF NOT EXISTS transaction_fact_idx002
    ON camddmw.transaction_fact USING btree
    (transaction_date ASC NULLS LAST, buy_acct_number COLLATE pg_catalog."default" ASC NULLS LAST, sell_acct_number COLLATE pg_catalog."default" ASC NULLS LAST, transaction_id ASC NULLS LAST);

-- Index: transaction_fact_idx003

-- DROP INDEX camddmw.transaction_fact_idx003;

CREATE INDEX IF NOT EXISTS transaction_fact_idx003
    ON camddmw.transaction_fact USING btree
    (transaction_id ASC NULLS LAST, buy_acct_number COLLATE pg_catalog."default" ASC NULLS LAST, sell_acct_number COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: transaction_fact_idx004

-- DROP INDEX camddmw.transaction_fact_idx004;

CREATE INDEX IF NOT EXISTS transaction_fact_idx004
    ON camddmw.transaction_fact USING btree
    (buy_fac_id ASC NULLS LAST, buy_acct_number COLLATE pg_catalog."default" ASC NULLS LAST, buy_source_cat COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: transaction_fact_idx005

-- DROP INDEX camddmw.transaction_fact_idx005;

CREATE INDEX IF NOT EXISTS transaction_fact_idx005
    ON camddmw.transaction_fact USING btree
    (buy_state COLLATE pg_catalog."default" ASC NULLS LAST, buy_source_cat COLLATE pg_catalog."default" ASC NULLS LAST, buy_fac_id ASC NULLS LAST);

-- Partitions SQL

CREATE TABLE IF NOT EXISTS camddmw.transaction_fact_trans_fact_p1 PARTITION OF camddmw.transaction_fact
    FOR VALUES IN ('ARP');

--ALTER TABLE camddmw.transaction_fact_trans_fact_p1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.transaction_fact_trans_fact_p2 PARTITION OF camddmw.transaction_fact
    FOR VALUES IN ('NBP');

--ALTER TABLE camddmw.transaction_fact_trans_fact_p2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.transaction_fact_trans_fact_unknown PARTITION OF camddmw.transaction_fact
    DEFAULT;

--ALTER TABLE camddmw.transaction_fact_trans_fact_unknown
--    OWNER to "uImcwuf4K9dyaxeL";
