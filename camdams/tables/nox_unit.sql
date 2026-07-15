CREATE TABLE IF NOT EXISTS camdams.nox_unit
(
    unit_id numeric(38,0) NOT NULL,
    nox_phase numeric(1,0) NOT NULL DEFAULT 0,
    nox_group numeric(1,0) NOT NULL,
    nox_year numeric(4,0) NOT NULL,
    nox_end_year numeric(4,0),
    nox_standard_limit numeric(6,3) NOT NULL,
    ee_ind numeric(1,0) NOT NULL DEFAULT 0,
    ee_limit numeric(5,2),
    ee_termyear numeric(4,0),
    userid varchar(160) NOT NULL,
    add_date timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone,
    nox_rate_1990 numeric(6,3),
    PRIMARY KEY (unit_id)
);
COMMENT ON TABLE camdams.nox_unit
    IS 'Identifies the unit details for NOX units.';
COMMENT ON COLUMN camdams.nox_unit.unit_id
    IS 'Identity key for UNIT table.';
COMMENT ON COLUMN camdams.nox_unit.nox_phase
    IS 'The timeframe in which a category of NOx emission limits applies to a UNIT based on boiler type. ';
COMMENT ON COLUMN camdams.nox_unit.nox_group
    IS 'The category of NOx emission limit applicable to a UNIT based on boiler type. ';
COMMENT ON COLUMN camdams.nox_unit.nox_year
    IS 'First year in which a UNIT was affected by NOx emission limits under Part 76.';
COMMENT ON COLUMN camdams.nox_unit.nox_end_year
    IS 'Last Year that Unit is subject to ARP NOx.';
COMMENT ON COLUMN camdams.nox_unit.nox_standard_limit
    IS 'The NOx emission limit applicable to a UNIT under Part 76.';
COMMENT ON COLUMN camdams.nox_unit.ee_ind
    IS 'Indicator that a UNIT is an early election unit for Part 76 compliance purposes. ';
COMMENT ON COLUMN camdams.nox_unit.ee_limit
    IS 'Early election limit.';
COMMENT ON COLUMN camdams.nox_unit.ee_termyear
    IS 'The year in which the early election under Part 76 was terminated by CAMD.';
COMMENT ON COLUMN camdams.nox_unit.userid
    IS 'User account or source of data that added or updated record.';
COMMENT ON COLUMN camdams.nox_unit.add_date
    IS 'Date and time in which record was added.';
COMMENT ON COLUMN camdams.nox_unit.update_date
    IS 'Date and time in which record was last updated.';
COMMENT ON COLUMN camdams.nox_unit.nox_rate_1990
    IS 'Unit''s 1990 NOX Rate.';