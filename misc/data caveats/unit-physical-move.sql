-- Table: camd.unit_physical_move

-- DROP TABLE camd.unit_physical_move;

CREATE TABLE IF NOT EXISTS camd.unit_physical_move
(
    unit_id numeric(38,0) NOT NULL,
    new_unit_id numeric(38,0) NOT NULL,
    effective_date timestamp without time zone NOT NULL,
    userid character varying(25) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone,
    CONSTRAINT pk_unit_physical_move PRIMARY KEY (unit_id, effective_date),
    CONSTRAINT fk_unit_physical_move_unit FOREIGN KEY (unit_id)
        REFERENCES camd.unit (unit_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camd.unit_physical_move
    IS 'Records cross-reference of physical Unit ID changes (the unit physically changed on the effective date and will have two records in the UNIT table).';

COMMENT ON COLUMN camd.unit_physical_move.unit_id
    IS 'Identity key for old UNIT_ID in UNIT table.';

COMMENT ON COLUMN camd.unit_physical_move.new_unit_id
    IS 'Identity key for new UNIT_ID in UNIT table.';

COMMENT ON COLUMN camd.unit_physical_move.effective_date
    IS 'Date on which UNIT was physically moved.';

COMMENT ON COLUMN camd.unit_physical_move.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty.  Otherwise this is the user name of the person or process that made the last update.';

COMMENT ON COLUMN camd.unit_physical_move.add_date
    IS 'Date the record was created.';

COMMENT ON COLUMN camd.unit_physical_move.update_date
    IS 'Date of the last record update.';