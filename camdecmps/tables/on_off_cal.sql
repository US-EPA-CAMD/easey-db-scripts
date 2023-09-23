CREATE TABLE IF NOT EXISTS camdecmps.on_off_cal
(
    on_off_cal_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    online_zero_injection_date date,
    online_zero_injection_hour numeric(2,0),
    online_zero_aps_ind numeric(38,0),
    calc_online_zero_aps_ind numeric(38,0),
    online_zero_cal_error numeric(6,2),
    calc_online_zero_cal_error numeric(6,2),
    online_zero_measured_value numeric(13,3),
    online_zero_ref_value numeric(13,3),
    online_upscale_aps_ind numeric(38,0),
    calc_online_upscale_aps_ind numeric(38,0),
    online_upscale_cal_error numeric(6,2),
    calc_online_upscale_cal_error numeric(6,2),
    online_upscale_injection_date date,
    online_upscale_injection_hour numeric(2,0),
    online_upscale_measured_value numeric(13,3),
    online_upscale_ref_value numeric(13,3),
    offline_zero_aps_ind numeric(38,0),
    calc_offline_zero_aps_ind numeric(38,0),
    offline_zero_cal_error numeric(6,2),
    calc_offline_zero_cal_error numeric(6,2),
    offline_zero_injection_date date,
    offline_zero_injection_hour numeric(2,0),
    offline_zero_measured_value numeric(13,3),
    offline_zero_ref_value numeric(13,3),
    offline_upscale_aps_ind numeric(38,0),
    calc_offline_upscale_aps_ind numeric(38,0),
    offline_upscale_cal_error numeric(6,2),
    calc_offline_upscale_cal_error numeric(6,2),
    offline_upscale_injection_date date,
    offline_upscale_injection_hour numeric(2,0),
    offline_upscale_measured_value numeric(13,3),
    offline_upscale_ref_value numeric(13,3),
    upscale_gas_level_cd character varying(7) COLLATE pg_catalog."default",
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);

COMMENT ON TABLE camdecmps.on_off_cal
    IS 'Qualifying tests for off-line calibration error checks.  Record Type 623.';

COMMENT ON COLUMN camdecmps.on_off_cal.on_off_cal_id
    IS 'Unique identifier of an online offline calibration record. ';

COMMENT ON COLUMN camdecmps.on_off_cal.test_sum_id
    IS 'Unique identifier of a test summary record. ';

COMMENT ON COLUMN camdecmps.on_off_cal.online_zero_injection_date
    IS 'Online zero/low level injection date. ';

COMMENT ON COLUMN camdecmps.on_off_cal.online_zero_injection_hour
    IS 'Online zero/low level injection hour. ';

COMMENT ON COLUMN camdecmps.on_off_cal.online_zero_aps_ind
    IS 'Alternative performance specification (APS) indicator. ';

COMMENT ON COLUMN camdecmps.on_off_cal.calc_online_zero_aps_ind
    IS 'Alternative performance specification (APS) indicator. ';

COMMENT ON COLUMN camdecmps.on_off_cal.online_zero_cal_error
    IS 'Online zero/low level calibration error or |R-A|. ';

COMMENT ON COLUMN camdecmps.on_off_cal.calc_online_zero_cal_error
    IS 'Online zero/low level calibration error or |R-A|. ';

COMMENT ON COLUMN camdecmps.on_off_cal.online_zero_measured_value
    IS 'Online zero/low level measured value. ';

COMMENT ON COLUMN camdecmps.on_off_cal.online_zero_ref_value
    IS 'Online zero/low level reference value. ';

COMMENT ON COLUMN camdecmps.on_off_cal.online_upscale_aps_ind
    IS 'Alternative performance specification (APS) indicator. ';

COMMENT ON COLUMN camdecmps.on_off_cal.calc_online_upscale_aps_ind
    IS 'Alternative performance specification (APS) indicator. ';

COMMENT ON COLUMN camdecmps.on_off_cal.online_upscale_cal_error
    IS 'Online upscale level calibration error or |R-A|. ';

COMMENT ON COLUMN camdecmps.on_off_cal.calc_online_upscale_cal_error
    IS 'Online upscale level calibration error or |R-A|. ';

COMMENT ON COLUMN camdecmps.on_off_cal.online_upscale_injection_date
    IS 'Online upscale level injection date. ';

COMMENT ON COLUMN camdecmps.on_off_cal.online_upscale_injection_hour
    IS 'Online upscale level injection hour. ';

COMMENT ON COLUMN camdecmps.on_off_cal.online_upscale_measured_value
    IS 'Online upscale level measured value. ';

COMMENT ON COLUMN camdecmps.on_off_cal.online_upscale_ref_value
    IS 'Online upscale level reference value. ';

COMMENT ON COLUMN camdecmps.on_off_cal.offline_zero_aps_ind
    IS 'Alternative performance specification (APS) indicator. ';

COMMENT ON COLUMN camdecmps.on_off_cal.calc_offline_zero_aps_ind
    IS 'Alternative performance specification (APS) indicator. ';

COMMENT ON COLUMN camdecmps.on_off_cal.offline_zero_cal_error
    IS 'Offline zero/low level calibration error or |R-A|. ';

COMMENT ON COLUMN camdecmps.on_off_cal.calc_offline_zero_cal_error
    IS 'Offline zero/low level calibration error or |R-A|. ';

COMMENT ON COLUMN camdecmps.on_off_cal.offline_zero_injection_date
    IS 'Offline zero/low level injection date. ';

COMMENT ON COLUMN camdecmps.on_off_cal.offline_zero_injection_hour
    IS 'Offline zero/low level injection hour. ';

COMMENT ON COLUMN camdecmps.on_off_cal.offline_zero_measured_value
    IS 'Offline zero/low level measured value. ';

COMMENT ON COLUMN camdecmps.on_off_cal.offline_zero_ref_value
    IS 'Offline zero/low level reference value. ';

COMMENT ON COLUMN camdecmps.on_off_cal.offline_upscale_aps_ind
    IS 'Alternative performance specification (APS) indicator. ';

COMMENT ON COLUMN camdecmps.on_off_cal.calc_offline_upscale_aps_ind
    IS 'Alternative performance specification (APS) indicator. ';

COMMENT ON COLUMN camdecmps.on_off_cal.offline_upscale_cal_error
    IS 'Offline upscale level calibration error or |R-A|. ';

COMMENT ON COLUMN camdecmps.on_off_cal.calc_offline_upscale_cal_error
    IS 'Offline upscale level calibration error or |R-A|. ';

COMMENT ON COLUMN camdecmps.on_off_cal.offline_upscale_injection_date
    IS 'Offline upscale level injection date. ';

COMMENT ON COLUMN camdecmps.on_off_cal.offline_upscale_injection_hour
    IS 'Offline upscale level injection hour. ';

COMMENT ON COLUMN camdecmps.on_off_cal.offline_upscale_measured_value
    IS 'Offline upscale measured value. ';

COMMENT ON COLUMN camdecmps.on_off_cal.offline_upscale_ref_value
    IS 'Offline upscale level reference value. ';

COMMENT ON COLUMN camdecmps.on_off_cal.upscale_gas_level_cd
    IS 'Code used to identify upscale gas level. ';

COMMENT ON COLUMN camdecmps.on_off_cal.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.on_off_cal.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.on_off_cal.update_date
    IS 'Date and time in which record was last updated. ';
