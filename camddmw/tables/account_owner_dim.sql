CREATE TABLE camddmw.account_owner_dim
(
    prg_code character varying(8) COLLATE pg_catalog."default" NOT NULL,
    account_number character varying(12) COLLATE pg_catalog."default" NOT NULL,
    unit_id numeric(12,0),
    own_id numeric(12,0),
    own_type character varying(3) COLLATE pg_catalog."default",
    own_display character varying(65) COLLATE pg_catalog."default",
    data_source character varying(35) COLLATE pg_catalog."default",
    userid character varying(8) COLLATE pg_catalog."default",
    add_date date,
    ppl_id numeric(12,0),
    account_owner_id double precision,
    account_owner_unique_id numeric(38,0) NOT NULL,
    CONSTRAINT account_owner_dim_pk PRIMARY KEY (account_owner_unique_id)
);

COMMENT ON TABLE camddmw.account_owner_dim
    IS 'Current owners of unit or general accounts';

COMMENT ON COLUMN camddmw.account_owner_dim.prg_code
    IS 'Program code';

COMMENT ON COLUMN camddmw.account_owner_dim.account_number
    IS 'Account number';

COMMENT ON COLUMN camddmw.account_owner_dim.unit_id
    IS 'Unique identifier of a unit';

COMMENT ON COLUMN camddmw.account_owner_dim.own_id
    IS 'Unique identifier of an owner in the OWNER table';

COMMENT ON COLUMN camddmw.account_owner_dim.own_type
    IS 'Identifies whether the record is an owner or an operator';

COMMENT ON COLUMN camddmw.account_owner_dim.own_display
    IS 'Formatted list of owners/operators';

COMMENT ON COLUMN camddmw.account_owner_dim.data_source
    IS 'Source of the data';

COMMENT ON COLUMN camddmw.account_owner_dim.userid
    IS 'Initials of user who last modified data';

COMMENT ON COLUMN camddmw.account_owner_dim.add_date
    IS 'Date on which the record was added';

COMMENT ON COLUMN camddmw.account_owner_dim.ppl_id
    IS 'Unique identifier of a record in the PEOPLE table';

COMMENT ON COLUMN camddmw.account_owner_dim.account_owner_id
    IS 'Unique key for the ACCOUNT_OWNER_DIM table';

COMMENT ON COLUMN camddmw.account_owner_dim.account_owner_unique_id
    IS 'Unique key for the ACCOUNT_OWNER_DIM table';