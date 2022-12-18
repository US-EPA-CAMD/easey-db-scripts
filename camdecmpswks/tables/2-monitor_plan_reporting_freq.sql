-- Table: camdecmpswks.monitor_plan_reporting_freq

-- DROP TABLE camdecmpswks.monitor_plan_reporting_freq;

CREATE TABLE camdecmpswks.monitor_plan_reporting_freq
(
    mon_plan_rf_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_plan_id character varying(45) COLLATE pg_catalog."default",
    report_freq_cd character varying(7) COLLATE pg_catalog."default",
    end_rpt_period_id numeric(38,0),
    begin_rpt_period_id numeric(38,0),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_monitor_plan_reporting_freq PRIMARY KEY (mon_plan_rf_id),
    CONSTRAINT fk_monitor_plan_reporting_freq_begin_rpt_period FOREIGN KEY (begin_rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_plan_reporting_freq_end_rpt_period FOREIGN KEY (end_rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_monitor_plan_reporting_freq_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmpswks.monitor_plan (mon_plan_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_monitor_plan_reporting_freq_report_freq_code FOREIGN KEY (report_freq_cd)
        REFERENCES camdecmpsmd.report_freq_code (report_freq_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
-- Index: idx_monitor_plan_re_begin_rpt_

-- DROP INDEX camdecmpswks.idx_monitor_plan_re_begin_rpt_;

CREATE INDEX IF NOT EXISTS idx_monitor_plan_re_begin_rpt_
    ON camdecmpswks.monitor_plan_reporting_freq USING btree
    (begin_rpt_period_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_monitor_plan_re_end_rpt_pe

-- DROP INDEX camdecmpswks.idx_monitor_plan_re_end_rpt_pe;

CREATE INDEX IF NOT EXISTS idx_monitor_plan_re_end_rpt_pe
    ON camdecmpswks.monitor_plan_reporting_freq USING btree
    (end_rpt_period_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_monitor_plan_re_mon_plan_i

-- DROP INDEX camdecmpswks.idx_monitor_plan_re_mon_plan_i;

CREATE INDEX IF NOT EXISTS idx_monitor_plan_re_mon_plan_i
    ON camdecmpswks.monitor_plan_reporting_freq USING btree
    (mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_monitor_plan_re_report_fre

-- DROP INDEX camdecmpswks.idx_monitor_plan_re_report_fre;

CREATE INDEX IF NOT EXISTS idx_monitor_plan_re_report_fre
    ON camdecmpswks.monitor_plan_reporting_freq USING btree
    (report_freq_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;