CREATE TABLE IF NOT EXISTS camdecmpswks.ae_hi_gas
(
    ae_hi_gas_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    ae_corr_test_run_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    gas_volume numeric(10,1),
    gas_gcv numeric(10,1),
    gas_hi numeric(7,1),
    calc_gas_hi numeric(7,1),
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    mon_sys_id character varying(45) COLLATE pg_catalog."default" NOT NULL
);