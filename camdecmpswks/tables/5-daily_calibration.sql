-- Table: camdecmpswks.daily_calibration

-- DROP TABLE camdecmpswks.daily_calibration;

CREATE TABLE camdecmpswks.daily_calibration
(
    cal_inj_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    daily_test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    online_offline_ind numeric(38,0),
    calc_online_offline_ind numeric(38,0),
    upscale_gas_level_cd character varying(7) COLLATE pg_catalog."default",
    zero_injection_date date,
    zero_injection_hour numeric(2,0),
    zero_injection_min numeric(2,0),
    upscale_injection_date date,
    upscale_injection_hour numeric(2,0),
    upscale_injection_min numeric(2,0),
    zero_measured_value numeric(13,3),
    upscale_measured_value numeric(13,3),
    zero_aps_ind numeric(38,0),
    calc_zero_aps_ind numeric(38,0),
    upscale_aps_ind numeric(38,0),
    calc_upscale_aps_ind numeric(38,0),
    zero_cal_error numeric(6,2),
    calc_zero_cal_error numeric(6,2),
    upscale_cal_error numeric(6,2),
    calc_upscale_cal_error numeric(6,2),
    zero_ref_value numeric(13,3),
    upscale_ref_value numeric(13,3),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    rpt_period_id numeric(38,0),
    upscale_gas_type_cd character varying(255) COLLATE pg_catalog."default",
    vendor_id character varying(8) COLLATE pg_catalog."default",
    cylinder_identifier character varying(25) COLLATE pg_catalog."default",
    expiration_date date,
    injection_protocol_cd character varying(7) COLLATE pg_catalog."default",
    CONSTRAINT pk_daily_calibration PRIMARY KEY (cal_inj_id),
    CONSTRAINT fk_daily_calibration_daily_test_summary FOREIGN KEY (daily_test_sum_id)
        REFERENCES camdecmpswks.daily_test_summary (daily_test_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_daily_calibration_gas_level_code FOREIGN KEY (upscale_gas_level_cd)
        REFERENCES camdecmpsmd.gas_level_code (gas_level_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_daily_calibration_gas_type_code FOREIGN KEY (upscale_gas_type_cd)
        REFERENCES camdecmpsmd.gas_type_code (gas_type_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_daily_calibration_injection_protocol_code FOREIGN KEY (injection_protocol_cd)
        REFERENCES camdecmpsmd.injection_protocol_code (injection_protocol_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_daily_calibration_protocol_gas_vendor FOREIGN KEY (vendor_id)
        REFERENCES camdecmps.protocol_gas_vendor (vendor_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_daily_calibration_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmpswks.daily_calibration
    IS 'Daily calibration test data and results. Each record in this table contains a single day''s test for both low and high injection test results.  Record Type 230.';

COMMENT ON COLUMN camdecmpswks.daily_calibration.cal_inj_id
    IS 'Unique identifier for a daily calibration injection record. ';

COMMENT ON COLUMN camdecmpswks.daily_calibration.daily_test_sum_id
    IS 'Unique identifier of a daily test summary record. ';

COMMENT ON COLUMN camdecmpswks.daily_calibration.online_offline_ind
    IS 'Indicates whether the unit or stack is operating at the time of the test. ';

COMMENT ON COLUMN camdecmpswks.daily_calibration.calc_online_offline_ind
    IS 'Indicates whether the unit or stack is operating at the time of the test. ';

COMMENT ON COLUMN camdecmpswks.daily_calibration.upscale_gas_level_cd
    IS 'Code used to identify upscale gas level. ';

COMMENT ON COLUMN camdecmpswks.daily_calibration.zero_injection_date
    IS 'Date of zero level injection. ';

COMMENT ON COLUMN camdecmpswks.daily_calibration.zero_injection_hour
    IS 'Hour of zero level injection. ';

COMMENT ON COLUMN camdecmpswks.daily_calibration.zero_injection_min
    IS 'Zero Injection Minute. ';

COMMENT ON COLUMN camdecmpswks.daily_calibration.upscale_injection_date
    IS 'Date of upscale injection. ';

COMMENT ON COLUMN camdecmpswks.daily_calibration.upscale_injection_hour
    IS 'Hour of upscale injection. ';

COMMENT ON COLUMN camdecmpswks.daily_calibration.upscale_injection_min
    IS 'Upscale Injection Minute ';

COMMENT ON COLUMN camdecmpswks.daily_calibration.zero_measured_value
    IS 'Zero level measured value. ';

COMMENT ON COLUMN camdecmpswks.daily_calibration.upscale_measured_value
    IS 'Upscale measured value. ';

COMMENT ON COLUMN camdecmpswks.daily_calibration.zero_aps_ind
    IS 'Used to indicate if the alternative performance specification (APS) is used. ';

COMMENT ON COLUMN camdecmpswks.daily_calibration.calc_zero_aps_ind
    IS 'Used to indicate if the alternative performance specification (APS) is used. ';

COMMENT ON COLUMN camdecmpswks.daily_calibration.upscale_aps_ind
    IS 'Used to indicate if the alternative performance specification (APS) is used. ';

COMMENT ON COLUMN camdecmpswks.daily_calibration.calc_upscale_aps_ind
    IS 'Used to indicate if the alternative performance specification (APS) is used. ';

COMMENT ON COLUMN camdecmpswks.daily_calibration.zero_cal_error
    IS 'Reported zero level calibration error. ';

COMMENT ON COLUMN camdecmpswks.daily_calibration.calc_zero_cal_error
    IS 'Reported zero level calibration error. ';

COMMENT ON COLUMN camdecmpswks.daily_calibration.upscale_cal_error
    IS 'Reported upscale level calibration error. ';

COMMENT ON COLUMN camdecmpswks.daily_calibration.calc_upscale_cal_error
    IS 'Reported upscale level calibration error. ';

COMMENT ON COLUMN camdecmpswks.daily_calibration.zero_ref_value
    IS 'Zero level reference value. ';

COMMENT ON COLUMN camdecmpswks.daily_calibration.upscale_ref_value
    IS 'Upscale reference value. ';

COMMENT ON COLUMN camdecmpswks.daily_calibration.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmpswks.daily_calibration.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmpswks.daily_calibration.update_date
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmpswks.daily_calibration.rpt_period_id
    IS 'Unique identifier of a reporting period record.';

COMMENT ON COLUMN camdecmpswks.daily_calibration.upscale_gas_type_cd
    IS 'Code used to identify the contents of the Upscale calibration gas cylinder';

COMMENT ON COLUMN camdecmpswks.daily_calibration.vendor_id
    IS 'EPA-assigned identifier of the PGVP vendor';

COMMENT ON COLUMN camdecmpswks.daily_calibration.cylinder_identifier
    IS 'Identifier stamped on the Upscale gas cylinder';

COMMENT ON COLUMN camdecmpswks.daily_calibration.expiration_date
    IS 'Date of Expiration of the upscale gas cylinder.';

COMMENT ON COLUMN camdecmpswks.daily_calibration.injection_protocol_cd
    IS 'Injection Protocol code. ';
-- Index: daily_calibration_indx001

-- DROP INDEX camdecmpswks.daily_calibration_indx001;

CREATE INDEX daily_calibration_indx001
    ON camdecmpswks.daily_calibration USING btree
    (rpt_period_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_daily_calibrati_daily_test

-- DROP INDEX camdecmpswks.idx_daily_calibrati_daily_test;

CREATE INDEX idx_daily_calibrati_daily_test
    ON camdecmpswks.daily_calibration USING btree
    (daily_test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_daily_calibration_0002

-- DROP INDEX camdecmpswks.idx_daily_calibration_0002;

CREATE INDEX idx_daily_calibration_0002
    ON camdecmpswks.daily_calibration USING btree
    (vendor_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_dcal_add_date

-- DROP INDEX camdecmpswks.idx_dcal_add_date;

CREATE INDEX idx_dcal_add_date
    ON camdecmpswks.daily_calibration USING btree
    (add_date ASC NULLS LAST)
    TABLESPACE pg_default;