CREATE TABLE IF NOT EXISTS camddmw.transaction_block_dim
(
    transaction_block_id numeric(10,0) NOT NULL,
    transaction_id numeric(10,0) NOT NULL,
    start_block numeric(10,0) DEFAULT NULL::numeric,
    end_block numeric(10,0) DEFAULT NULL::numeric,
    originating_acct_number character varying(12) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    originating_party character varying(35) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    total_block numeric(10,0) DEFAULT NULL::numeric,
    vintage_year numeric(4,0) DEFAULT NULL::numeric,
    data_source character varying(35) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    userid character varying(160) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    add_date timestamp without time zone,
    prg_code character varying(8) COLLATE pg_catalog."default" NOT NULL,
    block_prg_code character varying(8) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    allowance_type character varying(35) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    allowance_type_code character varying(3) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    last_update_date timestamp without time zone
) PARTITION BY LIST (prg_code);


COMMENT ON TABLE camddmw.transaction_block_dim
    IS 'Allowance transactions broken down by allowance block';

COMMENT ON COLUMN camddmw.transaction_block_dim.transaction_block_id
    IS 'Unique identifier of a transaction block';

COMMENT ON COLUMN camddmw.transaction_block_dim.transaction_id
    IS 'Unique identifier of a transaction';

COMMENT ON COLUMN camddmw.transaction_block_dim.start_block
    IS 'Beginning serial number for block of allowances';

COMMENT ON COLUMN camddmw.transaction_block_dim.end_block
    IS 'Ending serial number for block of allowances';

COMMENT ON COLUMN camddmw.transaction_block_dim.originating_acct_number
    IS 'Account to which this allowance was first issued';

COMMENT ON COLUMN camddmw.transaction_block_dim.originating_party
    IS 'Name of owner or state to which allowance was first issued';

COMMENT ON COLUMN camddmw.transaction_block_dim.total_block
    IS 'Number of allowances in the block';

COMMENT ON COLUMN camddmw.transaction_block_dim.vintage_year
    IS 'Year in which allowance was issued';

COMMENT ON COLUMN camddmw.transaction_block_dim.data_source
    IS 'Source of the data';

COMMENT ON COLUMN camddmw.transaction_block_dim.userid
    IS 'Initials of user who last modified data';

COMMENT ON COLUMN camddmw.transaction_block_dim.add_date
    IS 'Date on which the record was added';

COMMENT ON COLUMN camddmw.transaction_block_dim.prg_code
    IS 'Program code';

COMMENT ON COLUMN camddmw.transaction_block_dim.block_prg_code
    IS 'Program code of the allowance block involved in the transaction';

COMMENT ON COLUMN camddmw.transaction_block_dim.allowance_type
    IS 'Type of allowance.  This field only indicates ERC (Early Reduction Credits) allowance types.  All other allowance type values that are stored in ATS/NATS are recorded as nulls in the data mart.';

COMMENT ON COLUMN camddmw.transaction_block_dim.allowance_type_code
    IS 'Code for type of allowance.  The warehouse only contains ERC (Early Reduction Credits) allowance types.  All other allowance type values that are stored in ATS/NATS are recorded as nulls in the data mart.';

COMMENT ON COLUMN camddmw.transaction_block_dim.last_update_date
    IS 'Latest add or update date on source records that are used to populate this record';

-- Index: transaction_block_dim_idx001

-- DROP INDEX camddmw.transaction_block_dim_idx001;

CREATE INDEX IF NOT EXISTS transaction_block_dim_idx001
    ON camddmw.transaction_block_dim USING btree
    (transaction_id ASC NULLS LAST, vintage_year ASC NULLS LAST, start_block ASC NULLS LAST, end_block ASC NULLS LAST, prg_code COLLATE pg_catalog."default" ASC NULLS LAST);

-- Partitions SQL

CREATE TABLE IF NOT EXISTS camddmw.transaction_block_dim_trans_blk_dim_p1 PARTITION OF camddmw.transaction_block_dim
    FOR VALUES IN ('ARP');

--ALTER TABLE camddmw.transaction_block_dim_trans_blk_dim_p1
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.transaction_block_dim_trans_blk_dim_p2 PARTITION OF camddmw.transaction_block_dim
    FOR VALUES IN ('NBP');

--ALTER TABLE camddmw.transaction_block_dim_trans_blk_dim_p2
--    OWNER to "uImcwuf4K9dyaxeL";

CREATE TABLE IF NOT EXISTS camddmw.transaction_block_dim_trans_blk_dim_unknown PARTITION OF camddmw.transaction_block_dim
    DEFAULT;

--ALTER TABLE camddmw.transaction_block_dim_trans_blk_dim_unknown
--    OWNER to "uImcwuf4K9dyaxeL";
