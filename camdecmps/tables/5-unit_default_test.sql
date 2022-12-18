-- Table: camdecmps.unit_default_test

-- DROP TABLE camdecmps.unit_default_test;

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
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_unt_default_test PRIMARY KEY (unit_default_test_sum_id),
    CONSTRAINT fk_fuel_code_unt_default_t FOREIGN KEY (fuel_cd)
        REFERENCES camdecmpsmd.fuel_code (fuel_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_operating_con_unt_default_t FOREIGN KEY (operating_condition_cd)
        REFERENCES camdecmpsmd.operating_condition_code (operating_condition_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_test_summary_unt_default_t FOREIGN KEY (test_sum_id)
        REFERENCES camdecmps.test_summary (test_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
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

-- Index: idx_unit_default_te_fuel_cd

-- DROP INDEX camdecmps.idx_unit_default_te_fuel_cd;

CREATE INDEX IF NOT EXISTS idx_unit_default_te_fuel_cd
    ON camdecmps.unit_default_test USING btree
    (fuel_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_unit_default_te_operating

-- DROP INDEX camdecmps.idx_unit_default_te_operating;

CREATE INDEX IF NOT EXISTS idx_unit_default_te_operating
    ON camdecmps.unit_default_test USING btree
    (operating_condition_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_unit_default_test_001

-- DROP INDEX camdecmps.idx_unit_default_test_001;

CREATE INDEX IF NOT EXISTS idx_unit_default_test_001
    ON camdecmps.unit_default_test USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
