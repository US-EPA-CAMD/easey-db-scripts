-- Table: camdecmps.ae_hi_oil

-- DROP TABLE camdecmps.ae_hi_oil;

CREATE TABLE IF NOT EXISTS camdecmps.ae_hi_oil
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
    CONSTRAINT fk_ae_correlatio_ae_hi_oil FOREIGN KEY (ae_corr_test_run_id)
        REFERENCES camdecmps.ae_correlation_test_run (ae_corr_test_run_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_system_ae_hi_oil FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_units_of_meas_ae_hi144 FOREIGN KEY (oil_volume_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_units_of_meas_ae_hi146 FOREIGN KEY (oil_gcv_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_units_of_meas_ae_hi_oil FOREIGN KEY (oil_density_uom_cd)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmps.ae_hi_oil
    IS 'Heat input from oil combusted during an Appendix E test.  Record Type 652.';

COMMENT ON COLUMN camdecmps.ae_hi_oil.ae_hi_oil_id
    IS 'Unique identifier of an Appendix E heat input from oil record. ';

COMMENT ON COLUMN camdecmps.ae_hi_oil.ae_corr_test_run_id
    IS 'Unique combination of DB_Token and identity key generated by sequence generator.';

COMMENT ON COLUMN camdecmps.ae_hi_oil.oil_mass
    IS 'Mass of oil combusted during run. ';

COMMENT ON COLUMN camdecmps.ae_hi_oil.oil_hi
    IS 'Heat input from oil during run. ';

COMMENT ON COLUMN camdecmps.ae_hi_oil.calc_oil_hi
    IS 'Heat input from oil during run. ';

COMMENT ON COLUMN camdecmps.ae_hi_oil.oil_gcv
    IS 'Gross calorific value (GCV) of oil. ';

COMMENT ON COLUMN camdecmps.ae_hi_oil.oil_volume
    IS 'Volume of oil combusted during run. ';

COMMENT ON COLUMN camdecmps.ae_hi_oil.oil_density
    IS 'Density of oil. ';

COMMENT ON COLUMN camdecmps.ae_hi_oil.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.ae_hi_oil.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.ae_hi_oil.update_date
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmps.ae_hi_oil.oil_gcv_uom_cd
    IS 'Code used to identify units of measure for GCV of oil. ';

COMMENT ON COLUMN camdecmps.ae_hi_oil.oil_volume_uom_cd
    IS 'Code used to identify units of measure for volume of oil. ';

COMMENT ON COLUMN camdecmps.ae_hi_oil.oil_density_uom_cd
    IS 'Code used to identify units of measure for density of oil. ';

COMMENT ON COLUMN camdecmps.ae_hi_oil.mon_sys_id
    IS 'Unique identifier of a monitoring system record. ';

COMMENT ON COLUMN camdecmps.ae_hi_oil.calc_oil_mass
    IS 'Calculated mass of oil combusted during run. ';

-- Index: idx_ae_hi_oil_ae_corr_te

-- DROP INDEX camdecmps.idx_ae_hi_oil_ae_corr_te;

CREATE INDEX idx_ae_hi_oil_ae_corr_te
    ON camdecmps.ae_hi_oil USING btree
    (ae_corr_test_run_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_ae_hi_oil_mon_sys_id

-- DROP INDEX camdecmps.idx_ae_hi_oil_mon_sys_id;

CREATE INDEX idx_ae_hi_oil_mon_sys_id
    ON camdecmps.ae_hi_oil USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_ae_hi_oil_oil_densit

-- DROP INDEX camdecmps.idx_ae_hi_oil_oil_densit;

CREATE INDEX idx_ae_hi_oil_oil_densit
    ON camdecmps.ae_hi_oil USING btree
    (oil_density_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_ae_hi_oil_oil_gcv_uo

-- DROP INDEX camdecmps.idx_ae_hi_oil_oil_gcv_uo;

CREATE INDEX idx_ae_hi_oil_oil_gcv_uo
    ON camdecmps.ae_hi_oil USING btree
    (oil_gcv_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_ae_hi_oil_oil_volume

-- DROP INDEX camdecmps.idx_ae_hi_oil_oil_volume;

CREATE INDEX idx_ae_hi_oil_oil_volume
    ON camdecmps.ae_hi_oil USING btree
    (oil_volume_uom_cd COLLATE pg_catalog."default" ASC NULLS LAST);
