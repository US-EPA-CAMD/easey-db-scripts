CREATE TABLE IF NOT EXISTS camdecmps.unit_capacity
(
    unit_cap_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    unit_id numeric(38,0) NOT NULL,
    begin_date date,
    end_date date,
    max_hi_capacity numeric(7,1),
    userid character varying(25) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone,
    CONSTRAINT pk_unit_capacity PRIMARY KEY (unit_cap_id),
    CONSTRAINT fk_unit_capacity_unit FOREIGN KEY (unit_id)
        REFERENCES camd.unit (unit_id) MATCH SIMPLE
);

COMMENT ON TABLE camdecmps.unit_capacity
    IS 'Identifies historical unit capacity for a unit id.';

COMMENT ON COLUMN camdecmps.unit_capacity.unit_cap_id
    IS 'Identity key for UNIT_CAPACITY table.';

COMMENT ON COLUMN camdecmps.unit_capacity.unit_id
    IS 'Identity key for UNIT table.';

COMMENT ON COLUMN camdecmps.unit_capacity.begin_date
    IS 'Date on which a relationship or an activity began. ';

COMMENT ON COLUMN camdecmps.unit_capacity.end_date
    IS 'Date on which a relationship or an activity ended.';

COMMENT ON COLUMN camdecmps.unit_capacity.max_hi_capacity
    IS 'The maximum hourly heat input (mmBtu/hr) associated with a UNIT.';

COMMENT ON COLUMN camdecmps.unit_capacity.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty.  Otherwise this is the user name of the person or process that made the last update.';

COMMENT ON COLUMN camdecmps.unit_capacity.add_date
    IS 'Date the record was created.';

COMMENT ON COLUMN camdecmps.unit_capacity.update_date
    IS 'Date of the last record update.';
