-- Table: camdecmps.ae_correlation_test_sum

-- DROP TABLE camdecmps.ae_correlation_test_sum;

CREATE TABLE IF NOT EXISTS camdecmps.ae_correlation_test_sum
(
    ae_corr_test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mean_ref_value numeric(8,3),
    calc_mean_ref_value numeric(8,3),
    f_factor numeric(10,1),
    avg_hrly_hi_rate numeric(7,1),
    calc_avg_hrly_hi_rate numeric(7,1),
    op_level_num numeric(2,0) NOT NULL,
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_ae_correlation_test_sum PRIMARY KEY (ae_corr_test_sum_id),
    CONSTRAINT fk_test_summary_ae_correlatio FOREIGN KEY (test_sum_id)
        REFERENCES camdecmps.test_summary (test_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmps.ae_correlation_test_sum
    IS 'Test results for each Appendix E test.  Record Type 651.';

COMMENT ON COLUMN camdecmps.ae_correlation_test_sum.ae_corr_test_sum_id
    IS 'Unique identifier of an Appendix E correlation test summary record. ';

COMMENT ON COLUMN camdecmps.ae_correlation_test_sum.test_sum_id
    IS 'Unique identifier of a test summary record. ';

COMMENT ON COLUMN camdecmps.ae_correlation_test_sum.mean_ref_value
    IS 'Arithmetic mean of reference method values at this level. ';

COMMENT ON COLUMN camdecmps.ae_correlation_test_sum.calc_mean_ref_value
    IS 'Arithmetic mean of reference method values at this level. ';

COMMENT ON COLUMN camdecmps.ae_correlation_test_sum.f_factor
    IS 'F-factor used to convert NOx concentrations to emission rates. ';

COMMENT ON COLUMN camdecmps.ae_correlation_test_sum.avg_hrly_hi_rate
    IS 'Average hourly heat input rate at this level. ';

COMMENT ON COLUMN camdecmps.ae_correlation_test_sum.calc_avg_hrly_hi_rate
    IS 'Average hourly heat input rate at this level. ';

COMMENT ON COLUMN camdecmps.ae_correlation_test_sum.op_level_num
    IS 'Operating level for run. ';

COMMENT ON COLUMN camdecmps.ae_correlation_test_sum.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.ae_correlation_test_sum.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.ae_correlation_test_sum.update_date
    IS 'Date and time in which record was last updated. ';

-- Index: idx_ae_corr_test_sum_001

-- DROP INDEX camdecmps.idx_ae_corr_test_sum_001;

CREATE INDEX IF NOT EXISTS idx_ae_corr_test_sum_001
    ON camdecmps.ae_correlation_test_sum USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);