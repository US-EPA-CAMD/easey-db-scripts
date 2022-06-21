-- Table: camdecmpswks.test_summary

-- DROP TABLE camdecmpswks.test_summary;

CREATE TABLE IF NOT EXISTS camdecmpswks.test_summary
(
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_sys_id character varying(45) COLLATE pg_catalog."default",
    component_id character varying(45) COLLATE pg_catalog."default",
    test_num character varying(18) COLLATE pg_catalog."default" NOT NULL,
    gp_ind numeric(38,0),
    calc_gp_ind numeric(38,0),
    test_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    test_reason_cd character varying(7) COLLATE pg_catalog."default",
    test_result_cd character varying(7) COLLATE pg_catalog."default",
    calc_test_result_cd character varying(7) COLLATE pg_catalog."default",
    rpt_period_id numeric(38,0),
    test_description character varying(100) COLLATE pg_catalog."default",
    begin_date date,
    begin_hour numeric(2,0),
    begin_min numeric(2,0),
    end_date date,
    end_hour numeric(2,0),
    end_min numeric(2,0),
    calc_span_value numeric(13,3),
    test_comment character varying(1000) COLLATE pg_catalog."default",
    last_updated date,
    updated_status_flg character varying(1) COLLATE pg_catalog."default",
    needs_eval_flg character varying(1) COLLATE pg_catalog."default",
    chk_session_id character varying(45) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    span_scale_cd character varying(7) COLLATE pg_catalog."default",
    injection_protocol_cd character varying(7) COLLATE pg_catalog."default",
    eval_status_cd character varying(7) COLLATE pg_catalog."default" NOT NULL DEFAULT 'EVAL'::character varying,
    CONSTRAINT pk_test_summary PRIMARY KEY (test_sum_id),
    CONSTRAINT uq_test_summary UNIQUE (mon_loc_id, test_num, test_type_cd),
    CONSTRAINT fk_test_summary_component FOREIGN KEY (component_id)
        REFERENCES camdecmpswks.component (component_id) MATCH SIMPLE,
    CONSTRAINT fk_test_summary_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE,
    CONSTRAINT fk_test_summary_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmpswks.monitor_system (mon_sys_id) MATCH SIMPLE,
    CONSTRAINT fk_test_summary_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    CONSTRAINT fk_test_summary_span_scale_code FOREIGN KEY (span_scale_cd)
        REFERENCES camdecmpsmd.span_scale_code (span_scale_cd) MATCH SIMPLE,
    CONSTRAINT fk_test_summary_test_reason_code FOREIGN KEY (test_reason_cd)
        REFERENCES camdecmpsmd.test_reason_code (test_reason_cd) MATCH SIMPLE,
    CONSTRAINT fk_test_summary_test_result_code FOREIGN KEY (test_result_cd)
        REFERENCES camdecmpsmd.test_result_code (test_result_cd) MATCH SIMPLE,
    CONSTRAINT fk_test_summary_test_result_code_calc FOREIGN KEY (calc_test_result_cd)
        REFERENCES camdecmpsmd.test_result_code (test_result_cd) MATCH SIMPLE,
    CONSTRAINT fk_test_summary_injection_protocol_code FOREIGN KEY (injection_protocol_cd)
        REFERENCES camdecmpsmd.injection_protocol_code (injection_protocol_cd) MATCH SIMPLE,
    CONSTRAINT fk_test_summary_test_type_code FOREIGN KEY (test_type_cd)
        REFERENCES camdecmpsmd.test_type_code (test_type_cd) MATCH SIMPLE,
    CONSTRAINT fk_test_summary_eval_status_code FOREIGN KEY (eval_status_cd)
        REFERENCES camdecmpsmd.eval_status_code (eval_status_cd) MATCH SIMPLE
);

-- -- Index: idx_test_summary_calc_test

-- -- DROP INDEX camdecmpswks.idx_test_summary_calc_test;

-- CREATE INDEX idx_test_summary_calc_test
--     ON camdecmpswks.test_summary USING btree
--     (calc_test_result_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_test_summary_chk_sessio

-- -- DROP INDEX camdecmpswks.idx_test_summary_chk_sessio;

-- CREATE INDEX idx_test_summary_chk_sessio
--     ON camdecmpswks.test_summary USING btree
--     (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_test_summary_component

-- -- DROP INDEX camdecmpswks.idx_test_summary_component;

-- CREATE INDEX idx_test_summary_component
--     ON camdecmpswks.test_summary USING btree
--     (component_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_test_summary_mon_loc_id

-- -- DROP INDEX camdecmpswks.idx_test_summary_mon_loc_id;

-- CREATE INDEX idx_test_summary_mon_loc_id
--     ON camdecmpswks.test_summary USING btree
--     (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_test_summary_mon_sys_id

-- -- DROP INDEX camdecmpswks.idx_test_summary_mon_sys_id;

-- CREATE INDEX idx_test_summary_mon_sys_id
--     ON camdecmpswks.test_summary USING btree
--     (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_test_summary_rpt_period

-- -- DROP INDEX camdecmpswks.idx_test_summary_rpt_period;

-- CREATE INDEX idx_test_summary_rpt_period
--     ON camdecmpswks.test_summary USING btree
--     (rpt_period_id ASC NULLS LAST);

-- -- Index: idx_test_summary_span_scale

-- -- DROP INDEX camdecmpswks.idx_test_summary_span_scale;

-- CREATE INDEX idx_test_summary_span_scale
--     ON camdecmpswks.test_summary USING btree
--     (span_scale_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_test_summary_test_reaso

-- -- DROP INDEX camdecmpswks.idx_test_summary_test_reaso;

-- CREATE INDEX idx_test_summary_test_reaso
--     ON camdecmpswks.test_summary USING btree
--     (test_reason_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_test_summary_test_resul

-- -- DROP INDEX camdecmpswks.idx_test_summary_test_resul;

-- CREATE INDEX idx_test_summary_test_resul
--     ON camdecmpswks.test_summary USING btree
--     (test_result_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_test_summary_test_type

-- -- DROP INDEX camdecmpswks.idx_test_summary_test_type;

-- CREATE INDEX idx_test_summary_test_type
--     ON camdecmpswks.test_summary USING btree
--     (test_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);
