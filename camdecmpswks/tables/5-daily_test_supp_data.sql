-- Table: camdecmpswks.daily_test_supp_data

-- DROP TABLE IF EXISTS camdecmpswks.daily_test_supp_data;

CREATE TABLE IF NOT EXISTS camdecmpswks.daily_test_supp_data
(
    daily_test_supp_data_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    component_id character varying(45) COLLATE pg_catalog."default",
    rpt_period_id numeric(38,0) NOT NULL,
    test_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    span_scale_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    key_online_ind numeric(1,0) NOT NULL,
    key_valid_ind numeric(1,0) NOT NULL,
    op_hour_cnt numeric(38,0),
    last_covered_nonop_datehour timestamp without time zone,
    first_op_after_nonop_datehour timestamp without time zone,
    daily_test_datehourmin timestamp without time zone,
    test_result_cd character varying(7) COLLATE pg_catalog."default",
    online_offline_ind numeric(38,0),
    sort_daily_test_datehourmin timestamp without time zone,
    daily_test_sum_id character varying(45) COLLATE pg_catalog."default",
    calc_test_result_cd character varying(7) COLLATE pg_catalog."default",
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    delete_ind numeric(1,0) NOT NULL DEFAULT 0,
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_daily_test_supp_data PRIMARY KEY (daily_test_supp_data_id),
    CONSTRAINT fk_daily_test_supp_data_cmp FOREIGN KEY (component_id)
        REFERENCES camdecmpswks.component (component_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_daily_test_supp_data_ctr FOREIGN KEY (calc_test_result_cd)
        REFERENCES camdecmpsmd.test_result_code (test_result_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_daily_test_supp_data_dts FOREIGN KEY (daily_test_sum_id)
        REFERENCES camdecmpswks.daily_test_summary (daily_test_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_daily_test_supp_data_loc FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_daily_test_supp_data_rpp FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_daily_test_supp_data_trs FOREIGN KEY (test_result_cd)
        REFERENCES camdecmpsmd.test_result_code (test_result_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_daily_test_supp_data_tty FOREIGN KEY (test_type_cd)
        REFERENCES camdecmpsmd.test_type_code (test_type_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT ck_daily_test_supp_data_cmp CHECK (COALESCE(delete_ind, 0::numeric) <> 1::numeric AND component_id IS NOT NULL OR COALESCE(delete_ind, 0::numeric) = 1::numeric AND component_id IS NULL),
    CONSTRAINT ck_daily_test_supp_data_dti CHECK (COALESCE(delete_ind, 0::numeric) <> 1::numeric AND daily_test_sum_id IS NOT NULL OR COALESCE(delete_ind, 0::numeric) = 1::numeric AND daily_test_sum_id IS NULL),
    CONSTRAINT ck_daily_test_supp_data_dtt CHECK (COALESCE(delete_ind, 0::numeric) <> 1::numeric AND daily_test_datehourmin IS NOT NULL OR COALESCE(delete_ind, 0::numeric) = 1::numeric AND daily_test_datehourmin IS NULL),
    CONSTRAINT ck_daily_test_supp_data_ohc CHECK (COALESCE(delete_ind, 0::numeric) <> 1::numeric AND op_hour_cnt IS NOT NULL OR COALESCE(delete_ind, 0::numeric) = 1::numeric AND op_hour_cnt IS NULL),
    CONSTRAINT ck_daily_test_supp_data_ssc CHECK (span_scale_cd::text = ANY (ARRAY['H'::character varying, 'L'::character varying, 'N'::character varying]::text[])),
    CONSTRAINT ck_daily_test_supp_data_stt CHECK (COALESCE(delete_ind, 0::numeric) <> 1::numeric AND sort_daily_test_datehourmin IS NOT NULL OR COALESCE(delete_ind, 0::numeric) = 1::numeric AND sort_daily_test_datehourmin IS NULL),
    CONSTRAINT ck_daily_test_supp_data_trs CHECK (COALESCE(delete_ind, 0::numeric) <> 1::numeric AND test_result_cd IS NOT NULL OR COALESCE(delete_ind, 0::numeric) = 1::numeric AND test_result_cd IS NULL)
);

COMMENT ON TABLE camdecmpswks.daily_test_supp_data
    IS 'Supports initializing the daily calibration object with data from the previous quarter.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.daily_test_supp_data_id
    IS 'Unique identifier.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.component_id
    IS 'Unique identifier of a component record.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.rpt_period_id
    IS 'Unique identifier of a reporting period recor.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.test_type_cd
    IS 'Code used to identify test type.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.span_scale_cd
    IS 'Code used to identify the span scale.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.key_online_ind
    IS '.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.key_valid_ind
    IS '.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.op_hour_cnt
    IS 'Count of hours in the quarter for the component and operating supplemental data type.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.first_op_after_nonop_datehour
    IS '.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.daily_test_datehourmin
    IS '.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.test_result_cd
    IS 'Code used to identify reported test result.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.online_offline_ind
    IS '.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.sort_daily_test_datehourmin
    IS '.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.daily_test_sum_id
    IS 'Unique identifier of a daily test summary record. .';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.calc_test_result_cd
    IS 'Code used to identify reported test result.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.mon_loc_id
    IS 'Unique identifier of a monitoring location record.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.delete_ind
    IS 'Indicates whether the supplemental data is in a deleted state, and that ECMPS client synchronization should delete it from the each client.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.userid
    IS 'User account or source of data that added or updated record.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.add_date
    IS 'Date and time in which record was added.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.update_date
    IS 'Date and time in which record was last updated.';

-- Index: idx_daily_test_supp_data_cmp

-- DROP INDEX IF EXISTS camdecmpswks.idx_daily_test_supp_data_cmp;

CREATE INDEX IF NOT EXISTS idx_daily_test_supp_data_cmp
    ON camdecmpswks.daily_test_supp_data USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_daily_test_supp_data_ctr

-- DROP INDEX IF EXISTS camdecmpswks.idx_daily_test_supp_data_ctr;

CREATE INDEX IF NOT EXISTS idx_daily_test_supp_data_ctr
    ON camdecmpswks.daily_test_supp_data USING btree
    (calc_test_result_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_daily_test_supp_data_dst

-- DROP INDEX IF EXISTS camdecmpswks.idx_daily_test_supp_data_dst;

CREATE INDEX IF NOT EXISTS idx_daily_test_supp_data_dst
    ON camdecmpswks.daily_test_supp_data USING btree
    (daily_test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_daily_test_supp_data_emr

-- DROP INDEX IF EXISTS camdecmpswks.idx_daily_test_supp_data_emr;

CREATE INDEX IF NOT EXISTS idx_daily_test_supp_data_emr
    ON camdecmpswks.daily_test_supp_data USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_daily_test_supp_data_kyo

-- DROP INDEX IF EXISTS camdecmpswks.idx_daily_test_supp_data_kyo;

CREATE INDEX IF NOT EXISTS idx_daily_test_supp_data_kyo
    ON camdecmpswks.daily_test_supp_data USING btree
    (key_online_ind ASC NULLS LAST);

-- Index: idx_daily_test_supp_data_kyv

-- DROP INDEX IF EXISTS camdecmpswks.idx_daily_test_supp_data_kyv;

CREATE INDEX IF NOT EXISTS idx_daily_test_supp_data_kyv
    ON camdecmpswks.daily_test_supp_data USING btree
    (key_valid_ind ASC NULLS LAST);

-- Index: idx_daily_test_supp_data_ool

-- DROP INDEX IF EXISTS camdecmpswks.idx_daily_test_supp_data_ool;

CREATE INDEX IF NOT EXISTS idx_daily_test_supp_data_ool
    ON camdecmpswks.daily_test_supp_data USING btree
    (online_offline_ind ASC NULLS LAST);

-- Index: idx_daily_test_supp_data_prd

-- DROP INDEX IF EXISTS camdecmpswks.idx_daily_test_supp_data_prd;

CREATE INDEX IF NOT EXISTS idx_daily_test_supp_data_prd
    ON camdecmpswks.daily_test_supp_data USING btree
    (rpt_period_id ASC NULLS LAST);

-- Index: idx_daily_test_supp_data_ssc

-- DROP INDEX IF EXISTS camdecmpswks.idx_daily_test_supp_data_ssc;

CREATE INDEX IF NOT EXISTS idx_daily_test_supp_data_ssc
    ON camdecmpswks.daily_test_supp_data USING btree
    (span_scale_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_daily_test_supp_data_trs

-- DROP INDEX IF EXISTS camdecmpswks.idx_daily_test_supp_data_trs;

CREATE INDEX IF NOT EXISTS idx_daily_test_supp_data_trs
    ON camdecmpswks.daily_test_supp_data USING btree
    (test_result_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_daily_test_supp_data_tty

-- DROP INDEX IF EXISTS camdecmpswks.idx_daily_test_supp_data_tty;

CREATE INDEX IF NOT EXISTS idx_daily_test_supp_data_tty
    ON camdecmpswks.daily_test_supp_data USING btree
    (test_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);