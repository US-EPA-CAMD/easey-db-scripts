-- Table: camdecmpswks.monitor_plan

-- DROP TABLE camdecmpswks.monitor_plan;

CREATE TABLE camdecmpswks.monitor_plan
(
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    fac_id numeric(38,0) NOT NULL,
    config_type_cd character varying(7) COLLATE pg_catalog."default",
    last_updated timestamp without time zone,
    updated_status_flg character varying(1) COLLATE pg_catalog."default",
    needs_eval_flg character varying(1) COLLATE pg_catalog."default",
    chk_session_id character varying(45) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    submission_id numeric(38,0),
    submission_availability_cd character varying(7) COLLATE pg_catalog."default",
    pending_status_cd character varying(7) COLLATE pg_catalog."default",
    begin_rpt_period_id numeric(38,0) NOT NULL,
    end_rpt_period_id numeric(38,0),
    last_evaluated_date timestamp without time zone,
    eval_status_cd character varying(7) COLLATE pg_catalog."default" NOT NULL DEFAULT 'EVAL'::character varying,
    CONSTRAINT pk_monitor_plan PRIMARY KEY (mon_plan_id),
    CONSTRAINT fk_monitor_plan_eval_status_code FOREIGN KEY (eval_status_cd)
        REFERENCES camdecmpsmd.eval_status_code (eval_status_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_plan_plant FOREIGN KEY (fac_id)
        REFERENCES camd.plant (fac_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_plan_reporting_period_begin_rpt_period FOREIGN KEY (begin_rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_plan_reporting_period_end_rpt_period FOREIGN KEY (end_rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_plan_submission_availability_code FOREIGN KEY (submission_availability_cd)
        REFERENCES camdecmpsmd.submission_availability_code (submission_availability_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_plan_submission_availability_code_pending_status FOREIGN KEY (pending_status_cd)
        REFERENCES camdecmpsmd.submission_availability_code (submission_availability_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- -- Index: idx_monitor_plan_chk_sessio

-- -- DROP INDEX camdecmpswks.idx_monitor_plan_chk_sessio;

-- CREATE INDEX idx_monitor_plan_chk_sessio
--     ON camdecmpswks.monitor_plan USING btree
--     (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST)
--     TABLESPACE pg_default;
-- -- Index: idx_monitor_plan_fac_id

-- -- DROP INDEX camdecmpswks.idx_monitor_plan_fac_id;

-- CREATE INDEX idx_monitor_plan_fac_id
--     ON camdecmpswks.monitor_plan USING btree
--     (fac_id ASC NULLS LAST)
--     TABLESPACE pg_default;
-- -- Index: idx_monitor_plan_submission

-- -- DROP INDEX camdecmpswks.idx_monitor_plan_submission;

-- CREATE INDEX idx_monitor_plan_submission
--     ON camdecmpswks.monitor_plan USING btree
--     (submission_availability_cd COLLATE pg_catalog."default" ASC NULLS LAST)
--     TABLESPACE pg_default;
-- -- Index: idx_monitor_plan_submission1

-- -- DROP INDEX camdecmpswks.idx_monitor_plan_submission1;

-- CREATE INDEX idx_monitor_plan_submission1
--     ON camdecmpswks.monitor_plan USING btree
--     (submission_id ASC NULLS LAST)
--     TABLESPACE pg_default;
-- -- Index: monitor_plan_idx001

-- -- DROP INDEX camdecmpswks.monitor_plan_idx001;

-- CREATE INDEX monitor_plan_idx001
--     ON camdecmpswks.monitor_plan USING btree
--     (config_type_cd COLLATE pg_catalog."default" ASC NULLS LAST)
--     TABLESPACE pg_default;
-- -- Index: monitor_plan_idx002

-- -- DROP INDEX camdecmpswks.monitor_plan_idx002;

-- CREATE INDEX monitor_plan_idx002
--     ON camdecmpswks.monitor_plan USING btree
--     (begin_rpt_period_id ASC NULLS LAST)
--     TABLESPACE pg_default;
-- -- Index: monitor_plan_idx003

-- -- DROP INDEX camdecmpswks.monitor_plan_idx003;

-- CREATE INDEX monitor_plan_idx003
--     ON camdecmpswks.monitor_plan USING btree
--     (end_rpt_period_id ASC NULLS LAST)
--     TABLESPACE pg_default;