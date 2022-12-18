-- Table: camd.unit_boiler_type

-- DROP TABLE camd.unit_boiler_type;

CREATE TABLE IF NOT EXISTS camd.unit_boiler_type
(
    unit_boiler_type_id numeric(38,0) NOT NULL,
    unit_id numeric(38,0) NOT NULL,
    unit_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    begin_date date NOT NULL,
    end_date date,
    userid character varying(25) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone,
    CONSTRAINT pk_unit_boiler_type PRIMARY KEY (unit_boiler_type_id),
    CONSTRAINT uq_unit_boiler_type UNIQUE (unit_id, unit_type_cd, begin_date),
    CONSTRAINT fk_unit_boiler_type_unit FOREIGN KEY (unit_id)
        REFERENCES camd.unit (unit_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_unit_boiler_type_unit_type FOREIGN KEY (unit_type_cd)
        REFERENCES camdmd.unit_type_code (unit_type_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camd.unit_boiler_type
    IS 'Identifies historical unit type for a unit id.';

COMMENT ON COLUMN camd.unit_boiler_type.unit_boiler_type_id
    IS 'Identity key for UNIT_BT_TYPE table.';

COMMENT ON COLUMN camd.unit_boiler_type.unit_id
    IS 'Identity key for UNIT table.';

COMMENT ON COLUMN camd.unit_boiler_type.unit_type_cd
    IS 'The type of UNIT or boiler.';

COMMENT ON COLUMN camd.unit_boiler_type.begin_date
    IS 'Date on which a relationship or an activity began. ';

COMMENT ON COLUMN camd.unit_boiler_type.end_date
    IS 'Date on which a relationship or an activity ended.';

COMMENT ON COLUMN camd.unit_boiler_type.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty.  Otherwise this is the user name of the person or process that made the last update.';

COMMENT ON COLUMN camd.unit_boiler_type.add_date
    IS 'Date the record was created.';

COMMENT ON COLUMN camd.unit_boiler_type.update_date
    IS 'Date of the last record update.';

-- Index: idx_unit_boiler_type_unit

-- DROP INDEX camd.idx_unit_boiler_type_unit;

CREATE INDEX IF NOT EXISTS idx_unit_boiler_type_unit
    ON camd.unit_boiler_type USING btree
    (unit_id ASC NULLS LAST);
