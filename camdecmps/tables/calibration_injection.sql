CREATE TABLE IF NOT EXISTS camdecmps.calibration_injection
(
    cal_inj_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    online_offline_ind numeric(38,0),
    zero_ref_value numeric(13,3),
    zero_cal_error numeric(6,2),
    calc_zero_cal_error numeric(6,2),
    zero_aps_ind numeric(38,0),
    calc_zero_aps_ind numeric(38,0),
    zero_injection_date date,
    zero_injection_hour numeric(2,0),
    zero_injection_min numeric(2,0),
    upscale_ref_value numeric(13,3),
    zero_measured_value numeric(13,3),
    upscale_gas_level_cd character varying(7) COLLATE pg_catalog."default",
    upscale_measured_value numeric(13,3),
    upscale_cal_error numeric(6,2),
    calc_upscale_cal_error numeric(6,2),
    upscale_aps_ind numeric(38,0),
    calc_upscale_aps_ind numeric(38,0),
    upscale_injection_date date,
    upscale_injection_hour numeric(2,0),
    upscale_injection_min numeric(2,0),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);

COMMENT ON TABLE camdecmps.calibration_injection
    IS '7 Day calibration error test data and results.  Each record in this table contains a single day''s test for both low and high injection test results.  Record type 600.';

COMMENT ON COLUMN camdecmps.calibration_injection.cal_inj_id
    IS 'Unique identifier of a daily calibration injection record. ';

COMMENT ON COLUMN camdecmps.calibration_injection.test_sum_id
    IS 'Unique identifier of a test summary record. ';

COMMENT ON COLUMN camdecmps.calibration_injection.online_offline_ind
    IS 'Indicates whether the unit or stack is operating at the time of the test. ';

COMMENT ON COLUMN camdecmps.calibration_injection.zero_ref_value
    IS 'Low level reference value. ';

COMMENT ON COLUMN camdecmps.calibration_injection.zero_cal_error
    IS 'Reported zero or low level calibration error. ';

COMMENT ON COLUMN camdecmps.calibration_injection.calc_zero_cal_error
    IS 'Reported zero or low level calibration error. ';

COMMENT ON COLUMN camdecmps.calibration_injection.zero_aps_ind
    IS 'Alternative performance specification (APS) indicator. ';

COMMENT ON COLUMN camdecmps.calibration_injection.calc_zero_aps_ind
    IS 'Alternative performance specification (APS) indicator. ';

COMMENT ON COLUMN camdecmps.calibration_injection.zero_injection_date
    IS 'Date of low level injection. ';

COMMENT ON COLUMN camdecmps.calibration_injection.zero_injection_hour
    IS 'Hour of low level injection. ';

COMMENT ON COLUMN camdecmps.calibration_injection.zero_injection_min
    IS 'Zero Injection Minute. ';

COMMENT ON COLUMN camdecmps.calibration_injection.upscale_ref_value
    IS 'Upscale reference value. ';

COMMENT ON COLUMN camdecmps.calibration_injection.zero_measured_value
    IS 'Low level measured value. ';

COMMENT ON COLUMN camdecmps.calibration_injection.upscale_gas_level_cd
    IS 'Code used to identify upscale gas level. ';

COMMENT ON COLUMN camdecmps.calibration_injection.upscale_measured_value
    IS 'Upscale measured value. ';

COMMENT ON COLUMN camdecmps.calibration_injection.upscale_cal_error
    IS 'Reported zero or upscale level calibration error. ';

COMMENT ON COLUMN camdecmps.calibration_injection.calc_upscale_cal_error
    IS 'Reported zero or upscale level calibration error. ';

COMMENT ON COLUMN camdecmps.calibration_injection.upscale_aps_ind
    IS 'Alternative performance specification (APS) indicator. ';

COMMENT ON COLUMN camdecmps.calibration_injection.calc_upscale_aps_ind
    IS 'Alternative performance specification (APS) indicator. ';

COMMENT ON COLUMN camdecmps.calibration_injection.upscale_injection_date
    IS 'Date of upscale injection. ';

COMMENT ON COLUMN camdecmps.calibration_injection.upscale_injection_hour
    IS 'Hour of upscale injection. ';

COMMENT ON COLUMN camdecmps.calibration_injection.upscale_injection_min
    IS 'Upscale Injection minute. ';

COMMENT ON COLUMN camdecmps.calibration_injection.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.calibration_injection.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.calibration_injection.update_date
    IS 'Date and time in which record was last updated. ';
