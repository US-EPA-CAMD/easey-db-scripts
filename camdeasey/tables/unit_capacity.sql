CREATE TABLE IF NOT EXISTS camdeasey.unit_capacity
(
    unit_cap_id varchar(45) NOT NULL,
    unit_id numeric(38,0) NOT NULL,
    begin_date timestamp without time zone,
    end_date timestamp without time zone,
    max_hi_capacity numeric(7,1),
    PRIMARY KEY (unit_cap_id)
);
COMMENT ON TABLE camdeasey.unit_capacity
    IS 'Identifies historical unit capacity for a unit id.';
COMMENT ON COLUMN camdeasey.unit_capacity.unit_cap_id
    IS 'Identity key for UNIT_CAPACITY table.';
COMMENT ON COLUMN camdeasey.unit_capacity.unit_id
    IS 'Identity key for UNIT table.';
COMMENT ON COLUMN camdeasey.unit_capacity.begin_date
    IS 'Date on which a relationship or an activity began. ';
COMMENT ON COLUMN camdeasey.unit_capacity.end_date
    IS 'Date on which a relationship or an activity ended.';
COMMENT ON COLUMN camdeasey.unit_capacity.max_hi_capacity
    IS 'The maximum hourly heat input (mmBtu/hr) associated with a UNIT.';