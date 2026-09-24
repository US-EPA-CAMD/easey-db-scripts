CREATE TABLE IF NOT EXISTS camdecmpswks.mats_monitor_hrly_value
(
    mats_mhv_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    hour_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    parameter_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    mon_sys_id character varying(45) COLLATE pg_catalog."default",
    component_id character varying(45) COLLATE pg_catalog."default",
    unadjusted_hrly_value character varying(30) COLLATE pg_catalog."default",
    modc_cd character varying(7) COLLATE pg_catalog."default",
    pct_available numeric(4,1),
    calc_unadjusted_hrly_value character varying(30) COLLATE pg_catalog."default",
    calc_daily_cal_status character varying(75) COLLATE pg_catalog."default",
    calc_hg_line_status character varying(75) COLLATE pg_catalog."default",
    calc_hgi1_status character varying(75) COLLATE pg_catalog."default",
    calc_rata_status character varying(75) COLLATE pg_catalog."default",
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);

COMMENT ON TABLE camdecmpswks.mats_monitor_hrly_value
    IS 'The MATS hourly value monitored and reported for each parameter. ';

COMMENT ON COLUMN camdecmpswks.mats_monitor_hrly_value.mats_mhv_id
    IS 'Unique identifier of MATS monitor hourly value record. ';

COMMENT ON COLUMN camdecmpswks.mats_monitor_hrly_value.hour_id
    IS 'Unique identifier of an hourly operating data record. ';

COMMENT ON COLUMN camdecmpswks.mats_monitor_hrly_value.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmpswks.mats_monitor_hrly_value.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmpswks.mats_monitor_hrly_value.parameter_cd
    IS 'Code used to identify the parameter. ';

COMMENT ON COLUMN camdecmpswks.mats_monitor_hrly_value.mon_sys_id
    IS 'Unique identifier of a monitoring system record. ';

COMMENT ON COLUMN camdecmpswks.mats_monitor_hrly_value.unadjusted_hrly_value
    IS 'Unadjusted measured value in scientific notation. ';

COMMENT ON COLUMN camdecmpswks.mats_monitor_hrly_value.modc_cd
    IS 'Code used to identify the method of determination. ';

COMMENT ON COLUMN camdecmpswks.mats_monitor_hrly_value.pct_available
    IS 'Percent monitor data availability. ';

COMMENT ON COLUMN camdecmpswks.mats_monitor_hrly_value.calc_unadjusted_hrly_value
    IS 'Adjusted average concentration or flow for the hour. ';

COMMENT ON COLUMN camdecmpswks.mats_monitor_hrly_value.calc_daily_cal_status
    IS 'QA Status for Daily Calibration Check determined by EPA. ';

COMMENT ON COLUMN camdecmpswks.mats_monitor_hrly_value.calc_hg_line_status
    IS 'QA Status for HG Linearity Check determined by EPA. ';

COMMENT ON COLUMN camdecmpswks.mats_monitor_hrly_value.calc_rata_status
    IS 'QA Status for RATA Check determined by EPA. ';

COMMENT ON COLUMN camdecmpswks.mats_monitor_hrly_value.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmpswks.mats_monitor_hrly_value.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmpswks.mats_monitor_hrly_value.update_date
    IS 'Date and time in which record was last updated. ';
