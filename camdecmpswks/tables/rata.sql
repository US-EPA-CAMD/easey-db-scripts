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
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);