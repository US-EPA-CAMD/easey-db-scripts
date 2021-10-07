CREATE TABLE camddmw.owner_display_fact
(
    unit_id numeric(12,0) NOT NULL,
    op_year numeric(4,0) NOT NULL,
    own_display character varying(1200) COLLATE pg_catalog."default",
    data_source character varying(35) COLLATE pg_catalog."default",
    userid character varying(8) COLLATE pg_catalog."default",
    add_date date,
    opr_display character varying(1200) COLLATE pg_catalog."default",
    CONSTRAINT owner_display_fact_pk PRIMARY KEY (unit_id, op_year)
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
-- Index: own_disp_fact_idx01

-- DROP INDEX camddmw.own_disp_fact_idx01;

CREATE INDEX own_disp_fact_idx01
    ON camddmw.owner_display_fact USING btree
    (unit_id ASC NULLS LAST, own_display COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: own_disp_fact_idx02

-- DROP INDEX camddmw.own_disp_fact_idx02;

CREATE INDEX own_disp_fact_idx02
    ON camddmw.owner_display_fact USING btree
    (unit_id ASC NULLS LAST)
    TABLESPACE pg_default;