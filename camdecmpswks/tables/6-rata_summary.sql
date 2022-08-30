-- Table: camdecmpswks.rata_summary

-- DROP TABLE camdecmpswks.rata_summary;

CREATE TABLE camdecmpswks.rata_summary
(
    rata_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rata_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    relative_accuracy numeric(5,2),
    calc_relative_accuracy numeric(5,2),
    bias_adj_factor numeric(5,3),
    calc_bias_adj_factor numeric(5,3),
    mean_cem_value numeric(15,5),
    calc_mean_cem_value numeric(15,5),
    mean_rata_ref_value numeric(15,5),
    calc_mean_rata_ref_value numeric(15,5),
    op_level_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    mean_diff numeric(15,5),
    calc_mean_diff numeric(15,5),
    default_waf numeric(6,4),
    avg_gross_unit_load numeric(6,0),
    calc_avg_gross_unit_load numeric(6,0),
    aps_ind numeric(38,0),
    calc_aps_ind numeric(38,0),
    stnd_dev_diff numeric(15,5),
    calc_stnd_dev_diff numeric(15,5),
    confidence_coef numeric(15,5),
    calc_confidence_coef numeric(15,5),
    co2_o2_ref_method_cd character varying(7) COLLATE pg_catalog."default",
    ref_method_cd character varying(7) COLLATE pg_catalog."default",
    t_value numeric(6,3),
    calc_t_value numeric(6,3),
    stack_diameter numeric(5,2),
    stack_area numeric(6,1),
    calc_stack_area numeric(6,1),
    calc_waf numeric(6,4),
    calc_calc_waf numeric(6,4),
    num_traverse_point numeric(2,0),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    aps_cd character varying(7) COLLATE pg_catalog."default",
    CONSTRAINT pk_rata_summary PRIMARY KEY (rata_sum_id),
    CONSTRAINT fk_rata_summary_aps_code FOREIGN KEY (aps_cd)
        REFERENCES camdecmpsmd.aps_code (aps_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_rata_summary_operating_level_code FOREIGN KEY (op_level_cd)
        REFERENCES camdecmpsmd.operating_level_code (op_level_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_rata_summary_rata FOREIGN KEY (rata_id)
        REFERENCES camdecmpswks.rata (rata_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_rata_summary_ref_method_code FOREIGN KEY (ref_method_cd)
        REFERENCES camdecmpsmd.ref_method_code (ref_method_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_rata_summary_ref_method_code_co2o2 FOREIGN KEY (co2_o2_ref_method_cd)
        REFERENCES camdecmpsmd.ref_method_code (ref_method_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);