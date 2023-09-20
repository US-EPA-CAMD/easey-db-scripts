CREATE TABLE IF NOT EXISTS camdecmpswks.ae_hi_oil
(
    ae_hi_oil_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    ae_corr_test_run_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    oil_mass numeric(10,1),
    oil_hi numeric(7,1),
    calc_oil_hi numeric(7,1),
    oil_gcv numeric(10,1),
    oil_volume numeric(10,1),
    oil_density numeric(11,6),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    oil_gcv_uom_cd character varying(7) COLLATE pg_catalog."default",
    oil_volume_uom_cd character varying(7) COLLATE pg_catalog."default",
    oil_density_uom_cd character varying(7) COLLATE pg_catalog."default",
    mon_sys_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    calc_oil_mass numeric(10,1)
);