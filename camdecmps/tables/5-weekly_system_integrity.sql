-- Table: camdecmps.weekly_system_integrity

-- DROP TABLE IF EXISTS camdecmps.weekly_system_integrity;

CREATE TABLE IF NOT EXISTS camdecmps.weekly_system_integrity
(
    weekly_sys_integrity_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    weekly_test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    gas_level_cd character varying(7) COLLATE pg_catalog."default",
    ref_value numeric(13,3),
    measured_value numeric(13,3),
    system_integrity_error numeric(5,1),
    aps_ind numeric(38,0),
    calc_system_integrity_error numeric(5,1),
    calc_aps_ind numeric(38,0),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    rpt_period_id numeric(38,0) NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_weekly_system_integrity PRIMARY KEY (weekly_sys_integrity_id),
    CONSTRAINT fk_weekly_system_integrity_gas_level_code FOREIGN KEY (gas_level_cd)
        REFERENCES camdecmpsmd.gas_level_code (gas_level_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_weekly_system_integrity_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_weekly_system_integrity_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_weekly_system_integrity_weekly_test_summary FOREIGN KEY (weekly_test_sum_id)
        REFERENCES camdecmps.weekly_test_summary (weekly_test_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);

COMMENT ON TABLE camdecmps.weekly_system_integrity
    IS 'Weekly error test data and results. ';

COMMENT ON COLUMN camdecmps.weekly_system_integrity.weekly_sys_integrity_id
    IS 'Unique identifier of a weekly system integrity record. ';

COMMENT ON COLUMN camdecmps.weekly_system_integrity.weekly_test_sum_id
    IS 'Unique identifier of a weekly test summary record. ';

COMMENT ON COLUMN camdecmps.weekly_system_integrity.gas_level_cd
    IS 'Code used to identify calibration gas level. ';

COMMENT ON COLUMN camdecmps.weekly_system_integrity.ref_value
    IS 'Reference Value. ';

COMMENT ON COLUMN camdecmps.weekly_system_integrity.measured_value
    IS 'Measured Value. ';

COMMENT ON COLUMN camdecmps.weekly_system_integrity.system_integrity_error
    IS 'Reported error: can be percentage or difference value. ';

COMMENT ON COLUMN camdecmps.weekly_system_integrity.aps_ind
    IS 'Alternative Performance Spec Indicator. ';

COMMENT ON COLUMN camdecmps.weekly_system_integrity.calc_system_integrity_error
    IS 'Calculated error: can be percentage or difference value. ';

COMMENT ON COLUMN camdecmps.weekly_system_integrity.calc_aps_ind
    IS 'Calculated Alternative Performance Spec Indicator. ';

COMMENT ON COLUMN camdecmps.weekly_system_integrity.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.weekly_system_integrity.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.weekly_system_integrity.update_date
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmps.weekly_system_integrity.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmps.weekly_system_integrity.mon_loc_id
    IS 'Unique identifier of a monitor location record. ';
-- Index: idx_wsi_gas_level

-- DROP INDEX IF EXISTS camdecmps.idx_wsi_gas_level;

CREATE INDEX IF NOT EXISTS idx_wsi_gas_level
    ON camdecmps.weekly_system_integrity USING btree
    (gas_level_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_wsi_prd_loc

-- DROP INDEX IF EXISTS camdecmps.idx_wsi_prd_loc;

CREATE INDEX IF NOT EXISTS idx_wsi_prd_loc
    ON camdecmps.weekly_system_integrity USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_wsi_weekly_test_sum_id

-- DROP INDEX IF EXISTS camdecmps.idx_wsi_weekly_test_sum_id;

CREATE INDEX IF NOT EXISTS idx_wsi_weekly_test_sum_id
    ON camdecmps.weekly_system_integrity USING btree
    (weekly_test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;