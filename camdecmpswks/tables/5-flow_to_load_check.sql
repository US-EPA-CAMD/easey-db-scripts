-- Table: camdecmpswks.flow_to_load_check

-- DROP TABLE camdecmpswks.flow_to_load_check;

CREATE TABLE camdecmpswks.flow_to_load_check
(
    flow_load_check_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_basis_cd character varying(7) COLLATE pg_catalog."default",
    avg_abs_pct_diff numeric(5,1),
    num_hrs numeric(4,0),
    nhe_fuel numeric(4,0),
    nhe_ramping numeric(4,0),
    nhe_bypass numeric(4,0),
    nhe_pre_rata numeric(4,0),
    nhe_test numeric(4,0),
    nhe_main_bypass numeric(4,0),
    bias_adjusted_ind numeric(38,0),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    op_level_cd character varying(7) COLLATE pg_catalog."default",
    CONSTRAINT pk_flow_to_load_check PRIMARY KEY (flow_load_check_id),
    CONSTRAINT fk_flow_to_load_check_operating_level_code FOREIGN KEY (op_level_cd)
        REFERENCES camdecmpsmd.operating_level_code (op_level_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_flow_to_load_check_test_basis_code FOREIGN KEY (test_basis_cd)
        REFERENCES camdecmpsmd.test_basis_code (test_basis_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_flow_to_load_check_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);