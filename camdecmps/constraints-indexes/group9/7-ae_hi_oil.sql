ALTER TABLE IF EXISTS camdecmps.ae_hi_oil
    ADD CONSTRAINT pk_ae_hi_oil PRIMARY KEY (ae_hi_oil_id),
    ADD CONSTRAINT fk_ae_hi_oil_ae_correlation_test_run FOREIGN KEY (ae_corr_test_run_id)
        REFERENCES camdecmps.ae_correlation_test_run (ae_corr_test_run_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_ae_hi_oil_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_ae_hi_oil_oil_density_uom FOREIGN KEY (oil_density_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_ae_hi_oil_oil_gcv_uom FOREIGN KEY (oil_gcv_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_ae_hi_oil_oil_volume_uom FOREIGN KEY (oil_volume_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_ae_hi_oil_ae_corr_test_run_id
    ON camdecmps.ae_hi_oil USING btree
    (ae_corr_test_run_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_ae_hi_oil_mon_sys_id
    ON camdecmps.ae_hi_oil USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_ae_hi_oil_oil_density_uom_cd
    ON camdecmps.ae_hi_oil USING btree
    (oil_density_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_ae_hi_oil_oil_gcv_uom_cd
    ON camdecmps.ae_hi_oil USING btree
    (oil_gcv_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_ae_hi_oil_oil_volume_uom_cd
    ON camdecmps.ae_hi_oil USING btree
    (oil_volume_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);
