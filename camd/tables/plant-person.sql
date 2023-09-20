CREATE TABLE IF NOT EXISTS camd.plant_person
(
    fac_ppl_id numeric(38,0) NOT NULL,
    fac_id numeric(38,0),
    ppl_id numeric(38,0) NOT NULL,
    responsibility_id character varying(7) COLLATE pg_catalog."default" NOT NULL,
    prg_cd character varying(7) COLLATE pg_catalog."default",
    begin_date date NOT NULL,
    end_date date,
    cert_date date,
    userid character varying(8) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
);

COMMENT ON TABLE camd.plant_person
    IS 'Links facilities to people (representatives, contacts, staff).';

COMMENT ON COLUMN camd.plant_person.fac_ppl_id
    IS 'FACILITY and PEOPLE relationship identity key.';

COMMENT ON COLUMN camd.plant_person.fac_id
    IS 'Identity key for FACILITY table.';

COMMENT ON COLUMN camd.plant_person.ppl_id
    IS 'PEOPLE identity key.';

COMMENT ON COLUMN camd.plant_person.responsibility_id
    IS 'Responsibility key.';

COMMENT ON COLUMN camd.plant_person.prg_cd
    IS 'Code used to identify regulatory PROGRAM applicable to UNIT.';

COMMENT ON COLUMN camd.plant_person.begin_date
    IS 'Date on which a relationship or an activity began. ';

COMMENT ON COLUMN camd.plant_person.end_date
    IS 'Date on which a relationship or an activity ended.';

COMMENT ON COLUMN camd.plant_person.cert_date
    IS 'Date the MATS RO was certified for the facility.';

COMMENT ON COLUMN camd.plant_person.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty. Otherwise this is the user name of the person or process that made the last update.';

COMMENT ON COLUMN camd.plant_person.add_date
    IS 'Date the record was created.';

COMMENT ON COLUMN camd.plant_person.update_date
    IS 'Date of the last record update.';
