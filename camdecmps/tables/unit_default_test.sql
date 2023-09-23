CREATE TABLE IF NOT EXISTS camdecmps.unit_default_test
(
    unit_default_test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    fuel_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    operating_condition_cd character varying(7) COLLATE pg_catalog."default",
    nox_default_rate numeric(6,3),
    calc_nox_default_rate numeric(6,3),
    group_id character varying(10) COLLATE pg_catalog."default",
    num_units_in_group numeric(2,0),
    num_tests_for_group numeric(2,0),
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);

COMMENT ON TABLE camdecmps.unit_default_test
    IS 'Unit default test data and results summary.';

COMMENT ON COLUMN camdecmps.unit_default_test.unit_default_test_sum_id
    IS 'Unique identifier of a unit default test summary record. ';

COMMENT ON COLUMN camdecmps.unit_default_test.test_sum_id
    IS 'Unique identifier of a test summary record. ';

COMMENT ON COLUMN camdecmps.unit_default_test.fuel_cd
    IS 'Code used to identify the type of fuel. ';

COMMENT ON COLUMN camdecmps.unit_default_test.operating_condition_cd
    IS 'Code used to identify the operating condition. ';

COMMENT ON COLUMN camdecmps.unit_default_test.nox_default_rate
    IS 'NOx default rate.  Only applicable for LME Units. ';

COMMENT ON COLUMN camdecmps.unit_default_test.calc_nox_default_rate
    IS 'Recalculated NOx default rate from LME unit specific testing. ';

COMMENT ON COLUMN camdecmps.unit_default_test.group_id
    IS 'For a group of identical units using testing to determine default NOx rate, this ID identifies the group. ';

COMMENT ON COLUMN camdecmps.unit_default_test.num_units_in_group
    IS 'Number of identical units in the group. ';

COMMENT ON COLUMN camdecmps.unit_default_test.num_tests_for_group
    IS 'Number of unit-specific tests conducted for this group of identical units ';

COMMENT ON COLUMN camdecmps.unit_default_test.userid
    IS 'User account or source of data that added or updated record.';

COMMENT ON COLUMN camdecmps.unit_default_test.add_date
    IS 'Date and time in which record was added.';

COMMENT ON COLUMN camdecmps.unit_default_test.update_date
    IS 'Date and time in which record was last updated.';
