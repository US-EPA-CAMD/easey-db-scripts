CREATE TABLE IF NOT EXISTS camdecmps.monitor_hrly_value
(
    monitor_hrly_val_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    hour_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_sys_id character varying(45) COLLATE pg_catalog."default",
    component_id character varying(45) COLLATE pg_catalog."default",
    parameter_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    applicable_bias_adj_factor numeric(5,3),
    unadjusted_hrly_value numeric(13,3),
    adjusted_hrly_value numeric(13,3),
    calc_adjusted_hrly_value numeric(13,3),
    modc_cd character varying(7) COLLATE pg_catalog."default",
    pct_available numeric(4,1),
    moisture_basis character varying(10) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    calc_line_status character varying(75) COLLATE pg_catalog."default",
    calc_rata_status character varying(75) COLLATE pg_catalog."default",
    calc_daycal_status character varying(75) COLLATE pg_catalog."default",
    rpt_period_id numeric(38,0) NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    calc_leak_status character varying(75) COLLATE pg_catalog."default",
    calc_dayint_status character varying(75) COLLATE pg_catalog."default",
    calc_f2l_status character varying(75) COLLATE pg_catalog."default"
);

COMMENT ON TABLE camdecmps.monitor_hrly_value
    IS 'The hourly value monitored and reported for each parameter.  Record types 200 - 220.';

COMMENT ON COLUMN camdecmps.monitor_hrly_value.monitor_hrly_val_id
    IS 'Unique identifier of monitor hourly value record. ';

COMMENT ON COLUMN camdecmps.monitor_hrly_value.hour_id
    IS 'Unique identifier of an hourly operating data record. ';

COMMENT ON COLUMN camdecmps.monitor_hrly_value.mon_sys_id
    IS 'Unique identifier of a monitoring system record. ';

COMMENT ON COLUMN camdecmps.monitor_hrly_value.component_id
    IS 'Unique identifier of a monitoring component record. ';

COMMENT ON COLUMN camdecmps.monitor_hrly_value.parameter_cd
    IS 'Code used to identify the parameter. ';

COMMENT ON COLUMN camdecmps.monitor_hrly_value.applicable_bias_adj_factor
    IS 'Bias Adjustment Factor from most recent applicable RATA, as determined by ECMPS Client Tool. ';

COMMENT ON COLUMN camdecmps.monitor_hrly_value.unadjusted_hrly_value
    IS 'Unadjusted measured value. ';

COMMENT ON COLUMN camdecmps.monitor_hrly_value.adjusted_hrly_value
    IS 'Adjusted average concentration or flow for the hour. ';

COMMENT ON COLUMN camdecmps.monitor_hrly_value.calc_adjusted_hrly_value
    IS 'Adjusted average concentration or flow for the hour. ';

COMMENT ON COLUMN camdecmps.monitor_hrly_value.modc_cd
    IS 'Code used to identify the method of determination. ';

COMMENT ON COLUMN camdecmps.monitor_hrly_value.pct_available
    IS 'Percent monitor data availability. ';

COMMENT ON COLUMN camdecmps.monitor_hrly_value.moisture_basis
    IS 'Moisture basis for measured value. ';

COMMENT ON COLUMN camdecmps.monitor_hrly_value.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.monitor_hrly_value.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.monitor_hrly_value.update_date
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmps.monitor_hrly_value.calc_line_status
    IS 'QA Status for Linearity Check determined by EPA. ';

COMMENT ON COLUMN camdecmps.monitor_hrly_value.calc_rata_status
    IS 'QA Status for RATA Check determined by EPA. ';

COMMENT ON COLUMN camdecmps.monitor_hrly_value.calc_daycal_status
    IS 'QA Status for Daily Calibration Check determined by EPA. ';

COMMENT ON COLUMN camdecmps.monitor_hrly_value.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmps.monitor_hrly_value.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmps.monitor_hrly_value.calc_leak_status
    IS 'QA Status for Leak Check determined by EPA.';

COMMENT ON COLUMN camdecmps.monitor_hrly_value.calc_dayint_status
    IS 'QA Status for Daily Interference Check determined by EPA.';

COMMENT ON COLUMN camdecmps.monitor_hrly_value.calc_f2l_status
    IS 'QA Status for Flow-to-Load Check determined by EPA.';
