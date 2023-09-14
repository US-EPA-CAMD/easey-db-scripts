CREATE TABLE IF NOT EXISTS camd.unit_generator
(
    unit_gen_id numeric(38,0) NOT NULL,
    unit_id numeric(38,0) NOT NULL,
    gen_id numeric(38,0) NOT NULL,
    begin_date date NOT NULL,
    end_date date,
    userid character varying(25) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
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
