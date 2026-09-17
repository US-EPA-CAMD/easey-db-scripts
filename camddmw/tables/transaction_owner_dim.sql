CREATE TABLE IF NOT EXISTS camddmw.transaction_owner_dim
(
    transaction_id double precision,
    prg_code character varying(8) COLLATE pg_catalog."default",
    account_number character varying(12) COLLATE pg_catalog."default",
    account_owner_id double precision,
    own_type character varying(3) COLLATE pg_catalog."default",
    own_display character varying(100) COLLATE pg_catalog."default",
    data_source character varying(35) COLLATE pg_catalog."default",
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    ppl_id double precision,
    own_id double precision,
    buy_or_sell character varying(4) COLLATE pg_catalog."default",
    transaction_owner_unique_id numeric(38,0) NOT NULL,
    last_update_date timestamp without time zone
);

COMMENT ON TABLE camddmw.transaction_owner_dim
    IS 'Owners of the unit or general accounts involved in allowance transactions';

COMMENT ON COLUMN camddmw.transaction_owner_dim.transaction_id
    IS 'Unique identifier of a transaction';

COMMENT ON COLUMN camddmw.transaction_owner_dim.prg_code
    IS 'Program code';

COMMENT ON COLUMN camddmw.transaction_owner_dim.account_number
    IS 'Account number';

COMMENT ON COLUMN camddmw.transaction_owner_dim.account_owner_id
    IS 'Unique key for the ACCOUNT_OWNER_DIM table';

COMMENT ON COLUMN camddmw.transaction_owner_dim.own_type
    IS 'Identifies whether the record is an owner or an operator';

COMMENT ON COLUMN camddmw.transaction_owner_dim.own_display
    IS 'Formatted list of owners/operators';

COMMENT ON COLUMN camddmw.transaction_owner_dim.data_source
    IS 'Source of the data';

COMMENT ON COLUMN camddmw.transaction_owner_dim.userid
    IS 'Initials of user who last modified data';

COMMENT ON COLUMN camddmw.transaction_owner_dim.add_date
    IS 'Date on which the record was added';

COMMENT ON COLUMN camddmw.transaction_owner_dim.ppl_id
    IS 'Unique identifier of a record in the PEOPLE table';

COMMENT ON COLUMN camddmw.transaction_owner_dim.own_id
    IS 'Unique identifier of an owner in the OWNER table';

COMMENT ON COLUMN camddmw.transaction_owner_dim.buy_or_sell
    IS 'Identifies the owner as either the buyer or seller in the transaction';

COMMENT ON COLUMN camddmw.transaction_owner_dim.transaction_owner_unique_id
    IS 'Unique identifier of a record in the TRANSACTION_OWNER table';

COMMENT ON COLUMN camddmw.transaction_owner_dim.last_update_date
    IS 'Latest add or update date on source records that are used to populate this record';
