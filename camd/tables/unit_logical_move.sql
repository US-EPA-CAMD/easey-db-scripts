CREATE TABLE IF NOT EXISTS camd.unit_logical_move
(
    unit_id numeric(38,0) NOT NULL,
    old_fac_id numeric(38,0) NOT NULL,
    old_unitid varchar(6) NOT NULL,
    effective_date timestamp without time zone NOT NULL,
    userid varchar(160) NOT NULL,
    add_date timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone,
    PRIMARY KEY (unit_id, effective_date)
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