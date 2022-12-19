-- Table: camdecmpswks.rata

-- DROP TABLE camdecmpswks.rata;

CREATE TABLE IF NOT EXISTS camdecmpswks.rata
(
    rata_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rata_frequency_cd character varying(7) COLLATE pg_catalog."default",
    calc_rata_frequency_cd character varying(7) COLLATE pg_catalog."default",
    relative_accuracy numeric(5,2),
    calc_relative_accuracy numeric(5,2),
    overall_bias_adj_factor numeric(5,3),
    calc_overall_bias_adj_factor numeric(5,3),
    num_load_level numeric(1,0),
    calc_num_load_level numeric(1,0),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_rata PRIMARY KEY (rata_id),
    CONSTRAINT fk_rata_rata_frequency_code FOREIGN KEY (rata_frequency_cd)
        REFERENCES camdecmpsmd.rata_frequency_code (rata_frequency_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_rata_rata_frequency_code_calc FOREIGN KEY (calc_rata_frequency_cd)
        REFERENCES camdecmpsmd.rata_frequency_code (rata_frequency_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_rata_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);