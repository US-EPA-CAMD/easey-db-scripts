-- Table: camdecmpswks.on_off_cal

-- DROP TABLE camdecmpswks.on_off_cal;

CREATE TABLE IF NOT EXISTS camdecmpswks.on_off_cal
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
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_on_off_cal PRIMARY KEY (on_off_cal_id),
    CONSTRAINT fk_on_off_cal_gas_level_code FOREIGN KEY (upscale_gas_level_cd)
        REFERENCES camdecmpsmd.gas_level_code (gas_level_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_on_off_cal_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- -- Index: idx_on_off_cal_001

-- -- DROP INDEX camdecmpswks.idx_on_off_cal_001;

-- CREATE INDEX idx_on_off_cal_001
--     ON camdecmpswks.on_off_cal USING btree
--     (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- -- Index: idx_on_off_cal_upscale_ga

-- -- DROP INDEX camdecmpswks.idx_on_off_cal_upscale_ga;

-- CREATE INDEX idx_on_off_cal_upscale_ga
--     ON camdecmpswks.on_off_cal USING btree
--     (upscale_gas_level_cd COLLATE pg_catalog."default" ASC NULLS LAST);
