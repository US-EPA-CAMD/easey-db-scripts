-- Table: camdecmps.emission_view_dailycal

-- DROP TABLE camdecmps.emission_view_dailycal;

CREATE TABLE camdecmps.emission_view_dailycal
(
    em_daily_cal_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default",
    component_identifier character varying(3) COLLATE pg_catalog."default",
    component_type_cd character varying(7) COLLATE pg_catalog."default",
    span_scale_cd character varying(7) COLLATE pg_catalog."default",
    end_datetime character varying(25) COLLATE pg_catalog."default",
    rpt_test_result_cd character varying(7) COLLATE pg_catalog."default",
    calc_test_result_cd character varying(7) COLLATE pg_catalog."default",
    applicable_span_value numeric(13,3),
    upscale_gas_level_cd character varying(7) COLLATE pg_catalog."default",
    upscale_injection_date date,
    upscale_injection_time character varying(5) COLLATE pg_catalog."default",
    upscale_measured_value numeric(13,3),
    upscale_ref_value numeric(13,3),
    rpt_upscale_ce_or_mean_diff numeric(6,2),
    rpt_upscale_aps_ind numeric(38,0),
    calc_upscale_ce_or_mean_diff numeric(6,2),
    calc_upscale_aps_ind numeric(38,0),
    zero_injection_date date,
    zero_injection_time character varying(5) COLLATE pg_catalog."default",
    zero_measured_value numeric(13,3),
    zero_ref_value numeric(13,3),
    rpt_zero_ce_or_mean_diff numeric(6,2),
    rpt_zero_aps_ind numeric(38,0),
    calc_zero_ce_or_mean_diff numeric(6,2),
    calc_zero_aps_ind numeric(38,0),
    rpt_online_offline_ind numeric(38,0),
    calc_online_offline_ind numeric(38,0),
    error_codes character varying(1000) COLLATE pg_catalog."default",
    upscale_gas_type_cd character varying(255) COLLATE pg_catalog."default",
    cylinder_id character varying(25) COLLATE pg_catalog."default",
    expiration_date date,
    vendor_id character varying(8) COLLATE pg_catalog."default",
    CONSTRAINT pk_emission_view_dailycal PRIMARY KEY (em_daily_cal_id)
);