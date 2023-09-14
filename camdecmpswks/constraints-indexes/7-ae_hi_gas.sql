ALTER TABLE IF EXISTS camdecmpswks.ae_hi_gas
    ADD CONSTRAINT pk_ae_hi_gas PRIMARY KEY (ae_hi_gas_id),
    ADD CONSTRAINT fk_ae_hi_gas_ae_correlation_test_run FOREIGN KEY (ae_corr_test_run_id)
        REFERENCES camdecmpswks.ae_correlation_test_run (ae_corr_test_run_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_ae_hi_gas_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmpswks.monitor_system (mon_sys_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_ae_hi_gas_ae_corr_test_run_id
    ON camdecmpswks.ae_hi_gas USING btree
    (ae_corr_test_run_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_ae_hi_gas_mon_sys_id
    ON camdecmpswks.ae_hi_gas USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);
