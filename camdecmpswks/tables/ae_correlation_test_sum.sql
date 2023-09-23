CREATE TABLE IF NOT EXISTS camdecmpswks.ae_correlation_test_sum
(
    ae_corr_test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mean_ref_value numeric(8,3),
    calc_mean_ref_value numeric(8,3),
    f_factor numeric(10,1),
    avg_hrly_hi_rate numeric(7,1),
    calc_avg_hrly_hi_rate numeric(7,1),
    op_level_num numeric(2,0) NOT NULL,
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);