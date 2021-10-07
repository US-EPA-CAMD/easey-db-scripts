CREATE TABLE camddmw.owner_year_dim
(
    own_yr_id numeric(10,0) NOT NULL,
    unit_id numeric(12,0) NOT NULL,
    op_year numeric(4,0) NOT NULL,
    own_id numeric(12,0),
    own_type character varying(3) COLLATE pg_catalog."default" NOT NULL,
    own_display character varying(65) COLLATE pg_catalog."default",
    data_source character varying(35) COLLATE pg_catalog."default",
    userid character varying(8) COLLATE pg_catalog."default",
    add_date date,
    CONSTRAINT pk_owner_year_dim PRIMARY KEY (own_yr_id)
);

COMMENT ON TABLE camddmw.owner_year_dim
    IS 'Owners of units for an operating year at the individual owner level';

COMMENT ON COLUMN camddmw.owner_year_dim.own_yr_id
    IS 'Identity key of OWNER_YEAR_DIM';

COMMENT ON COLUMN camddmw.owner_year_dim.unit_id
    IS 'Unique identifier of a unit';

COMMENT ON COLUMN camddmw.owner_year_dim.op_year
    IS 'Year in which data was collected';

COMMENT ON COLUMN camddmw.owner_year_dim.own_id
    IS 'Unique identifier of an owner in the OWNER table';

COMMENT ON COLUMN camddmw.owner_year_dim.own_type
    IS 'Identifies whether the record is an owner or an operator';

COMMENT ON COLUMN camddmw.owner_year_dim.own_display
    IS 'Formatted list of owners/operators';

COMMENT ON COLUMN camddmw.owner_year_dim.data_source
    IS 'Source of the data';

COMMENT ON COLUMN camddmw.owner_year_dim.userid
    IS 'Initials of user who last modified data';

COMMENT ON COLUMN camddmw.owner_year_dim.add_date
    IS 'Date on which the record was added';
-- Index: owner_year_dim_idx003

-- DROP INDEX camddmw.owner_year_dim_idx003;

CREATE INDEX owner_year_dim_idx003
    ON camddmw.owner_year_dim USING btree
    (own_id ASC NULLS LAST, unit_id ASC NULLS LAST, op_year ASC NULLS LAST, own_type COLLATE pg_catalog."default" ASC NULLS LAST, own_display COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: owner_year_dim_idx1

-- DROP INDEX camddmw.owner_year_dim_idx1;

CREATE INDEX owner_year_dim_idx1
    ON camddmw.owner_year_dim USING btree
    (own_id ASC NULLS LAST, unit_id ASC NULLS LAST, op_year ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: owner_year_dim_idx2

-- DROP INDEX camddmw.owner_year_dim_idx2;

CREATE INDEX owner_year_dim_idx2
    ON camddmw.owner_year_dim USING btree
    (unit_id ASC NULLS LAST, op_year ASC NULLS LAST, own_id ASC NULLS LAST)
    TABLESPACE pg_default;