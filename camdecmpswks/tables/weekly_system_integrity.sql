CREATE TABLE IF NOT EXISTS camdecmpswks.weekly_system_integrity
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
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpswks.weekly_system_integrity
    IS 'Weekly error test data and results. ';

COMMENT ON COLUMN camdecmpswks.weekly_system_integrity.weekly_sys_integrity_id
    IS 'Unique identifier of a weekly system integrity record. ';

COMMENT ON COLUMN camdecmpswks.weekly_system_integrity.weekly_test_sum_id
    IS 'Unique identifier of a weekly test summary record. ';

COMMENT ON COLUMN camdecmpswks.weekly_system_integrity.gas_level_cd
    IS 'Code used to identify calibration gas level. ';

COMMENT ON COLUMN camdecmpswks.weekly_system_integrity.ref_value
    IS 'Reference Value. ';

COMMENT ON COLUMN camdecmpswks.weekly_system_integrity.measured_value
    IS 'Measured Value. ';

COMMENT ON COLUMN camdecmpswks.weekly_system_integrity.system_integrity_error
    IS 'Reported error: can be percentage or difference value. ';

COMMENT ON COLUMN camdecmpswks.weekly_system_integrity.aps_ind
    IS 'Alternative Performance Spec Indicator. ';

COMMENT ON COLUMN camdecmpswks.weekly_system_integrity.calc_system_integrity_error
    IS 'Calculated error: can be percentage or difference value. ';

COMMENT ON COLUMN camdecmpswks.weekly_system_integrity.calc_aps_ind
    IS 'Calculated Alternative Performance Spec Indicator. ';

COMMENT ON COLUMN camdecmpswks.weekly_system_integrity.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmpswks.weekly_system_integrity.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmpswks.weekly_system_integrity.update_date
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmpswks.weekly_system_integrity.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmpswks.weekly_system_integrity.mon_loc_id
    IS 'Unique identifier of a monitor location record. ';
