-- Table: camdecmpswks.flow_to_load_reference

-- DROP TABLE camdecmpswks.flow_to_load_reference;

CREATE TABLE IF NOT EXISTS camdecmpswks.flow_to_load_reference
(
    flow_load_ref_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    op_level_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    avg_ref_method_flow numeric(10,0),
    calc_avg_ref_method_flow numeric(10,0),
    rata_test_num character varying(18) COLLATE pg_catalog."default",
    avg_gross_unit_load numeric(6,0),
    calc_avg_gross_unit_load numeric(6,0),
    ref_flow_load_ratio numeric(6,2),
    calc_ref_flow_load_ratio numeric(6,2),
    avg_hrly_hi_rate numeric(7,1),
    ref_ghr numeric(6,0),
    calc_ref_ghr numeric(6,0),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    calc_sep_ref_ind numeric(38,0),
    CONSTRAINT pk_flow_to_load_reference PRIMARY KEY (flow_load_ref_id),
    CONSTRAINT fk_flow_to_load_reference_operating_level_code FOREIGN KEY (op_level_cd)
        REFERENCES camdecmpsmd.operating_level_code (op_level_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_flow_to_load_reference_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- -- Index: idx_flow_to_load_re_op_level_c

-- -- DROP INDEX camdecmpswks.idx_flow_to_load_re_op_level_c;

-- CREATE INDEX idx_flow_to_load_re_op_level_c
--     ON camdecmpswks.flow_to_load_reference USING btree
--     (op_level_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_flow_to_load_reference_001

-- -- DROP INDEX camdecmpswks.idx_flow_to_load_reference_001;

-- CREATE INDEX idx_flow_to_load_reference_001
--     ON camdecmpswks.flow_to_load_reference USING btree
--     (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
