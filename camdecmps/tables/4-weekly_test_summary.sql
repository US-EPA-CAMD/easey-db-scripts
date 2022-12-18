-- Table: camdecmps.weekly_test_summary

-- DROP TABLE IF EXISTS camdecmps.weekly_test_summary;

CREATE TABLE IF NOT EXISTS camdecmps.weekly_test_summary
(
    weekly_test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_sys_id character varying(45) COLLATE pg_catalog."default",
    component_id character varying(45) COLLATE pg_catalog."default",
    test_date date NOT NULL,
    test_hour numeric(2,0) NOT NULL,
    test_min numeric(2,0),
    test_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    test_result_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    span_scale_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    calc_test_result_cd character varying(7) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_weekly_test_summary PRIMARY KEY (weekly_test_sum_id),
    CONSTRAINT fk_wts_component_id FOREIGN KEY (component_id)
        REFERENCES camdecmps.component (component_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_wts_mon_loc_id FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_wts_mon_sys_id FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_wts_rpt_period_id FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_wts_span_scale_cd FOREIGN KEY (span_scale_cd)
        REFERENCES camdecmpsmd.span_scale_code (span_scale_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_wts_test_result_cd FOREIGN KEY (test_result_cd)
        REFERENCES camdecmpsmd.test_result_code (test_result_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_wts_test_type_cd FOREIGN KEY (test_type_cd)
        REFERENCES camdecmpsmd.test_type_code (test_type_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmps.weekly_test_summary
    IS 'Summary of weekly calibration test results and weekly interference check results.';

COMMENT ON COLUMN camdecmps.weekly_test_summary.weekly_test_sum_id
    IS 'Unique identifier of a weekly test summary record. ';

COMMENT ON COLUMN camdecmps.weekly_test_summary.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmps.weekly_test_summary.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmps.weekly_test_summary.mon_sys_id
    IS 'Unique identifier of a monitoring system record. ';

COMMENT ON COLUMN camdecmps.weekly_test_summary.component_id
    IS 'Unique identifier of a monitoring component record. ';

COMMENT ON COLUMN camdecmps.weekly_test_summary.test_date
    IS 'Date of the weekly test. ';

COMMENT ON COLUMN camdecmps.weekly_test_summary.test_hour
    IS 'Hour of the weekly test. ';

COMMENT ON COLUMN camdecmps.weekly_test_summary.test_min
    IS 'Minute of the weekly test. ';

COMMENT ON COLUMN camdecmps.weekly_test_summary.test_type_cd
    IS 'Code used to identify test type. ';

COMMENT ON COLUMN camdecmps.weekly_test_summary.test_result_cd
    IS 'Code used to identify reported test result. ';

COMMENT ON COLUMN camdecmps.weekly_test_summary.span_scale_cd
    IS 'Code used to identify the span scale. ';

COMMENT ON COLUMN camdecmps.weekly_test_summary.calc_test_result_cd
    IS 'Code used to identify reported test result. ';

COMMENT ON COLUMN camdecmps.weekly_test_summary.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.weekly_test_summary.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.weekly_test_summary.update_date
    IS 'Date and time in which record was last updated. ';
-- Index: idx_wts_add_date

-- DROP INDEX IF EXISTS camdecmps.idx_wts_add_date;

CREATE INDEX IF NOT EXISTS IF NOT EXISTS idx_wts_add_date
    ON camdecmps.weekly_test_summary USING btree
    (add_date ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_wts_calc_test

-- DROP INDEX IF EXISTS camdecmps.idx_wts_calc_test;

CREATE INDEX IF NOT EXISTS IF NOT EXISTS idx_wts_calc_test
    ON camdecmps.weekly_test_summary USING btree
    (calc_test_result_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_wts_component

-- DROP INDEX IF EXISTS camdecmps.idx_wts_component;

CREATE INDEX IF NOT EXISTS IF NOT EXISTS idx_wts_component
    ON camdecmps.weekly_test_summary USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_wts_mon_loc_id

-- DROP INDEX IF EXISTS camdecmps.idx_wts_mon_loc_id;

CREATE INDEX IF NOT EXISTS IF NOT EXISTS idx_wts_mon_loc_id
    ON camdecmps.weekly_test_summary USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_wts_span_scale

-- DROP INDEX IF EXISTS camdecmps.idx_wts_span_scale;

CREATE INDEX IF NOT EXISTS IF NOT EXISTS idx_wts_span_scale
    ON camdecmps.weekly_test_summary USING btree
    (span_scale_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_wts_sys

-- DROP INDEX IF EXISTS camdecmps.idx_wts_sys;

CREATE INDEX IF NOT EXISTS IF NOT EXISTS idx_wts_sys
    ON camdecmps.weekly_test_summary USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_wts_test_resul

-- DROP INDEX IF EXISTS camdecmps.idx_wts_test_resul;

CREATE INDEX IF NOT EXISTS IF NOT EXISTS idx_wts_test_resul
    ON camdecmps.weekly_test_summary USING btree
    (test_result_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_wts_test_type

-- DROP INDEX IF EXISTS camdecmps.idx_wts_test_type;

CREATE INDEX IF NOT EXISTS IF NOT EXISTS idx_wts_test_type
    ON camdecmps.weekly_test_summary USING btree
    (test_type_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: weekly_test_summary_idx002

-- DROP INDEX IF EXISTS camdecmps.weekly_test_summary_idx002;

CREATE INDEX IF NOT EXISTS IF NOT EXISTS weekly_test_summary_idx002
    ON camdecmps.weekly_test_summary USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;