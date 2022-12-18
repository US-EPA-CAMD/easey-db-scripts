-- Table: camdecmps.daily_test_system_supp_data

-- DROP TABLE IF EXISTS camdecmps.daily_test_system_supp_data;

CREATE TABLE IF NOT EXISTS camdecmps.daily_test_system_supp_data
(
    daily_test_system_supp_data_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    daily_test_supp_data_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_sys_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    op_hour_cnt numeric(38,0) NOT NULL,
    last_covered_nonop_datehour timestamp without time zone,
    first_op_after_nonop_datehour timestamp without time zone,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_daily_test_sys_sup_data PRIMARY KEY (daily_test_system_supp_data_id),
    CONSTRAINT fk_daily_test_sys_sup_data_dts FOREIGN KEY (daily_test_supp_data_id)
        REFERENCES camdecmps.daily_test_supp_data (daily_test_supp_data_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_daily_test_sys_sup_data_loc FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_daily_test_sys_sup_data_rpp FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_daily_test_sys_sup_data_tty FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmps.daily_test_system_supp_data
    IS '.';

COMMENT ON COLUMN camdecmps.daily_test_system_supp_data.daily_test_system_supp_data_id
    IS 'Unique identifier.';

COMMENT ON COLUMN camdecmps.daily_test_system_supp_data.mon_sys_id
    IS '.';

COMMENT ON COLUMN camdecmps.daily_test_system_supp_data.op_hour_cnt
    IS 'Count of hours in the quarter for the component and operating supplemental data type.';

COMMENT ON COLUMN camdecmps.daily_test_system_supp_data.last_covered_nonop_datehour
    IS '.';

COMMENT ON COLUMN camdecmps.daily_test_system_supp_data.mon_loc_id
    IS 'Unique identifier of a monitoring location record.';

COMMENT ON COLUMN camdecmps.daily_test_system_supp_data.rpt_period_id
    IS 'Unique identifier of a report period.';

COMMENT ON COLUMN camdecmps.daily_test_system_supp_data.userid
    IS 'User account or source of data that added or updated record.';

COMMENT ON COLUMN camdecmps.daily_test_system_supp_data.add_date
    IS 'Date and time in which record was added.';

COMMENT ON COLUMN camdecmps.daily_test_system_supp_data.update_date
    IS 'Date and time in which record was last updated.';

-- Index: idx_daily_test_sys_sup_data_dt

-- DROP INDEX IF EXISTS camdecmps.idx_daily_test_sys_sup_data_dt;

CREATE INDEX IF NOT EXISTS IF NOT EXISTS idx_daily_test_sys_sup_data_dt
    ON camdecmps.daily_test_system_supp_data USING btree
    (daily_test_supp_data_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_daily_test_sys_sup_data_em

-- DROP INDEX IF EXISTS camdecmps.idx_daily_test_sys_sup_data_em;

CREATE INDEX IF NOT EXISTS IF NOT EXISTS idx_daily_test_sys_sup_data_em
    ON camdecmps.daily_test_system_supp_data USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_daily_test_sys_sup_data_ml

-- DROP INDEX IF EXISTS camdecmps.idx_daily_test_sys_sup_data_ml;

CREATE INDEX IF NOT EXISTS IF NOT EXISTS idx_daily_test_sys_sup_data_ml
    ON camdecmps.daily_test_system_supp_data USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_daily_test_sys_sup_data_ms

-- DROP INDEX IF EXISTS camdecmps.idx_daily_test_sys_sup_data_ms;

CREATE INDEX IF NOT EXISTS IF NOT EXISTS idx_daily_test_sys_sup_data_ms
    ON camdecmps.daily_test_system_supp_data USING btree
    (mon_sys_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_daily_test_sys_sup_data_rp

-- DROP INDEX IF EXISTS camdecmps.idx_daily_test_sys_sup_data_rp;

CREATE INDEX IF NOT EXISTS IF NOT EXISTS idx_daily_test_sys_sup_data_rp
    ON camdecmps.daily_test_system_supp_data USING btree
    (rpt_period_id ASC NULLS LAST);