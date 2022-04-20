-- Table: camdecmps.linearity_summary

-- DROP TABLE camdecmps.linearity_summary;

CREATE TABLE IF NOT EXISTS camdecmps.linearity_summary
(
    lin_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mean_ref_value numeric(13,3),
    calc_mean_ref_value numeric(13,3),
    mean_measured_value numeric(13,3),
    calc_mean_measured_value numeric(13,3),
    percent_error numeric(5,1),
    calc_percent_error numeric(5,1),
    aps_ind numeric(38,0),
    calc_aps_ind numeric(38,0),
    gas_level_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    userid character varying(8) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_linearity_summary PRIMARY KEY (lin_sum_id),
    CONSTRAINT fk_gas_level_cod_linearity_sum FOREIGN KEY (gas_level_cd)
        REFERENCES camdecmpsmd.gas_level_code (gas_level_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_test_summary_linearity_sum FOREIGN KEY (test_sum_id)
        REFERENCES camdecmps.test_summary (test_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmps.linearity_summary
    IS 'Linearity check data and results summary.  Record Type 602.';

COMMENT ON COLUMN camdecmps.linearity_summary.lin_sum_id
    IS 'Unique identifier of a linearity summary record. ';

COMMENT ON COLUMN camdecmps.linearity_summary.test_sum_id
    IS 'Unique identifier of a test summary record. ';

COMMENT ON COLUMN camdecmps.linearity_summary.mean_ref_value
    IS 'Reported mean of referenced values. ';

COMMENT ON COLUMN camdecmps.linearity_summary.calc_mean_ref_value
    IS 'Reported mean of referenced values. ';

COMMENT ON COLUMN camdecmps.linearity_summary.mean_measured_value
    IS 'Reported mean of measured values. ';

COMMENT ON COLUMN camdecmps.linearity_summary.calc_mean_measured_value
    IS 'Reported mean of measured values. ';

COMMENT ON COLUMN camdecmps.linearity_summary.percent_error
    IS 'Reported percentage of error. ';

COMMENT ON COLUMN camdecmps.linearity_summary.calc_percent_error
    IS 'Reported percentage of error. ';

COMMENT ON COLUMN camdecmps.linearity_summary.aps_ind
    IS 'Used to indicate if the alternative performance specification (APS) is used. ';

COMMENT ON COLUMN camdecmps.linearity_summary.calc_aps_ind
    IS 'Used to indicate if the alternative performance specification (APS) is used. ';

COMMENT ON COLUMN camdecmps.linearity_summary.gas_level_cd
    IS 'Code used to identify calibration gas level. ';

COMMENT ON COLUMN camdecmps.linearity_summary.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.linearity_summary.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.linearity_summary.update_date
    IS 'Date and time in which record was last updated. ';

-- Index: idx_linearity_summa_gas_level

-- DROP INDEX camdecmps.idx_linearity_summa_gas_level;

CREATE INDEX idx_linearity_summa_gas_level
    ON camdecmps.linearity_summary USING btree
    (gas_level_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_linearity_summary_001

-- DROP INDEX camdecmps.idx_linearity_summary_001;

CREATE INDEX idx_linearity_summary_001
    ON camdecmps.linearity_summary USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
