-- Table: camdecmpswks.ae_hi_gas

-- DROP TABLE camdecmpswks.ae_hi_gas;

CREATE TABLE IF NOT EXISTS camdecmpswks.ae_hi_gas
(
    ae_hi_gas_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    ae_corr_test_run_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    gas_volume numeric(10,1),
    gas_gcv numeric(10,1),
    gas_hi numeric(7,1),
    calc_gas_hi numeric(7,1),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    mon_sys_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_ae_hi_gas PRIMARY KEY (ae_hi_gas_id),
    CONSTRAINT fk_ae_hi_gas_ae_correlation_test_run FOREIGN KEY (ae_corr_test_run_id)
        REFERENCES camdecmpswks.ae_correlation_test_run (ae_corr_test_run_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_ae_hi_gas_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmpswks.monitor_system (mon_sys_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- -- Index: idx_ae_hi_gas_ae_corr_te

-- -- DROP INDEX camdecmpswks.idx_ae_hi_gas_ae_corr_te;

-- CREATE INDEX idx_ae_hi_gas_ae_corr_te
--     ON camdecmpswks.ae_hi_gas USING btree
--     (ae_corr_test_run_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_ae_hi_gas_mon_sys_id

-- -- DROP INDEX camdecmpswks.idx_ae_hi_gas_mon_sys_id;

-- CREATE INDEX idx_ae_hi_gas_mon_sys_id
--     ON camdecmpswks.ae_hi_gas USING btree
--     (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);
