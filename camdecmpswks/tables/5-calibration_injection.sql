-- Table: camdecmpswks.calibration_injection

-- DROP TABLE camdecmpswks.calibration_injection;

CREATE TABLE IF NOT EXISTS camdecmpswks.calibration_injection
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
    update_date timestamp without time zone,
    CONSTRAINT pk_calibration_injection PRIMARY KEY (cal_inj_id),
    CONSTRAINT fk_calibration_injection_gas_level_code FOREIGN KEY (upscale_gas_level_cd)
        REFERENCES camdecmpsmd.gas_level_code (gas_level_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_calibration_injection_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);