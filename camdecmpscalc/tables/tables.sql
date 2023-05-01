CREATE TABLE IF NOT EXISTS camdecmpscalc.ae_correlation_test_run
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
	ae_corr_test_run_id character varying(45) NOT NULL,
    calc_total_hi numeric(7,1),
    calc_hourly_hi_rate numeric(7,1),
    CONSTRAINT pk_ae_correlation_test_run PRIMARY KEY (pk),
   	CONSTRAINT fk_ae_correlation_test_run_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.ae_correlation_test_sum
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
	ae_corr_test_sum_id character varying(45) NOT NULL,
    calc_mean_ref_value numeric(8,3),
    calc_avg_hrly_hi_rate numeric(7,1),
    CONSTRAINT pk_ae_correlation_test_sum PRIMARY KEY (pk),
   	CONSTRAINT fk_ae_correlation_test_sum_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.ae_hi_gas
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
	ae_hi_gas_id character varying(45) NOT NULL,
    calc_gas_hi numeric(7,1),
    CONSTRAINT pk_ae_hi_gas PRIMARY KEY (pk),
   	CONSTRAINT fk_ae_hi_gas_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.ae_hi_oil
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
	ae_hi_oil_id character varying(45) NOT NULL,
    calc_oil_hi numeric(7,1),
    calc_oil_mass numeric(10,1),
    CONSTRAINT pk_ae_hi_oil PRIMARY KEY (pk),
    CONSTRAINT fk_ae_hi_oil_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.calibration_injection
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
	cal_inj_id character varying(45) NOT NULL,
    calc_zero_cal_error numeric(6,2),
    calc_zero_aps_ind numeric(38,0),
    calc_upscale_cal_error numeric(6,2),
    calc_upscale_aps_ind numeric(38,0),
    CONSTRAINT pk_calibration_injection PRIMARY KEY (pk),
    CONSTRAINT fk_calibration_injection_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.cycle_time_injection
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
	cycle_time_inj_id character varying(45) NOT NULL,
    calc_injection_cycle_time numeric(2,0),
    CONSTRAINT pk_cycle_time_injection PRIMARY KEY (pk),
    CONSTRAINT fk_cycle_time_injection_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.cycle_time_summary
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
	cycle_time_sum_id character varying(45) NOT NULL,
    calc_total_time numeric(2,0),
    CONSTRAINT pk_cycle_time_summary PRIMARY KEY (pk),
    CONSTRAINT fk_cycle_time_summary_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.daily_calibration
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
	chk_session_id character varying(45) NOT NULL,
	cal_inj_id character varying(45) NOT NULL,
    calc_online_offline_ind numeric(38,0),
    calc_zero_aps_ind numeric(38,0),
    calc_upscale_aps_ind numeric(38,0),
    calc_zero_cal_error numeric(6,2),
    calc_upscale_cal_error numeric(6,2),
    CONSTRAINT pk_daily_calibration PRIMARY KEY (pk),
    CONSTRAINT fk_daily_calibration_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.daily_emission
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
	daily_emission_id character varying(45) NOT NULL,
    calc_total_daily_emission numeric(10,1),
    calc_total_op_time numeric(4,2),
    CONSTRAINT pk_daily_emission PRIMARY KEY (pk),
    CONSTRAINT fk_daily_emission_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.daily_fuel
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    daily_fuel_id character varying(45) NOT NULL,
    calc_fuel_carbon_burned numeric(13,1),
    CONSTRAINT pk_daily_fuel PRIMARY KEY (pk),
    CONSTRAINT fk_daily_fuel_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.daily_test_summary
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    daily_test_sum_id character varying(45) NOT NULL,
    calc_test_result_cd character varying(7),
    CONSTRAINT pk_daily_test_summary PRIMARY KEY (pk),
    CONSTRAINT fk_daily_test_summary_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.derived_hrly_value
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    derv_id character varying(45) NOT NULL,
    calc_unadjusted_hrly_value numeric(13,3),
    calc_adjusted_hrly_value numeric(14,4),
    applicable_bias_adj_factor numeric(5,3),
    calc_pct_diluent character varying(10),
    calc_pct_moisture character varying(10),
    calc_rata_status character varying(75),
    calc_appe_status character varying(75),
    calc_fuel_flow_total numeric(15,4),
    calc_hour_measure_cd character varying(7),
    CONSTRAINT pk_derived_hrly_value PRIMARY KEY (pk),
    CONSTRAINT fk_derived_hrly_value_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.flow_rata_run
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
	flow_rata_run_id character varying(45) NOT NULL,
    calc_dry_molecular_weight numeric(5,2),
    calc_wet_molecular_weight numeric(5,2),
    calc_avg_vel_wo_wall numeric(6,2),
    calc_avg_vel_w_wall numeric(6,2),
    calc_waf numeric(6,4),
    calc_calc_waf numeric(6,4),
    CONSTRAINT pk_flow_rata_run PRIMARY KEY (pk),
    CONSTRAINT fk_flow_rata_run_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.flow_to_load_reference
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    flow_load_ref_id character varying(45) NOT NULL,
    calc_avg_ref_method_flow numeric(10,0),
    calc_avg_gross_unit_load numeric(6,0),
    calc_ref_flow_load_ratio numeric(6,2),
    calc_ref_ghr numeric(6,0),
    calc_sep_ref_ind numeric(38,0),
    CONSTRAINT pk_flow_to_load_reference PRIMARY KEY (pk),
    CONSTRAINT fk_flow_to_load_reference_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.hg_test_summary
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    hg_test_sum_id character varying(45) NOT NULL,
    calc_mean_measured_value numeric(13,3),
    calc_mean_ref_value numeric(13,3),
    calc_percent_error numeric(5,1),
    calc_aps_ind numeric(38,0),
    CONSTRAINT pk_hg_test_summary PRIMARY KEY (pk),
    CONSTRAINT fk_hg_test_summary_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.hrly_fuel_flow
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    hrly_fuel_flow_id character varying(45) NOT NULL,
    calc_mass_flow_rate numeric(10,1),
    calc_volumetric_flow_rate numeric(10,1),
    calc_appd_status character varying(75),
    CONSTRAINT pk_hrly_fuel_flow PRIMARY KEY (pk),
    CONSTRAINT fk_hrly_fuel_flow_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.hrly_gas_flow_meter
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    hrly_gas_flow_meter_id character varying(45) NOT NULL,
    calc_flow_to_sampling_ratio numeric(4,1),
    calc_flow_to_sampling_mult numeric(10,0),
    CONSTRAINT pk_hrly_gas_flow_meter PRIMARY KEY (pk),
    CONSTRAINT fk_hrly_gas_flow_meter_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.hrly_param_fuel_flow
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    hrly_param_ff_id character varying(45) NOT NULL,
    calc_param_val_fuel numeric(13,5),
    calc_appe_status character varying(75),
    CONSTRAINT pk_hrly_param_fuel_flow PRIMARY KEY (pk),
    CONSTRAINT fk_hrly_param_fuel_flow_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.linearity_summary
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
	lin_sum_id character varying(45) NOT NULL,
    calc_mean_ref_value numeric(13,3),
    calc_mean_measured_value numeric(13,3),
    calc_percent_error numeric(5,1),
    calc_aps_ind numeric(38,0),
    CONSTRAINT pk_linearity_summary PRIMARY KEY (pk),
    CONSTRAINT fk_linearity_summary_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.long_term_fuel_flow
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    ltff_id character varying(45) NOT NULL,
    calc_total_heat_input numeric(10,0),
    CONSTRAINT pk_long_term_fuel_flow PRIMARY KEY (pk),
    CONSTRAINT fk_long_term_fuel_flow_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.mats_derived_hrly_value
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    mats_dhv_id character varying(45) NOT NULL,
    calc_unadjusted_hrly_value character varying(30),
    calc_pct_diluent numeric(5,1),
    calc_pct_moisture numeric(5,1),
    CONSTRAINT pk_mats_derived_hrly_value PRIMARY KEY (pk),
    CONSTRAINT fk_mats_derived_hrly_value_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.mats_monitor_hrly_value
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    mats_mhv_id character varying(45) NOT NULL,
    calc_unadjusted_hrly_value character varying(30),
    calc_daily_cal_status character varying(75),
    calc_hg_line_status character varying(75),
    calc_hgi1_status character varying(75),
    calc_rata_status character varying(75),
    CONSTRAINT pk_mats_monitor_hrly_value PRIMARY KEY (pk),
    CONSTRAINT fk_mats_monitor_hrly_value_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.monitor_hrly_value
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    monitor_hrly_val_id character varying(45) NOT NULL,
    calc_adjusted_hrly_value numeric(13,3),
    applicable_bias_adj_factor numeric(5,3),
    calc_line_status character varying(75),
    calc_rata_status character varying(75),
    calc_daycal_status character varying(75),
    calc_leak_status character varying(75),
    calc_dayint_status character varying(75),
    calc_f2l_status character varying(75),
    CONSTRAINT pk_monitor_hrly_value PRIMARY KEY (pk),
    CONSTRAINT fk_monitor_hrly_value_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.on_off_cal
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    on_off_cal_id character varying(45) NOT NULL,
    calc_online_zero_aps_ind numeric(38,0),
    calc_online_zero_cal_error numeric(6,2),
    calc_online_upscale_aps_ind numeric(38,0),
    calc_online_upscale_cal_error numeric(6,2),
    calc_offline_zero_aps_ind numeric(38,0),
    calc_offline_zero_cal_error numeric(6,2),
    calc_offline_upscale_aps_ind numeric(38,0),
    calc_offline_upscale_cal_error numeric(6,2),
    CONSTRAINT pk_on_off_cal PRIMARY KEY (pk),
    CONSTRAINT fk_on_off_cal_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.rata
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
	rata_id character varying(45) NOT NULL,
    calc_rata_frequency_cd character varying(7),
    calc_relative_accuracy numeric(5,2),
    calc_overall_bias_adj_factor numeric(5,3),
    calc_num_load_level numeric(1,0),
    CONSTRAINT pk_rata PRIMARY KEY (pk),
    CONSTRAINT fk_rata_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.rata_run
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
	rata_run_id character varying(45) NOT NULL,
    calc_rata_ref_value numeric(15,5),
    CONSTRAINT pk_rata_run PRIMARY KEY (pk),
    CONSTRAINT fk_rata_run_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.rata_summary
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
	rata_sum_id character varying(45) NOT NULL,
    calc_relative_accuracy numeric(5,2),
    calc_bias_adj_factor numeric(5,3),
    calc_mean_cem_value numeric(15,5),
    calc_mean_rata_ref_value numeric(15,5),
    calc_mean_diff numeric(15,5),
    calc_avg_gross_unit_load numeric(6,0),
    calc_aps_ind numeric(38,0),
    calc_stnd_dev_diff numeric(15,5),
    calc_confidence_coef numeric(15,5),
    calc_t_value numeric(6,3),
    calc_stack_area numeric(6,1),
    calc_waf numeric(6,4),
    calc_calc_waf numeric(6,4),
    CONSTRAINT pk_rata_summary PRIMARY KEY (pk),
    CONSTRAINT fk_rata_summary_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.rata_traverse
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
	rata_traverse_id character varying(45) NOT NULL,
    calc_vel numeric(6,2),
    calc_calc_vel numeric(6,2),
    CONSTRAINT pk_rata_traverse PRIMARY KEY (pk),
    CONSTRAINT fk_rata_traverse_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.sampling_train
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    trap_train_id character varying(45) NOT NULL,
    calc_hg_concentration character varying(30),
    calc_percent_breakthrough numeric(6,1),
    calc_percent_spike_recovery numeric(4,1),
    CONSTRAINT pk_sampling_train PRIMARY KEY (pk),
    CONSTRAINT fk_sampling_train_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.sorbent_trap
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    trap_id character varying(45) NOT NULL,
    calc_paired_trap_agreement numeric(5,2),
    calc_modc_cd character varying(7),
    calc_hg_concentration character varying(30),
    CONSTRAINT pk_sorbent_trap PRIMARY KEY (pk),
    CONSTRAINT fk_sorbent_trap_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.summary_value
