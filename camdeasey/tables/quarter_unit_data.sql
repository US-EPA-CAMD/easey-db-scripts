CREATE TABLE IF NOT EXISTS camdeasey.quarter_unit_data
(
    unit_id numeric(12,0) NOT NULL,
    op_year numeric(4,0) NOT NULL,
    op_quarter numeric(1,0) NOT NULL,
    so2_mass numeric(12,3),
    nox_mass numeric(12,3),
    PRIMARY KEY (unit_id, op_year, op_quarter)
);
COMMENT ON TABLE camdeasey.quarter_unit_data
    IS 'Quarterly emissions data at the unit level';
COMMENT ON COLUMN camdeasey.quarter_unit_data.unit_id
    IS 'Unique identifier of a unit';
COMMENT ON COLUMN camdeasey.quarter_unit_data.op_year
    IS 'Year in which data was collected';
COMMENT ON COLUMN camdeasey.quarter_unit_data.op_quarter
    IS 'Quarter in which data was collected';
COMMENT ON COLUMN camdeasey.quarter_unit_data.so2_mass
    IS 'Mass of SO2 (tons) emitted by a unit';
COMMENT ON COLUMN camdeasey.quarter_unit_data.nox_mass
    IS 'Mass of NOx (tons) emitted by a unit';