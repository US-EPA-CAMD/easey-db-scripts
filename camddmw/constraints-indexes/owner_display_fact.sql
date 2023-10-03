-- Table: camddmw.owner_display_fact

-- DROP TABLE camddmw.owner_display_fact;

CREATE TABLE IF NOT EXISTS camddmw.owner_display_fact
(
    unit_id numeric(12,0) NOT NULL,
    op_year numeric(4,0) NOT NULL,
    own_display character varying(1200) COLLATE pg_catalog."default",
    data_source character varying(35) COLLATE pg_catalog."default",
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    opr_display character varying(1200) COLLATE pg_catalog."default",
    last_update_date timestamp without time zone,
    CONSTRAINT pk_owner_display_fact PRIMARY KEY (unit_id, op_year)
);

COMMENT ON TABLE camddmw.owner_display_fact
    IS 'Owners of units for an operating year aggregated by unit and year';

COMMENT ON COLUMN camddmw.owner_display_fact.unit_id
    IS 'Unique identifier of a unit';

COMMENT ON COLUMN camddmw.owner_display_fact.op_year
    IS 'Year in which data was collected';

COMMENT ON COLUMN camddmw.owner_display_fact.own_display
    IS 'Formatted list of owners/operators';

COMMENT ON COLUMN camddmw.owner_display_fact.data_source
    IS 'Source of the data';

COMMENT ON COLUMN camddmw.owner_display_fact.userid
    IS 'Initials of user who last modified data';

COMMENT ON COLUMN camddmw.owner_display_fact.add_date
    IS 'Date on which the record was added';

COMMENT ON COLUMN camddmw.owner_display_fact.opr_display
    IS 'Formatted list of operators';

COMMENT ON COLUMN camddmw.owner_display_fact.last_update_date
    IS 'Latest add or update date on source records that are used to populate this record';
