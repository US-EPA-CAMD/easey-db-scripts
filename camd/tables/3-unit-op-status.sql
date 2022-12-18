-- Table: camd.unit_op_status

-- DROP TABLE camd.unit_op_status;

CREATE TABLE IF NOT EXISTS camd.unit_op_status
(
    unit_op_status_id numeric(38,0) NOT NULL,
    unit_id numeric(38,0) NOT NULL,
    op_status_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    begin_date date NOT NULL,
    end_date date,
    userid character varying(25) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone,
    CONSTRAINT pk_unit_op_status PRIMARY KEY (unit_op_status_id),
    CONSTRAINT uq_unit_op_status UNIQUE (unit_id, op_status_cd, begin_date),
    CONSTRAINT fk_unit_op_status_code FOREIGN KEY (op_status_cd)
        REFERENCES camdmd.operating_status_code (op_status_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_unit_op_status_unit FOREIGN KEY (unit_id)
        REFERENCES camd.unit (unit_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camd.unit_op_status
    IS 'Used to track operating status for a unit.';

COMMENT ON COLUMN camd.unit_op_status.unit_op_status_id
    IS 'Identity key for UNIT_OP_STATUS table.';

COMMENT ON COLUMN camd.unit_op_status.unit_id
    IS 'Identity key for UNIT table.';

COMMENT ON COLUMN camd.unit_op_status.op_status_cd
    IS 'Operating status for a unit.';

COMMENT ON COLUMN camd.unit_op_status.begin_date
    IS 'Date on which a relationship or an activity began.';

COMMENT ON COLUMN camd.unit_op_status.end_date
    IS 'Date on which a relationship or an activity ended.';

COMMENT ON COLUMN camd.unit_op_status.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty. Otherwise this is the user name of the person or process that made the last update.';

COMMENT ON COLUMN camd.unit_op_status.add_date
    IS 'Date the record was created.';

COMMENT ON COLUMN camd.unit_op_status.update_date
    IS 'Date of the last record update.';

-- Index: idx_unit_op_status_code

-- DROP INDEX camd.idx_unit_op_status_code;

CREATE INDEX IF NOT EXISTS idx_unit_op_status_code
    ON camd.unit_op_status USING btree
    (op_status_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_unit_op_status_unit

-- DROP INDEX camd.idx_unit_op_status_unit;

CREATE INDEX IF NOT EXISTS idx_unit_op_status_unit
    ON camd.unit_op_status USING btree
    (unit_id ASC NULLS LAST);
