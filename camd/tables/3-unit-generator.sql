CREATE TABLE camd.unit_generator
(
    unit_gen_id numeric(38,0) NOT NULL,
    unit_id numeric(38,0) NOT NULL,
    gen_id numeric(38,0) NOT NULL,
    begin_date date NOT NULL,
    end_date date,
    userid character varying(8) COLLATE pg_catalog."default" NOT NULL,
    add_date date NOT NULL DEFAULT aws_oracle_ext.sysdate(),
    update_date date,
    CONSTRAINT pk_unit_generator PRIMARY KEY (unit_gen_id),
    CONSTRAINT uq_unit_generator UNIQUE (unit_id, gen_id, begin_date),
    CONSTRAINT fk_unit_generator_gen_id FOREIGN KEY (gen_id)
        REFERENCES camd.generator (gen_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_unit_generator_unit_id FOREIGN KEY (unit_id)
        REFERENCES camd.unit (unit_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camd.unit_generator
    IS 'Stores the relationship between UNIT and GENERATOR.';

COMMENT ON COLUMN camd.unit_generator.unit_gen_id
    IS 'Identity key for UNIT_GENERATOR table.';

COMMENT ON COLUMN camd.unit_generator.unit_id
    IS 'Identity key for UNIT table.';

COMMENT ON COLUMN camd.unit_generator.gen_id
    IS 'The identifier used to identify a GENERATOR, as reported to EIA and for New Unit Exemption purposes.';

COMMENT ON COLUMN camd.unit_generator.begin_date
    IS 'Date on which a relationship or an activity began.';

COMMENT ON COLUMN camd.unit_generator.end_date
    IS 'Date on which a relationship or an activity ended.';

COMMENT ON COLUMN camd.unit_generator.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty.  Otherwise this is the user name of the person or process that made the last update.';

COMMENT ON COLUMN camd.unit_generator.add_date
    IS 'Date the record was created.';

COMMENT ON COLUMN camd.unit_generator.update_date
    IS 'Date of the last record update.';