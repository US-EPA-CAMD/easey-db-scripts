-- Table: camdecmps.ae_hi_gas

-- DROP TABLE camdecmps.ae_hi_gas;

CREATE TABLE IF NOT EXISTS camdecmps.ae_hi_gas
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
    CONSTRAINT fk_ae_correlatio_ae_hi_gas FOREIGN KEY (ae_corr_test_run_id)
        REFERENCES camdecmps.ae_correlation_test_run (ae_corr_test_run_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_system_ae_hi_gas FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmps.ae_hi_gas
    IS 'Heat input from gas combusted during an Appendix E test.  Record Type 653.';

COMMENT ON COLUMN camdecmps.ae_hi_gas.ae_hi_gas_id
    IS 'Unique identifier of an Appendix E heat input from gas record. ';

COMMENT ON COLUMN camdecmps.ae_hi_gas.ae_corr_test_run_id
    IS 'Unique combination of DB_Token and identity key generated by sequence generator.';

COMMENT ON COLUMN camdecmps.ae_hi_gas.gas_volume
    IS 'Volume of gas combusted during run. ';

COMMENT ON COLUMN camdecmps.ae_hi_gas.gas_gcv
    IS 'Gross calorific value (GCV) of gas. ';

COMMENT ON COLUMN camdecmps.ae_hi_gas.gas_hi
    IS 'Heat input from gas during run. ';

COMMENT ON COLUMN camdecmps.ae_hi_gas.calc_gas_hi
    IS 'Heat input from gas during run. ';

COMMENT ON COLUMN camdecmps.ae_hi_gas.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.ae_hi_gas.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.ae_hi_gas.update_date
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmps.ae_hi_gas.mon_sys_id
    IS 'Unique identifier of a monitoring system record. ';

-- Index: idx_ae_hi_gas_ae_corr_te

-- DROP INDEX camdecmps.idx_ae_hi_gas_ae_corr_te;

CREATE INDEX idx_ae_hi_gas_ae_corr_te
    ON camdecmps.ae_hi_gas USING btree
    (ae_corr_test_run_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_ae_hi_gas_mon_sys_id

-- DROP INDEX camdecmps.idx_ae_hi_gas_mon_sys_id;

CREATE INDEX idx_ae_hi_gas_mon_sys_id
    ON camdecmps.ae_hi_gas USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);
