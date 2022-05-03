-- Table: camdecmpswks.fuel_flow_to_load_check

-- DROP TABLE camdecmpswks.fuel_flow_to_load_check;

CREATE TABLE IF NOT EXISTS camdecmpswks.fuel_flow_to_load_check
(
    fuel_flow_load_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_basis_cd character varying(7) COLLATE pg_catalog."default",
    avg_diff numeric(5,1),
    num_hrs numeric(4,0),
    nhe_cofiring numeric(4,0),
    nhe_ramping numeric(4,0),
    nhe_low_range numeric(4,0),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_fuel_flow_to_load_check PRIMARY KEY (fuel_flow_load_id),
    CONSTRAINT fk_fuel_flow_to_load_check_test_basis_code FOREIGN KEY (test_basis_cd)
        REFERENCES camdecmpsmd.test_basis_code (test_basis_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_fuel_flow_to_load_check_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- -- Index: idx_ffload_check_001

-- -- DROP INDEX camdecmpswks.idx_ffload_check_001;

-- CREATE INDEX idx_ffload_check_001
--     ON camdecmpswks.fuel_flow_to_load_check USING btree
--     (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_fuel_flow_to_lo_test_basis

-- -- DROP INDEX camdecmpswks.idx_fuel_flow_to_lo_test_basis;

-- CREATE INDEX idx_fuel_flow_to_lo_test_basis
--     ON camdecmpswks.fuel_flow_to_load_check USING btree
--     (test_basis_cd COLLATE pg_catalog."default" ASC NULLS LAST);
