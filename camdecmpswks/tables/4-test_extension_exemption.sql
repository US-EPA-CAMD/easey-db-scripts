-- Table: camdecmpswks.test_extension_exemption

-- DROP TABLE camdecmpswks.test_extension_exemption;

CREATE TABLE IF NOT EXISTS camdecmpswks.test_extension_exemption
(
    test_extension_exemption_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    mon_sys_id character varying(45) COLLATE pg_catalog."default",
    component_id character varying(45) COLLATE pg_catalog."default",
    fuel_cd character varying(7) COLLATE pg_catalog."default",
    extens_exempt_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    last_updated timestamp without time zone,
    updated_status_flg character varying(1) COLLATE pg_catalog."default",
    needs_eval_flg character varying(1) COLLATE pg_catalog."default",
    chk_session_id character varying(45) COLLATE pg_catalog."default",
    hours_used numeric(4,0),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    span_scale_cd character varying(7) COLLATE pg_catalog."default",
    submission_id numeric(38,0),
    submission_availability_cd character varying(7) COLLATE pg_catalog."default",
    pending_status_cd character varying(7) COLLATE pg_catalog."default",
    eval_status_cd character varying(7) COLLATE pg_catalog."default" NOT NULL DEFAULT 'EVAL'::character varying,
    CONSTRAINT pk_test_extension_exemption PRIMARY KEY (test_extension_exemption_id),
    CONSTRAINT fk_test_extension_exemption_component FOREIGN KEY (component_id)
        REFERENCES camdecmpswks.component (component_id) MATCH SIMPLE,
    CONSTRAINT fk_test_extension_exemption_extension_exemption_code FOREIGN KEY (extens_exempt_cd)
        REFERENCES camdecmpsmd.extension_exemption_code (extens_exempt_cd) MATCH SIMPLE,
    CONSTRAINT fk_test_extension_exemption_fuel_code FOREIGN KEY (fuel_cd)
        REFERENCES camdecmpsmd.fuel_code (fuel_cd) MATCH SIMPLE,
    CONSTRAINT fk_test_extension_exemption_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE,
    CONSTRAINT fk_test_extension_exemption_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmpswks.monitor_system (mon_sys_id) MATCH SIMPLE,
    CONSTRAINT fk_test_extension_exemption_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    CONSTRAINT fk_test_extension_exemption_span_scale_code FOREIGN KEY (span_scale_cd)
        REFERENCES camdecmpsmd.span_scale_code (span_scale_cd) MATCH SIMPLE,
    CONSTRAINT fk_test_extension_exemption_submission_availability_code FOREIGN KEY (submission_availability_cd)
        REFERENCES camdecmpsmd.submission_availability_code (submission_availability_cd) MATCH SIMPLE,
    CONSTRAINT fk_test_extension_exemption_pending_status_code FOREIGN KEY (pending_status_cd)
        REFERENCES camdecmpsmd.submission_availability_code (submission_availability_cd) MATCH SIMPLE,
    CONSTRAINT fk_test_extension_exemption_eval_status_code FOREIGN KEY (eval_status_cd)
        REFERENCES camdecmpsmd.eval_status_code (eval_status_cd) MATCH SIMPLE
);

-- -- Index: idx_test_extension__chk_sessio

-- -- DROP INDEX camdecmpswks.idx_test_extension__chk_sessio;

-- CREATE INDEX idx_test_extension__chk_sessio
--     ON camdecmpswks.test_extension_exemption USING btree
--     (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_test_extension__submission

-- -- DROP INDEX camdecmpswks.idx_test_extension__submission;

-- CREATE INDEX idx_test_extension__submission
--     ON camdecmpswks.test_extension_exemption USING btree
--     (submission_id ASC NULLS LAST);

-- -- Index: idx_test_extension_component

-- -- DROP INDEX camdecmpswks.idx_test_extension_component;

-- CREATE INDEX idx_test_extension_component
--     ON camdecmpswks.test_extension_exemption USING btree
--     (component_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_test_extension_extens_exe

-- -- DROP INDEX camdecmpswks.idx_test_extension_extens_exe;

-- CREATE INDEX idx_test_extension_extens_exe
--     ON camdecmpswks.test_extension_exemption USING btree
--     (extens_exempt_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_test_extension_fuel_cd

-- -- DROP INDEX camdecmpswks.idx_test_extension_fuel_cd;

-- CREATE INDEX idx_test_extension_fuel_cd
--     ON camdecmpswks.test_extension_exemption USING btree
--     (fuel_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_test_extension_mon_loc_id

-- -- DROP INDEX camdecmpswks.idx_test_extension_mon_loc_id;

-- CREATE INDEX idx_test_extension_mon_loc_id
--     ON camdecmpswks.test_extension_exemption USING btree
--     (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_test_extension_mon_sys_id

-- -- DROP INDEX camdecmpswks.idx_test_extension_mon_sys_id;

-- CREATE INDEX idx_test_extension_mon_sys_id
--     ON camdecmpswks.test_extension_exemption USING btree
--     (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_test_extension_span_scale

-- -- DROP INDEX camdecmpswks.idx_test_extension_span_scale;

-- CREATE INDEX idx_test_extension_span_scale
--     ON camdecmpswks.test_extension_exemption USING btree
--     (span_scale_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_test_extension_submission

-- -- DROP INDEX camdecmpswks.idx_test_extension_submission;

-- CREATE INDEX idx_test_extension_submission
--     ON camdecmpswks.test_extension_exemption USING btree
--     (submission_availability_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: test_ext_exempt_idx001

-- -- DROP INDEX camdecmpswks.test_ext_exempt_idx001;

-- CREATE INDEX test_ext_exempt_idx001
--     ON camdecmpswks.test_extension_exemption USING btree
--     (rpt_period_id ASC NULLS LAST);
