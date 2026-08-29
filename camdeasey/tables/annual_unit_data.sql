CREATE TABLE IF NOT EXISTS camdeasey.annual_unit_data
(
    unit_id numeric(12,0) NOT NULL,
    op_year numeric(4,0) NOT NULL,
    so2_mass numeric(12,3),
    nox_mass numeric(12,3),
    PRIMARY KEY (unit_id, op_year)
);
COMMENT ON TABLE camdeasey.annual_unit_data
    IS 'Annual emissions data at the unit level';
COMMENT ON COLUMN camdeasey.annual_unit_data.unit_id
    IS 'Unique identifier of a unit';
COMMENT ON COLUMN camdeasey.annual_unit_data.op_year
    IS 'Year in which data was collected';
COMMENT ON COLUMN camdeasey.annual_unit_data.so2_mass
    IS 'Mass of SO2 (tons) emitted by a unit';
COMMENT ON COLUMN camdeasey.annual_unit_data.nox_mass
    IS 'Mass of NOx (tons) emitted by a unit';