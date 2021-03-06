-- Table: camdecmpswks.unit_default_test

-- DROP TABLE camdecmpswks.unit_default_test;

CREATE TABLE IF NOT EXISTS camdecmpswks.unit_default_test
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
    CONSTRAINT fk_unt_default_test_fuel_code FOREIGN KEY (fuel_cd)
        REFERENCES camdecmpsmd.fuel_code (fuel_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_unt_default_test_operating_condition_code FOREIGN KEY (operating_condition_cd)
        REFERENCES camdecmpsmd.operating_condition_code (operating_condition_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_unt_default_test_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- -- Index: idx_unit_default_te_fuel_cd

-- -- DROP INDEX camdecmpswks.idx_unit_default_te_fuel_cd;

-- CREATE INDEX idx_unit_default_te_fuel_cd
--     ON camdecmpswks.unit_default_test USING btree
--     (fuel_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_unit_default_te_operating

-- -- DROP INDEX camdecmpswks.idx_unit_default_te_operating;

-- CREATE INDEX idx_unit_default_te_operating
--     ON camdecmpswks.unit_default_test USING btree
--     (operating_condition_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_unit_default_test_001

-- -- DROP INDEX camdecmpswks.idx_unit_default_test_001;

-- CREATE INDEX idx_unit_default_test_001
--     ON camdecmpswks.unit_default_test USING btree
--     (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
