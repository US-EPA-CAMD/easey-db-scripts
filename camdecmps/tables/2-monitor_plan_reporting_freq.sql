-- Table: camdecmps.monitor_plan_reporting_freq

-- DROP TABLE camdecmps.monitor_plan_reporting_freq;

CREATE TABLE IF NOT EXISTS camdecmps.monitor_plan_reporting_freq
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
    CONSTRAINT fk_monitor_plan_monitor_plan2 FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmps.monitor_plan (mon_plan_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_report_freq_co_monitor_plan FOREIGN KEY (report_freq_cd)
        REFERENCES camdecmpsmd.report_freq_code (report_freq_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_report_perio_monitor_pla2 FOREIGN KEY (end_rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_report_perio_monitor_plan FOREIGN KEY (begin_rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmps.monitor_plan_reporting_freq
    IS 'Frequency of emissions reporting for a monitoring plan.';

COMMENT ON COLUMN camdecmps.monitor_plan_reporting_freq.mon_plan_rf_id
    IS 'Unique identifier of a monitoring plan reporting frequency record. ';

COMMENT ON COLUMN camdecmps.monitor_plan_reporting_freq.mon_plan_id
    IS 'Unique identifier of a monitoring plan record. ';

COMMENT ON COLUMN camdecmps.monitor_plan_reporting_freq.report_freq_cd
    IS 'Code that indicates the frequency of data submission. ';

COMMENT ON COLUMN camdecmps.monitor_plan_reporting_freq.end_rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmps.monitor_plan_reporting_freq.begin_rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmps.monitor_plan_reporting_freq.userid
    IS 'User account or source of data that added or updated record.';

COMMENT ON COLUMN camdecmps.monitor_plan_reporting_freq.add_date
    IS 'Date and time in which record was added.';

COMMENT ON COLUMN camdecmps.monitor_plan_reporting_freq.update_date
    IS 'Date and time in which record was last updated.';

-- Index: idx_monitor_plan_re_begin_rpt_

-- DROP INDEX camdecmps.idx_monitor_plan_re_begin_rpt_;

CREATE INDEX IF NOT EXISTS idx_monitor_plan_re_begin_rpt_
    ON camdecmps.monitor_plan_reporting_freq USING btree
    (begin_rpt_period_id ASC NULLS LAST);

-- Index: idx_monitor_plan_re_end_rpt_pe

-- DROP INDEX camdecmps.idx_monitor_plan_re_end_rpt_pe;

CREATE INDEX IF NOT EXISTS idx_monitor_plan_re_end_rpt_pe
    ON camdecmps.monitor_plan_reporting_freq USING btree
    (end_rpt_period_id ASC NULLS LAST);

-- Index: idx_monitor_plan_re_mon_plan_i

-- DROP INDEX camdecmps.idx_monitor_plan_re_mon_plan_i;

CREATE INDEX IF NOT EXISTS idx_monitor_plan_re_mon_plan_i
    ON camdecmps.monitor_plan_reporting_freq USING btree
    (mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_monitor_plan_re_report_fre

-- DROP INDEX camdecmps.idx_monitor_plan_re_report_fre;

CREATE INDEX IF NOT EXISTS idx_monitor_plan_re_report_fre
    ON camdecmps.monitor_plan_reporting_freq USING btree
    (report_freq_cd COLLATE pg_catalog."default" ASC NULLS LAST);