(
    pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    mon_loc_id character varying(45) COLLATE pg_catalog."default",
    rpt_period_id numeric(38,0),
    parameter_cd character varying(7) COLLATE pg_catalog."default",
    chk_session_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    calc_current_rpt_period_total numeric(13,3),
    calc_os_total numeric(13,3),
    calc_year_total numeric(13,3),
    CONSTRAINT pk_summary_value PRIMARY KEY (pk),
    CONSTRAINT fk_summary_value_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.test_summary
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
	test_sum_id character varying(45) NOT NULL,
    calc_gp_ind numeric(38,0),
    calc_test_result_cd character varying(7),
    calc_span_value numeric(13,3),
    CONSTRAINT pk_test_summary PRIMARY KEY (pk),
    CONSTRAINT fk_test_summary_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.unit_default_test
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    unit_default_test_sum_id character varying(45) NOT NULL,
    calc_nox_default_rate numeric(6,3),
    CONSTRAINT pk_unit_default_test PRIMARY KEY (pk),
    CONSTRAINT fk_unit_default_test_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.weekly_system_integrity
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    weekly_sys_integrity_id character varying(45) NOT NULL,
    calc_system_integrity_error numeric(5,1),
    calc_aps_ind numeric(38,0),
    CONSTRAINT pk_weekly_system_integrity PRIMARY KEY (pk),
    CONSTRAINT fk_weekly_system_integrity_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.weekly_test_summary
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    weekly_test_sum_id character varying(45) NOT NULL,
    calc_test_result_cd character varying(7),
    CONSTRAINT pk_weekly_test_summary PRIMARY KEY (pk),
    CONSTRAINT fk_weekly_test_summary_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.qa_supp_data
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    test_sum_id character varying(45) NOT NULL,
    test_type_cd character varying(7) NOT NULL,
	mon_loc_id character varying(45) NOT NULL,
    mon_sys_id character varying(45),
    component_id character varying(45),
    test_num character varying(18),
	test_reason_cd character varying(7),
    test_result_cd character varying(7),
    span_scale character varying(10),
    begin_date date,
	begin_hour numeric(2,0),
    begin_min numeric(2,0),
    end_date date,
    end_hour numeric(2,0),
    end_min numeric(2,0),
    rpt_period_id numeric(38,0),
    gp_ind numeric(38,0),
    reinstallation_date date,
    reinstallation_hour numeric(2,0),
    op_level_cd character varying(7),
    operating_condition_cd character varying(7),
    fuel_cd character varying(7),
    CONSTRAINT pk_qa_supp_data PRIMARY KEY (pk),
    CONSTRAINT fk_qa_supp_data_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.qa_supp_attribute
(
	pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    test_sum_id character varying(45) NOT NULL,
    attribute_name character varying(30),
    attribute_value character varying(30),
    CONSTRAINT pk_qa_supp_attribute PRIMARY KEY (pk),
    CONSTRAINT fk_qa_supp_attribute_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.operating_supp_data
(
    pk character varying(45) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v4(),
    parameter_cd character varying(7) COLLATE pg_catalog."default",
    chk_session_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default",
    rpt_period_id numeric(38,0),
    fuel_cd character varying(7) COLLATE pg_catalog."default",
    op_type_cd character varying(7) COLLATE pg_catalog."default",
    op_value numeric(13,3),
    CONSTRAINT pk_ce_osd_id PRIMARY KEY (pk),
    CONSTRAINT fk_summary_value_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.qa_cert_event_supp_data
(
    pk character varying(45) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v4(),
    qa_cert_event_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    qa_cert_event_supp_data_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    qa_cert_event_supp_date_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    count_from_datehour timestamp without time zone NOT NULL,
    count numeric(38,0),
    count_from_included_ind numeric(38,0) NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    chk_session_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_qa_cert_event_supp_data PRIMARY KEY (pk),
    CONSTRAINT fk_qa_cert_event_supp_data_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_qa_cert_event_supp_data_data_cd FOREIGN KEY (qa_cert_event_supp_data_cd)
        REFERENCES camdecmpsmd.qa_cert_event_supp_data_code (qa_cert_event_supp_data_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_qa_cert_event_supp_data_date_cd FOREIGN KEY (qa_cert_event_supp_date_cd)
        REFERENCES camdecmpsmd.qa_cert_event_supp_date_code (qa_cert_event_supp_date_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_qa_cert_event_supp_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_qa_cert_event_supp_data_qa_cert_event FOREIGN KEY (qa_cert_event_id)
        REFERENCES camdecmpswks.qa_cert_event (qa_cert_event_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.system_op_supp_data
(
    pk character varying(45) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v4(),
    mon_sys_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    op_supp_data_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    days numeric(38,0) NOT NULL,
    hours numeric(38,0) NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    chk_session_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_system_op_supp_data PRIMARY KEY (pk),
    CONSTRAINT fk_system_op_supp_data_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_system_op_supp_data_cod FOREIGN KEY (op_supp_data_type_cd)
        REFERENCES camdecmpsmd.op_supp_data_type_code (op_supp_data_type_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_system_op_supp_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_system_op_supp_data_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmpswks.monitor_system (mon_sys_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_system_op_supp_data_prd FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.component_op_supp_data
(
    pk character varying(45) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v4(),
    component_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    op_supp_data_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    days numeric(38,0) NOT NULL,
    hours numeric(38,0) NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone,
    chk_session_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_component_op_supp_data PRIMARY KEY (pk),
    CONSTRAINT fk_component_op_supp_data_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_component_op_supp_data_cod FOREIGN KEY (op_supp_data_type_cd)
        REFERENCES camdecmpsmd.op_supp_data_type_code (op_supp_data_type_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_component_op_supp_data_component FOREIGN KEY (component_id)
        REFERENCES camdecmpswks.component (component_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_component_op_supp_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_component_op_supp_data_prd FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.last_qa_value_supp_data
(
    pk character varying(45) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v4(),
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    parameter_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    moisture_basis character varying(7) COLLATE pg_catalog."default",
    hourly_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    mon_sys_id character varying(45) COLLATE pg_catalog."default",
    component_id character varying(45) COLLATE pg_catalog."default",
    op_datehour timestamp without time zone NOT NULL,
    unadjusted_hrly_value numeric(13,3),
    adjusted_hrly_value numeric(13,3),
    chk_session_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_last_qa_value_supp_data PRIMARY KEY (pk),
    CONSTRAINT fk_last_qa_value_supp_data_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_last_qa_value_supp_data_component FOREIGN KEY (component_id)
        REFERENCES camdecmpswks.component (component_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_last_qa_value_supp_data_ht FOREIGN KEY (hourly_type_cd)
        REFERENCES camdecmpsmd.hourly_type_code (hourly_type_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_last_qa_value_supp_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_last_qa_value_supp_data_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmpswks.monitor_system (mon_sys_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_last_qa_value_supp_data_pc FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_last_qa_value_supp_data_pr FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.daily_test_supp_data
(
    pk character varying(45) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v4(),
    daily_test_sum_id character varying(45) COLLATE pg_catalog."default",
    rpt_period_id numeric(38,0) NOT NULL,
    key_online_ind numeric(1,0) NOT NULL,
    key_valid_ind numeric(1,0) NOT NULL,
    op_hour_cnt numeric(38,0),
    last_covered_nonop_datehour timestamp without time zone,
    first_op_after_nonop_datehour timestamp without time zone,
    sort_daily_test_datehourmin timestamp without time zone,
    calc_test_result_cd character varying(7) COLLATE pg_catalog."default",
    chk_session_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_daily_test_supp_data PRIMARY KEY (pk),
    CONSTRAINT fk_daily_test_supp_data_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_daily_test_supp_data_rpp FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.daily_test_system_supp_data
(
    pk character varying(45) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v4(),
    daily_test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    key_online_ind numeric(1,0) NOT NULL,
    key_valid_ind numeric(1,0) NOT NULL,
    mon_sys_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    op_hour_cnt numeric(38,0) NOT NULL,
    last_covered_nonop_datehour timestamp without time zone,
    first_op_after_nonop_datehour timestamp without time zone,
    chk_session_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_daily_test_sys_sup_data PRIMARY KEY (pk),
    CONSTRAINT fk_daily_test_sys_sup_data_rpp FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_daily_test_system_supp_data_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_daily_test_system_supp_data_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmpswks.monitor_system (mon_sys_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS camdecmpscalc.sampling_train_supp_data
(
    pk character varying(45) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v4(),
    trap_train_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    chk_session_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    sfsr_total_count numeric(38,0),
    sfsr_deviated_count numeric(38,0),
    gfm_total_count numeric(38,0),
    gfm_not_available_count numeric(38,0),
    CONSTRAINT pk_sampling_train_sd PRIMARY KEY (pk),
    CONSTRAINT fk_sampling_train_supp_data_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);