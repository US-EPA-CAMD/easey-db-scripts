CREATE TABLE camd.unit_exemption
(
    unit_exempt_id numeric(38,0) NOT NULL,
    unit_id numeric(38,0) NOT NULL,
    exemption_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    begin_date date NOT NULL,
    end_date date,
    ex_rec_date date,
    submitter_ppl_id numeric(38,0),
    userid character varying(8) COLLATE pg_catalog."default" NOT NULL,
    add_date date NOT NULL,
    update_date date,
    CONSTRAINT pk_unit_exemption PRIMARY KEY (unit_exempt_id),
    CONSTRAINT uq_unit_exemption UNIQUE (unit_id, begin_date),
    CONSTRAINT fk_unit_exemption_code FOREIGN KEY (exemption_type_cd)
        REFERENCES camdmd.exemption_type_code (exemption_type_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_unit_exemption_unit FOREIGN KEY (unit_id)
        REFERENCES camd.unit (unit_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camd.unit_exemption
    IS 'Used to track exemptions linked to a unit-program.';

COMMENT ON COLUMN camd.unit_exemption.unit_exempt_id
    IS 'Identity key for UNIT_EXEMPTION table.';

COMMENT ON COLUMN camd.unit_exemption.unit_id
    IS 'Identity key for UNIT table.';

COMMENT ON COLUMN camd.unit_exemption.exemption_type_cd
    IS 'Exemption type.';

COMMENT ON COLUMN camd.unit_exemption.begin_date
    IS 'Date on which a relationship or an activity began.';

COMMENT ON COLUMN camd.unit_exemption.end_date
    IS 'Date on which a relationship or an activity ended.';

COMMENT ON COLUMN camd.unit_exemption.ex_rec_date
    IS 'Date on which exemption form was received.';

COMMENT ON COLUMN camd.unit_exemption.submitter_ppl_id
    IS 'PEOPLE identity key of the person who submitted the unit program exemption record.';

COMMENT ON COLUMN camd.unit_exemption.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty.  Otherwise this is the user name of the person or process that made the last update.';

COMMENT ON COLUMN camd.unit_exemption.add_date
    IS 'Date the record was created.';

COMMENT ON COLUMN camd.unit_exemption.update_date
    IS 'Date of the last record update.';
-- Index: idx_unit_exemption_code

-- DROP INDEX camd.idx_unit_exemption_code;

CREATE INDEX idx_unit_exemption_code
    ON camd.unit_exemption USING btree
    (exemption_type_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_unit_exemption_submit

-- DROP INDEX camd.idx_unit_exemption_submit;

CREATE INDEX idx_unit_exemption_submit
    ON camd.unit_exemption USING btree
    (submitter_ppl_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_unit_exemption_unit

-- DROP INDEX camd.idx_unit_exemption_unit;

CREATE INDEX idx_unit_exemption_unit
    ON camd.unit_exemption USING btree
    (unit_id ASC NULLS LAST)
    TABLESPACE pg_default;