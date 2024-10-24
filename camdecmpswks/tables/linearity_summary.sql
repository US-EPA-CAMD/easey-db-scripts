CREATE TABLE IF NOT EXISTS camdecmpswks.linearity_summary
(
    lin_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mean_ref_value numeric(13,3),
    calc_mean_ref_value numeric(13,3),
    mean_measured_value numeric(13,3),
    calc_mean_measured_value numeric(13,3),
    percent_error numeric(5,1),
    calc_percent_error numeric(5,1),
    aps_ind numeric(38,0),
    calc_aps_ind numeric(38,0),
    gas_level_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);