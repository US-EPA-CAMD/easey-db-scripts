CREATE TABLE IF NOT EXISTS camdecmpswks.cycle_time_summary
(
    cycle_time_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    total_time numeric(2,0),
    calc_total_time numeric(2,0),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);