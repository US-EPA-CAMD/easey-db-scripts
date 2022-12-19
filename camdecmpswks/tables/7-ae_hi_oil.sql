-- Table: camdecmpswks.ae_hi_oil

-- DROP TABLE camdecmpswks.ae_hi_oil;

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
    calc_oil_mass numeric(10,1),
    CONSTRAINT pk_ae_hi_oil PRIMARY KEY (ae_hi_oil_id),
    CONSTRAINT fk_ae_hi_oil_ae_correlation_test_run FOREIGN KEY (ae_corr_test_run_id)
        REFERENCES camdecmpswks.ae_correlation_test_run (ae_corr_test_run_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_ae_hi_oil_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmpswks.monitor_system (mon_sys_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_ae_hi_oil_oil_density_uom FOREIGN KEY (oil_density_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_ae_hi_oil_oil_gcv_uom FOREIGN KEY (oil_gcv_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_ae_hi_oil_oil_volume_uom FOREIGN KEY (oil_volume_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);