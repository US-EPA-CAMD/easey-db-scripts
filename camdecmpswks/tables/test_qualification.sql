CREATE TABLE IF NOT EXISTS camdecmpswks.test_qualification
(
    test_qualification_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_claim_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    hi_load_pct numeric(5,1),
    mid_load_pct numeric(5,1),
    low_load_pct numeric(5,1),
    begin_date date,
    end_date date,
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);