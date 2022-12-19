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
        ON DELETE CASCADE
);