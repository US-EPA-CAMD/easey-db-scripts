-- Table: camdecmps.summary_value

-- DROP TABLE IF EXISTS camdecmps.summary_value;

CREATE TABLE IF NOT EXISTS camdecmps.summary_value
(
    sum_value_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    parameter_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    current_rpt_period_total numeric(13,3),
    calc_current_rpt_period_total numeric(13,3),
    os_total numeric(13,3),
    calc_os_total numeric(13,3),
    year_total numeric(13,3),
    calc_year_total numeric(13,3),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_summary_value PRIMARY KEY (sum_value_id),
    CONSTRAINT uq_summary_value UNIQUE (mon_loc_id, rpt_period_id, parameter_cd),
    CONSTRAINT fk_summary_value_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_summary_value_parameter_code FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_summary_value_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmps.summary_value
    IS 'Cumulative Emissions data. Record Types 301 and 307.';

COMMENT ON COLUMN camdecmps.summary_value.sum_value_id
    IS 'Unique identifier of a summary value record. ';

COMMENT ON COLUMN camdecmps.summary_value.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmps.summary_value.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmps.summary_value.parameter_cd
    IS 'Code used to identify the parameter. ';

COMMENT ON COLUMN camdecmps.summary_value.current_rpt_period_total
    IS 'Total value for current reporting period. ';

COMMENT ON COLUMN camdecmps.summary_value.calc_current_rpt_period_total
    IS 'Total value for current reporting period. ';

COMMENT ON COLUMN camdecmps.summary_value.os_total
    IS 'Ozone season year to date total. ';

COMMENT ON COLUMN camdecmps.summary_value.calc_os_total
    IS 'Ozone season year to date total. ';

COMMENT ON COLUMN camdecmps.summary_value.year_total
    IS 'Year to date total. ';

COMMENT ON COLUMN camdecmps.summary_value.calc_year_total
    IS 'Year to date total. ';

COMMENT ON COLUMN camdecmps.summary_value.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.summary_value.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.summary_value.update_date
    IS 'Date and time in which record was last updated. ';
-- Index: idx_summary_value_mon_loc_id

-- DROP INDEX IF EXISTS camdecmps.idx_summary_value_mon_loc_id;

CREATE INDEX IF NOT EXISTS idx_summary_value_mon_loc_id
    ON camdecmps.summary_value USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_sv_add_date

-- DROP INDEX IF EXISTS camdecmps.idx_sv_add_date;

CREATE INDEX IF NOT EXISTS idx_sv_add_date
    ON camdecmps.summary_value USING btree
    (add_date ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: summary_value_idx001

-- DROP INDEX IF EXISTS camdecmps.summary_value_idx001;

CREATE INDEX IF NOT EXISTS summary_value_idx001
    ON camdecmps.summary_value USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: summary_value_idx002

-- DROP INDEX IF EXISTS camdecmps.summary_value_idx002;

CREATE INDEX IF NOT EXISTS summary_value_idx002
    ON camdecmps.summary_value USING btree
    (rpt_period_id ASC NULLS LAST)
    TABLESPACE pg_default;