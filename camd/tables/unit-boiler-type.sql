CREATE TABLE IF NOT EXISTS camd.unit_boiler_type
(
    unit_boiler_type_id numeric(38,0) NOT NULL,
    unit_id numeric(38,0) NOT NULL,
    unit_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    begin_date date NOT NULL,
    end_date date,
    userid character varying(160) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
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
