-- Table: camd.unit_alias

-- DROP TABLE camd.unit_alias;

CREATE TABLE IF NOT EXISTS camd.unit_alias
(
    unit_alias_id numeric(38,0) NOT NULL,
    unit_id numeric(38,0) NOT NULL,
    old_unitid character varying(6) COLLATE pg_catalog."default" NOT NULL,
    alias_date timestamp without time zone NOT NULL,
    userid character varying(160) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL,
    CONSTRAINT pk_unit_alias PRIMARY KEY (unit_alias_id),
    CONSTRAINT uq_unit_date UNIQUE (unit_id, alias_date),
    CONSTRAINT fk_unit_alias_unit FOREIGN KEY (unit_id)
        REFERENCES camd.unit (unit_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camd.unit_alias
    IS 'Records cross-reference of Unit ID changes.';

COMMENT ON COLUMN camd.unit_alias.unit_alias_id
    IS 'Identity key for UNIT_ALIAS table.';

COMMENT ON COLUMN camd.unit_alias.unit_id
    IS 'Identity key for UNIT table.';

COMMENT ON COLUMN camd.unit_alias.old_unitid
    IS 'The old UNITID for the UNIT.';

COMMENT ON COLUMN camd.unit_alias.alias_date
    IS 'Date on which UNIT alias was created.';

COMMENT ON COLUMN camd.unit_alias.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty.  Otherwise this is the user name of the person or process that made the last update.';

COMMENT ON COLUMN camd.unit_alias.add_date
    IS 'Date the record was created.';
-- Index: idx_unit_alias_unit

-- DROP INDEX camd.idx_unit_alias_unit;

CREATE INDEX IF NOT EXISTS idx_unit_alias_unit
    ON camd.unit_alias USING btree
    (unit_id ASC NULLS LAST);