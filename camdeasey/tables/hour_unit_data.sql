CREATE TABLE IF NOT EXISTS camdeasey.hour_unit_data
(
    unit_id numeric(38,0) NOT NULL,
    op_date timestamp without time zone NOT NULL,
    op_hour numeric(2,0) NOT NULL,
    so2_mass numeric(15,3),
    nox_mass numeric(15,3),
    op_year numeric(4,0) NOT NULL,
    PRIMARY KEY (unit_id, op_date, op_hour)
);
COMMENT ON TABLE camdeasey.hour_unit_data
    IS 'Hourly emissions data at the unit level';
COMMENT ON COLUMN camdeasey.hour_unit_data.unit_id
    IS 'Unique identifier of a unit';
COMMENT ON COLUMN camdeasey.hour_unit_data.op_date
    IS 'Date on which the hourly data was collected';
COMMENT ON COLUMN camdeasey.hour_unit_data.op_hour
    IS 'Hour during which data was collected (range is 0 - 23)';
COMMENT ON COLUMN camdeasey.hour_unit_data.so2_mass
    IS 'Mass of SO2 (lbs) emitted by a unit';
COMMENT ON COLUMN camdeasey.hour_unit_data.nox_mass
    IS 'Mass of NOx (lbs) emitted by a unit';
COMMENT ON COLUMN camdeasey.hour_unit_data.op_year
    IS 'Year for which the hourly data was collected';