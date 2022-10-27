-- Table: camd.unit_logical_move

-- DROP TABLE camd.unit_logical_move;

CREATE TABLE camd.unit_logical_move
(
    unit_id numeric(38,0) NOT NULL,
    old_fac_id numeric(38,0) NOT NULL,
    old_unitid character varying(6) COLLATE pg_catalog."default" NOT NULL,
    effective_date timestamp without time zone NOT NULL,
    userid character varying(25) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone,
    CONSTRAINT pk_unit_logical_move PRIMARY KEY (unit_id, effective_date),
    CONSTRAINT fk_unit_logical_move_unit FOREIGN KEY (unit_id)
        REFERENCES camd.unit (unit_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camd.unit_logical_move
    IS 'Records cross-reference of logical Unit ID changes.';

COMMENT ON COLUMN camd.unit_logical_move.unit_id
    IS 'Identity key for UNIT table.';

COMMENT ON COLUMN camd.unit_logical_move.old_fac_id
    IS 'The old FAC_ID for the UNIT.';

COMMENT ON COLUMN camd.unit_logical_move.old_unitid
    IS 'The old UNITID for the UNIT.';

COMMENT ON COLUMN camd.unit_logical_move.effective_date
    IS 'Date on which UNIT alias was created.';

COMMENT ON COLUMN camd.unit_logical_move.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty.  Otherwise this is the user name of the person or process that made the last update.';

COMMENT ON COLUMN camd.unit_logical_move.add_date
    IS 'Date the record was created.';

COMMENT ON COLUMN camd.unit_logical_move.update_date
    IS 'Date of the last record update.';