-- ------------ Write CREATE-TABLE-stage scripts -----------

CREATE TABLE IF NOT EXISTS camdecmps.calibration_injection(
    cal_inj_id CHARACTER VARYING(45) NOT NULL,
    test_sum_id CHARACTER VARYING(45) NOT NULL,
    online_offline_ind NUMERIC(38,0),
    zero_ref_value NUMERIC(13,3),
    zero_cal_error NUMERIC(6,2),
    calc_zero_cal_error NUMERIC(6,2),
    zero_aps_ind NUMERIC(38,0),
    calc_zero_aps_ind NUMERIC(38,0),
    zero_injection_date DATE,
    zero_injection_hour NUMERIC(2,0),
    zero_injection_min NUMERIC(2,0),
    upscale_ref_value NUMERIC(13,3),
    zero_measured_value NUMERIC(13,3),
    upscale_gas_level_cd CHARACTER VARYING(7),
    upscale_measured_value NUMERIC(13,3),
    upscale_cal_error NUMERIC(6,2),
    calc_upscale_cal_error NUMERIC(6,2),
    upscale_aps_ind NUMERIC(38,0),
    calc_upscale_aps_ind NUMERIC(38,0),
    upscale_injection_date DATE,
    upscale_injection_hour NUMERIC(2,0),
    upscale_injection_min NUMERIC(2,0),
    userid CHARACTER VARYING(8),
    add_date TIMESTAMP WITHOUT TIME ZONE,
    update_date TIMESTAMP WITHOUT TIME ZONE
)
        WITH (
        OIDS=FALSE
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



-- ------------ Write CREATE-INDEX-stage scripts -----------

CREATE INDEX idx_calibration_inj_upscale_ga
ON camdecmps.calibration_injection
USING BTREE (upscale_gas_level_cd ASC);



CREATE INDEX idx_calibration_injection_001
ON camdecmps.calibration_injection
USING BTREE (test_sum_id ASC);



-- ------------ Write CREATE-CONSTRAINT-stage scripts -----------

ALTER TABLE camdecmps.calibration_injection
ADD CONSTRAINT pk_calibration_injection PRIMARY KEY (cal_inj_id);



-- ------------ Write CREATE-FOREIGN-KEY-CONSTRAINT-stage scripts -----------

ALTER TABLE camdecmps.calibration_injection
ADD CONSTRAINT fk_gas_level_cod_calibration_i FOREIGN KEY (upscale_gas_level_cd) 
REFERENCES camdecmpsmd.gas_level_code (gas_level_cd)
ON DELETE NO ACTION;



ALTER TABLE camdecmps.calibration_injection
ADD CONSTRAINT fk_test_summary_calibration_i FOREIGN KEY (test_sum_id) 
REFERENCES camdecmps.test_summary (test_sum_id)
ON DELETE NO ACTION;
