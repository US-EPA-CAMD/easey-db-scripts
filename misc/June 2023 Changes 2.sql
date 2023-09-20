ALTER TABLE camdecmps.hrly_param_fuel_flow
    DROP CONSTRAINT fk_hrly_fuel_flo_hrly_param_fu,
    DROP CONSTRAINT fk_monitor_formu_hrly_param_fu,
    DROP CONSTRAINT fk_monitor_syste_hrly_param_fu,
    DROP CONSTRAINT fk_operating_con_hrly_param_fu,
    DROP CONSTRAINT fk_parameter_cod_hrly_param_fu,
    DROP CONSTRAINT fk_sample_type_c_hrly_param_fu,
    DROP CONSTRAINT fk_units_of_meas_hrly_param_fu;

ALTER TABLE camdecmps.hrly_op_data
    DROP CONSTRAINT fk_fuel_code_hrly_op_data,
    DROP CONSTRAINT fk_monitor_locat_hrly_op_data,
    DROP CONSTRAINT fk_operating_con_hrly_op_data,
    DROP CONSTRAINT fk_reporting_per_hrly_op_data,
    DROP CONSTRAINT fk_units_of_meas_hrly_op_data;

ALTER TABLE camdecmps.hrly_op_data
    DROP CONSTRAINT hrly_op_data_begin_date_check,
    DROP CONSTRAINT hrly_op_data_begin_hour_check,
    DROP CONSTRAINT hrly_op_data_hour_id_check,
    DROP CONSTRAINT hrly_op_data_mon_loc_id_check,
    DROP CONSTRAINT hrly_op_data_rpt_period_id_check;

ALTER TABLE camdecmps.analyzer_range
    DROP CONSTRAINT fk_analyzer_rang_analyzer_rang,
    DROP CONSTRAINT fk_component_analyzer_rang;

ALTER TABLE camdecmps.analyzer_range
    DROP CONSTRAINT analyzer_range_c01;

ALTER TABLE camdecmps.analyzer_range
    ADD CONSTRAINT ck_analyzer_range_begin_date_end_date CHECK (begin_date <= end_date);

ALTER TABLE camdecmps.weekly_system_integrity
    DROP CONSTRAINT fk_wsi_gas_level_cd,
    DROP CONSTRAINT fk_wsi_test_sum_id;

ALTER TABLE camdecmps.monitor_plan_comment
    DROP CONSTRAINT fk_monitor_plan_comment_monitor_plan,
    ADD CONSTRAINT fk_monitor_plan_comment_monitor_plan FOREIGN KEY ( mon_plan_id ) REFERENCES camdecmps.monitor_plan ( mon_plan_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.daily_calibration
    DROP CONSTRAINT fk_daily_cal_vendor_id,
    DROP CONSTRAINT fk_daily_test_su_daily_calibra;

ALTER TABLE camdecmps.cycle_time_injection
    DROP CONSTRAINT fk_cycle_time_su_cycle_time_in,
    DROP CONSTRAINT fk_gas_level_cod_cycle_time_in;

ALTER TABLE camdecmps.ae_correlation_test_run
    DROP CONSTRAINT fk_ae_correlatio_ae_correlatio;

ALTER TABLE camdecmps.daily_fuel
    DROP CONSTRAINT daily_fuel_r02;

ALTER TABLE camdecmps.daily_fuel RENAME CONSTRAINT daily_fuel_pk TO pk_daily_fuel;

ALTER TABLE camdecmps.weekly_test_summary
    DROP CONSTRAINT fk_wts_component_id,
    DROP CONSTRAINT fk_wts_mon_loc_id,
    DROP CONSTRAINT fk_wts_mon_sys_id,
    DROP CONSTRAINT fk_wts_rpt_period_id,
    DROP CONSTRAINT fk_wts_span_scale_cd,
    DROP CONSTRAINT fk_wts_test_result_cd,
    DROP CONSTRAINT fk_wts_test_type_cd;

ALTER TABLE camdecmps.unit_fuel
    DROP CONSTRAINT fk_unit_fuel_dem_gcv,
    DROP CONSTRAINT fk_unit_fuel_dem_so2,
    DROP CONSTRAINT fk_unit_fuel_fuel_ind,
    DROP CONSTRAINT fk_unit_fuel_fuel_type,
    DROP CONSTRAINT fk_unit_fuel_unit_id;

ALTER TABLE camdecmps.unit_fuel
    DROP CONSTRAINT ck_act_or_proj_cd;

ALTER TABLE camdecmps.unit_fuel
    ADD CONSTRAINT ck_unit_fuel_act_or_proj_cd CHECK (act_or_proj_cd::text = ANY (ARRAY['A'::character varying::text, 'P'::character varying::text, NULL::character varying::text]));

ALTER TABLE camdecmps.unit_default_test_run
    DROP CONSTRAINT fk_unt_default_t_unit_default_;

ALTER TABLE camdecmps.unit_control
    DROP CONSTRAINT fk_unit_control_ce_param,
    DROP CONSTRAINT fk_unit_control_indicator_cd,
    DROP CONSTRAINT fk_unit_control_unit_id;

ALTER TABLE camdecmps.sampling_train
    DROP CONSTRAINT fk_train_component_id,
    DROP CONSTRAINT fk_train_leak_result_cd,
    DROP CONSTRAINT fk_train_mon_loc_id,
    DROP CONSTRAINT fk_train_rpt_period_id,
    DROP CONSTRAINT fk_train_sfsr_result_cd,
    DROP CONSTRAINT fk_train_sorbent_trap_id;

ALTER TABLE camdecmps.test_qualification
    DROP CONSTRAINT fk_test_claim_co_test_qualific,
    DROP CONSTRAINT fk_test_summary_test_qualific;

ALTER TABLE camdecmps.system_op_supp_data
    DROP CONSTRAINT fk_system_op_supp_data_cmp,
    DROP CONSTRAINT fk_system_op_supp_data_loc;

ALTER TABLE camdecmps.sorbent_trap
    DROP CONSTRAINT fk_st_aps_cd,
    DROP CONSTRAINT fk_st_modc_cd,
    DROP CONSTRAINT fk_st_mon_loc_id,
    DROP CONSTRAINT fk_st_mon_sys_id,
    DROP CONSTRAINT fk_st_rpt_period_id;

ALTER TABLE camdecmps.sorbent_trap_supp_data
    DROP CONSTRAINT fk_st_supp_data_mon_loc_id,
    DROP CONSTRAINT fk_st_supp_data_mon_sys_id;

ALTER TABLE camdecmps.sampling_train_supp_data
    DROP CONSTRAINT fk_sampling_train_sd_cmp,
    DROP CONSTRAINT fk_sampling_train_sd_loc,
    DROP CONSTRAINT fk_sampling_train_sd_trp;

ALTER TABLE camdecmps.rata_run
    DROP CONSTRAINT fk_rata_summary_rata_run,
    DROP CONSTRAINT fk_run_status_co_rata_run;

ALTER TABLE camdecmps.rata
    DROP CONSTRAINT fk_rata_frequenc_rata,
    DROP CONSTRAINT fk_rata_frequenc_rata2,
    DROP CONSTRAINT fk_test_summary_rata;

ALTER TABLE camdecmps.qa_supp_attribute
    DROP CONSTRAINT fk_qa_supp_data_qa_supp_attri;

ALTER TABLE camdecmps.qa_cert_event_supp_data
    DROP CONSTRAINT fk_qa_cert_event_supp_data_ce,
    DROP CONSTRAINT fk_qa_cert_event_supp_data_da,
    DROP CONSTRAINT fk_qa_cert_event_supp_data_de,
    DROP CONSTRAINT fk_qa_cert_event_supp_data_ml;

ALTER TABLE camdecmps.rata_summary
    DROP CONSTRAINT fk_operating_lev_rata_summary,
    DROP CONSTRAINT fk_rata_rata_summary,
    DROP CONSTRAINT fk_rata_summary_aps,
    DROP CONSTRAINT fk_ref_method_co_rata_sum180,
    DROP CONSTRAINT fk_ref_method_co_rata_summary;

ALTER TABLE camdecmps.stack_pipe
    DROP CONSTRAINT fk_stack_pipe_fac;

ALTER TABLE camdecmps.summary_value
    DROP CONSTRAINT fk_monitor_locat_summary_value,
    DROP CONSTRAINT fk_parameter_cod_summary_value,
    DROP CONSTRAINT fk_reporting_per_summary_value;

ALTER TABLE camdecmps.summary_value
    DROP CONSTRAINT summary_value_u01;

ALTER TABLE camdecmps.rect_duct_waf
    DROP CONSTRAINT fk_monitor_locat_rect_duct_waf,
    DROP CONSTRAINT fk_waf_method_co_rect_duct_waf;

ALTER TABLE camdecmps.system_fuel_flow
    DROP CONSTRAINT fk_max_rate_sour_system_fuel_f,
    DROP CONSTRAINT fk_monitor_syste_system_fuel_f,
    DROP CONSTRAINT fk_units_of_meas_system_fuel_f;

ALTER TABLE camdecmps.unit_default_test
    DROP CONSTRAINT fk_fuel_code_unt_default_t,
    DROP CONSTRAINT fk_operating_con_unt_default_t,
    DROP CONSTRAINT fk_test_summary_unt_default_t;

ALTER TABLE camdecmps.rata_traverse
    DROP CONSTRAINT fk_flow_rata_run_rata_traverse,
    DROP CONSTRAINT fk_pressure_meas_rata_traverse,
    DROP CONSTRAINT fk_probe_type_co_rata_traverse;

ALTER TABLE camdecmps.test_summary
    DROP CONSTRAINT fk_component_test_summary,
    DROP CONSTRAINT fk_monitor_locat_test_summary,
    DROP CONSTRAINT fk_monitor_syste_test_summary,
    DROP CONSTRAINT fk_reporting_per_test_summary,
    DROP CONSTRAINT fk_span_scale_test_summary,
    DROP CONSTRAINT fk_test_reason_c_test_summary,
    DROP CONSTRAINT fk_test_result_c_test_sum205,
    DROP CONSTRAINT fk_test_result_c_test_summary,
    DROP CONSTRAINT fk_test_summary_inj_protocol,
    DROP CONSTRAINT fk_test_type_cod_test_summary;

ALTER TABLE camdecmps.test_summary
    DROP CONSTRAINT test_summary_u01;

ALTER TABLE camdecmps.test_extension_exemption
    DROP CONSTRAINT fk_component_test_extensio,
    DROP CONSTRAINT fk_extension_exe_test_extensio,
    DROP CONSTRAINT fk_fuel_code_test_extensio,
    DROP CONSTRAINT fk_monitor_locat_test_extensio,
    DROP CONSTRAINT fk_monitor_syste_test_extensio,
    DROP CONSTRAINT fk_reporting_per_test_extensio,
    DROP CONSTRAINT fk_span_scale_test_extensio,
    DROP CONSTRAINT fk_submission_av_test_extensio;

ALTER TABLE camdecmps.qa_supp_data
    DROP CONSTRAINT fk_component_qa_supp_data,
    DROP CONSTRAINT fk_fuel_code_qa_supp_data,
    DROP CONSTRAINT fk_monitor_locat_qa_supp_data,
    DROP CONSTRAINT fk_monitor_syste_qa_supp_data,
    DROP CONSTRAINT fk_operating_con_qa_supp_data,
    DROP CONSTRAINT fk_operating_lev_qa_supp_data,
    DROP CONSTRAINT fk_reporting_per_qa_supp_data,
    DROP CONSTRAINT fk_submission_av_qa_supplement,
    DROP CONSTRAINT fk_test_reason_c_qa_supp_data,
    DROP CONSTRAINT fk_test_result_c_qa_supp_data,
    DROP CONSTRAINT fk_test_type_cod_qa_supp_data,
    DROP CONSTRAINT qa_supp_data_r01;

ALTER TABLE camdecmps.qa_cert_event
    DROP CONSTRAINT fk_component_qa_cert_event,
    DROP CONSTRAINT fk_monitor_locat_qa_cert_event,
    DROP CONSTRAINT fk_monitor_syste_qa_cert_event,
    DROP CONSTRAINT fk_qa_cert_event_qa_cert_event,
    DROP CONSTRAINT fk_required_test_qa_cert_event,
    DROP CONSTRAINT fk_submission_av_qa_cert_event;

ALTER TABLE camdecmps.trans_accuracy
    DROP CONSTRAINT fk_accuracy_spec_trans_accura1,
    DROP CONSTRAINT fk_accuracy_spec_trans_accura2,
    DROP CONSTRAINT fk_accuracy_spec_trans_accura3,
    DROP CONSTRAINT fk_test_summary_trans_accurac;

ALTER TABLE camdecmps.unit_stack_configuration
    DROP CONSTRAINT fk_unit_stack_configuration_sp,
    DROP CONSTRAINT fk_unit_stack_configuration_un;

ALTER TABLE camdecmps.monitor_qualification_pct
    DROP CONSTRAINT fk_monitor_qualification_pct_monitor_qualification,
    ADD CONSTRAINT fk_monitor_qualification_pct_monitor_qualification FOREIGN KEY ( mon_qual_id ) REFERENCES camdecmps.monitor_qualification ( mon_qual_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.monitor_qualification_lme
    DROP CONSTRAINT fk_monitor_qualification_lme_monitor_qualification,
    ADD CONSTRAINT fk_monitor_qualification_lme_monitor_qualification FOREIGN KEY ( mon_qual_id ) REFERENCES camdecmps.monitor_qualification ( mon_qual_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.monitor_qualification_lee
    DROP CONSTRAINT fk_monitor_qualification_lee_monitor_qualification,
    ADD CONSTRAINT fk_monitor_qualification_lee_monitor_qualification FOREIGN KEY ( mon_qual_id ) REFERENCES camdecmps.monitor_qualification ( mon_qual_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.monitor_qualification
    DROP CONSTRAINT fk_monitor_qualification_monitor_location,
    ADD CONSTRAINT fk_monitor_qualification_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.monitor_plan
    DROP CONSTRAINT fk_reporting_per_monitor_plan,
    DROP CONSTRAINT fk_reporting_per_monitor_plan2,
    DROP CONSTRAINT fk_submission_av_monitor_plan,
    DROP CONSTRAINT monitor_plan_r03;

ALTER TABLE camdecmps.mats_monitor_hrly_value
    DROP CONSTRAINT fk_mmhv_component_id,
    DROP CONSTRAINT fk_mmhv_hour_id,
    DROP CONSTRAINT fk_mmhv_modc_cd,
    DROP CONSTRAINT fk_mmhv_mon_loc_id,
    DROP CONSTRAINT fk_mmhv_mon_sys_id,
    DROP CONSTRAINT fk_mmhv_parameter_cd,
    DROP CONSTRAINT fk_mmhv_rpt_period_id;

ALTER TABLE camdecmps.mats_derived_hrly_value
    DROP CONSTRAINT fk_mdhv_hour_id,
    DROP CONSTRAINT fk_mdhv_modc_cd,
    DROP CONSTRAINT fk_mdhv_mon_form_id,
    DROP CONSTRAINT fk_mdhv_mon_loc_id,
    DROP CONSTRAINT fk_mdhv_parameter_cd,
    DROP CONSTRAINT fk_mdhv_rpt_period_id;

ALTER TABLE camdecmps.mats_derived_hrly_value RENAME CONSTRAINT pk_matsdhv TO pk_mats_derived_hrly_value;

ALTER TABLE camdecmps.mats_method_data
    DROP CONSTRAINT fk_mats_method_data_mats_mc,
    DROP CONSTRAINT fk_mats_method_data_mon_loc,
    DROP CONSTRAINT fk_mats_method_data_par_code;

ALTER TABLE camdecmps.monitor_location_attribute
    DROP CONSTRAINT fk_material_code_monitor_locat,
    DROP CONSTRAINT fk_monitor_locat_monitor_locat,
    DROP CONSTRAINT fk_shape_code_monitor_locat;

ALTER TABLE camdecmps.linearity_injection
    DROP CONSTRAINT fk_linearity_sum_linearity_inj;

ALTER TABLE camdecmps.monitor_plan_location
    DROP CONSTRAINT monitor_plan_location_u01;

ALTER TABLE camdecmps.hrly_gas_flow_meter
    DROP CONSTRAINT fk_gfm_component_id,
    DROP CONSTRAINT fk_gfm_hour_id,
    DROP CONSTRAINT fk_gfm_mon_loc_id,
    DROP CONSTRAINT fk_gfm_rpt_period_id;

ALTER TABLE camdecmps.on_off_cal
    DROP CONSTRAINT fk_gas_level_cod_on_off_cal,
    DROP CONSTRAINT fk_test_summary_on_off_cal;

ALTER TABLE camdecmps.linearity_summary
    DROP CONSTRAINT fk_gas_level_cod_linearity_sum,
    DROP CONSTRAINT fk_test_summary_linearity_sum;

ALTER TABLE camdecmps.protocol_gas
    DROP CONSTRAINT fk_gas_level_cd,
    DROP CONSTRAINT fk_test_summary_protocol_gas,
    DROP CONSTRAINT fk_vendor_id;

ALTER TABLE camdecmps.operating_supp_data
    DROP CONSTRAINT fk_monitor_locat_operating_sup;

ALTER TABLE camdecmps.monitor_formula
    DROP CONSTRAINT fk_equation_code_monitor_formu,
    DROP CONSTRAINT fk_monitor_locat_monitor_formu,
    DROP CONSTRAINT fk_parameter_cod_monitor_formu;

ALTER TABLE camdecmps.monitor_default
    DROP CONSTRAINT fk_default_purpo_monitor_defau,
    DROP CONSTRAINT fk_default_sourc_monitor_defau,
    DROP CONSTRAINT fk_fuel_code_monitor_defau,
    DROP CONSTRAINT fk_monitor_locat_monitor_defau,
    DROP CONSTRAINT fk_operating_con_monitor_defau,
    DROP CONSTRAINT fk_parameter_cod_monitor_defau,
    DROP CONSTRAINT fk_units_of_meas_monitor_defau;

ALTER TABLE camdecmps.monitor_span
    DROP CONSTRAINT fk_component_typ_monitor_span,
    DROP CONSTRAINT fk_monitor_locat_monitor_span,
    DROP CONSTRAINT fk_span_method_c_monitor_span,
    DROP CONSTRAINT fk_span_scale_co_monitor_span,
    DROP CONSTRAINT fk_units_of_meas_monitor_span;

ALTER TABLE camdecmps.monitor_location
    DROP CONSTRAINT fk_monitor_location_stp,
    DROP CONSTRAINT fk_monitor_location_unt;

ALTER TABLE camdecmps.monitor_system_component
    DROP CONSTRAINT fk_component_monitor_syste,
    DROP CONSTRAINT fk_monitor_syste_monitor_syste;

ALTER TABLE camdecmps.monitor_system_component RENAME CONSTRAINT monitor_system_component_pk TO pk_monitor_system_component;

ALTER TABLE camdecmps.monitor_plan_reporting_freq
    DROP CONSTRAINT fk_monitor_plan_monitor_plan2,
    DROP CONSTRAINT fk_report_freq_co_monitor_plan,
    DROP CONSTRAINT fk_report_perio_monitor_pla2,
    DROP CONSTRAINT fk_report_perio_monitor_plan;

ALTER TABLE camdecmps.monitor_load
    DROP CONSTRAINT fk_monitor_locat_monitor_load;

ALTER TABLE camdecmps.monitor_hrly_value
    DROP CONSTRAINT fk_modc_code_monitor_hrly_,
    DROP CONSTRAINT fk_monitor_syste_component,
    DROP CONSTRAINT fk_monitor_syste_monitor_hrly,
    DROP CONSTRAINT fk_parameter_cod_monitor_hrly_,
    DROP CONSTRAINT monitor_hrly_value_r01;

ALTER TABLE camdecmps.last_qa_value_supp_data
    DROP CONSTRAINT fk_last_qa_value_supp_data_cp,
    DROP CONSTRAINT fk_last_qa_value_supp_data_ml,
    DROP CONSTRAINT fk_last_qa_value_supp_data_ms;

ALTER TABLE camdecmps.monitor_method
    DROP CONSTRAINT fk_bypass_approa_monitor_metho,
    DROP CONSTRAINT fk_method_code_monitor_metho,
    DROP CONSTRAINT fk_monitor_locat_monitor_metho,
    DROP CONSTRAINT fk_parameter_cod_monitor_metho,
    DROP CONSTRAINT fk_substitute_da_monitor_metho;

ALTER TABLE camdecmps.fuel_flow_to_load_baseline
    DROP CONSTRAINT fk_test_summary_fuel_flow_to_,
    DROP CONSTRAINT fk_units_of_meas_fuel_flow_to1,
    DROP CONSTRAINT fk_units_of_meas_fuel_flow_to2;

ALTER TABLE camdecmps.fuel_flow_to_load_check
    DROP CONSTRAINT fk_test_basis_fuel_flow_to,
    DROP CONSTRAINT fk_test_summary_fuel_flow116;

ALTER TABLE camdecmps.flow_to_load_check
    DROP CONSTRAINT fk_operating_lev_flow_to_load,
    DROP CONSTRAINT fk_test_basis_flow_to_load_che,
    DROP CONSTRAINT fk_test_summary_flow_to_l103;

ALTER TABLE camdecmps.nsps4t_compliance_period
    DROP CONSTRAINT fk_nsps4t_compliance_prd_loc,
    DROP CONSTRAINT fk_nsps4t_compliance_prd_prd,
    DROP CONSTRAINT fk_nsps4t_compliance_prd_sum,
    DROP CONSTRAINT fk_nsps4t_compliance_prd_uom;

ALTER TABLE camdecmps.nsps4t_compliance_period RENAME CONSTRAINT pk_nsps4t_compliance_prd TO pk_nsps4t_compliance_period;

ALTER TABLE camdecmps.nsps4t_summary
    DROP CONSTRAINT fk_nsps4t_summary_loc,
    DROP CONSTRAINT fk_nsps4t_summary_lod,
    DROP CONSTRAINT fk_nsps4t_summary_prd,
    DROP CONSTRAINT fk_nsps4t_summary_stn,
    DROP CONSTRAINT fk_nsps4t_summary_uom;

ALTER TABLE camdecmps.hg_test_injection
    DROP CONSTRAINT fk_hg_test_inj_hg_test_sum_id;

ALTER TABLE camdecmps.hg_test_summary
    DROP CONSTRAINT fk_hg_test_sum_gas_level_cd,
    DROP CONSTRAINT fk_hg_test_sum_hg_test_sum_id;

ALTER TABLE camdecmps.hrly_fuel_flow
    DROP CONSTRAINT fk_fuel_code_hrly_fuel_flo,
    DROP CONSTRAINT fk_monitor_syste_hrly_fuel_flo,
    DROP CONSTRAINT fk_sod_mass_code_hrly_fuel_flo,
    DROP CONSTRAINT fk_sod_volumetri_hrly_fuel_flo,
    DROP CONSTRAINT fk_units_of_meas_hrly_fuel_flo,
    DROP CONSTRAINT hrly_fuel_flow_r01;

ALTER TABLE camdecmps.flow_rata_run
    DROP CONSTRAINT fk_rata_run_flow_rata_run;

ALTER TABLE camdecmps.fuel_flowmeter_accuracy
    DROP CONSTRAINT fk_accuracy_test_fuel_flowmete,
    DROP CONSTRAINT fk_test_summary_fuel_flowmete;

ALTER TABLE camdecmps.flow_to_load_reference
    DROP CONSTRAINT fk_operating_lev_flow_to_load_,
    DROP CONSTRAINT fk_test_summary_flow_to_load_;

ALTER TABLE camdecmps.nsps4t_annual
    DROP CONSTRAINT fk_nsps4t_annual_loc,
    DROP CONSTRAINT fk_nsps4t_annual_prd,
    DROP CONSTRAINT fk_nsps4t_annual_sum,
    DROP CONSTRAINT fk_nsps4t_annual_uom;

ALTER TABLE camdecmps.long_term_fuel_flow
    DROP CONSTRAINT fk_fuel_flow_per_long_term_fue,
    DROP CONSTRAINT fk_monitor_locat_long_term_fue,
    DROP CONSTRAINT fk_monitor_syste_long_term_fue,
    DROP CONSTRAINT fk_reporting_per_long_term_fue,
    DROP CONSTRAINT fk_units_of_meas_long_term_fu2,
    DROP CONSTRAINT fk_units_of_meas_long_term_fue;

ALTER TABLE camdecmps.monitor_system
    DROP CONSTRAINT fk_fuel_code_monitor_syste,
    DROP CONSTRAINT fk_monitor_locat_monitor_syste,
    DROP CONSTRAINT fk_system_design_monitor_syste,
    DROP CONSTRAINT fk_system_type_c_monitor_syste;

ALTER TABLE camdecmps.emission_evaluation
    DROP CONSTRAINT fk_monitor_plan_emission_eval,
    DROP CONSTRAINT fk_reporting_per_emission_eval,
    DROP CONSTRAINT fk_submission_av_emission_eval;

ALTER TABLE camdecmps.daily_test_supp_data
    DROP CONSTRAINT fk_daily_test_supp_data_cmp,
    DROP CONSTRAINT fk_daily_test_supp_data_loc;

ALTER TABLE camdecmps.derived_hrly_value
    DROP CONSTRAINT derived_hrly_value_r01,
    DROP CONSTRAINT fk_fuel_code_derived_hrly_,
    DROP CONSTRAINT fk_modc_code_derived_hrly_,
    DROP CONSTRAINT fk_monitor_formu_derived_hrly_,
    DROP CONSTRAINT fk_monitor_syste_derived_hrly_,
    DROP CONSTRAINT fk_operating_con_derived_hrly_,
    DROP CONSTRAINT fk_parameter_cod_derived_hrly_;

ALTER TABLE camdecmps.daily_test_summary
    DROP CONSTRAINT fk_component_daily_test_su,
    DROP CONSTRAINT fk_monitor_locat_daily_test_su,
    DROP CONSTRAINT fk_monitor_syste_daily_test_su,
    DROP CONSTRAINT fk_reporting_per_daily_test_su,
    DROP CONSTRAINT fk_span_scale_co_daily_test_su,
    DROP CONSTRAINT fk_test_result_c_daily_test40,
    DROP CONSTRAINT fk_test_result_c_daily_test_su,
    DROP CONSTRAINT fk_test_type_cod_daily_test_su;

ALTER TABLE camdecmps.daily_test_system_supp_data
    DROP CONSTRAINT fk_daily_test_sys_sup_data_dts,
    DROP CONSTRAINT fk_daily_test_sys_sup_data_loc,
    DROP CONSTRAINT fk_daily_test_sys_sup_data_tty;

ALTER TABLE camdecmps.daily_emission
    DROP CONSTRAINT fk_monitor_locat_daily_emissio,
    DROP CONSTRAINT fk_parameter_cod_daily_emissio,
    DROP CONSTRAINT fk_reporting_per_daily_emissio;

ALTER TABLE camdecmps.calibration_injection
    DROP CONSTRAINT fk_gas_level_cod_calibration_i,
    DROP CONSTRAINT fk_test_summary_calibration_i;

ALTER TABLE camdecmps.cycle_time_summary
    DROP CONSTRAINT fk_test_summary_cycle_time_su;

ALTER TABLE camdecmps.component
    DROP CONSTRAINT fk_acquisition_m_component,
    DROP CONSTRAINT fk_basis_code_component,
    DROP CONSTRAINT fk_component_typ_component,
    DROP CONSTRAINT fk_monitor_locat_component;

ALTER TABLE camdecmps.component_op_supp_data
    DROP CONSTRAINT fk_component_op_supp_data_cmp,
    DROP CONSTRAINT fk_component_op_supp_data_loc;

ALTER TABLE camdecmps.air_emission_testing
    DROP CONSTRAINT fk_test_summary_aet;

ALTER TABLE camdecmps.ae_hi_oil
    DROP CONSTRAINT fk_ae_correlatio_ae_hi_oil,
    DROP CONSTRAINT fk_monitor_system_ae_hi_oil,
    DROP CONSTRAINT fk_units_of_meas_ae_hi144,
    DROP CONSTRAINT fk_units_of_meas_ae_hi146,
    DROP CONSTRAINT fk_units_of_meas_ae_hi_oil;

ALTER TABLE camdecmps.ae_hi_gas
    DROP CONSTRAINT fk_ae_correlatio_ae_hi_gas,
    DROP CONSTRAINT fk_monitor_system_ae_hi_gas;

ALTER TABLE camdecmps.ae_correlation_test_sum
    DROP CONSTRAINT fk_test_summary_ae_correlatio;

ALTER TABLE camdecmps.hrly_param_fuel_flow
    ADD CONSTRAINT fk_hrly_param_fuel_flow_hrly_fuel_flow FOREIGN KEY ( hrly_fuel_flow_id ) REFERENCES camdecmps.hrly_fuel_flow ( hrly_fuel_flow_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_hrly_param_fuel_flow_monitor_formula FOREIGN KEY ( mon_form_id ) REFERENCES camdecmps.monitor_formula ( mon_form_id ),
    ADD CONSTRAINT fk_hrly_param_fuel_flow_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ),
    ADD CONSTRAINT fk_hrly_param_fuel_flow_monitor_system FOREIGN KEY ( mon_sys_id ) REFERENCES camdecmps.monitor_system ( mon_sys_id ),
    ADD CONSTRAINT fk_hrly_param_fuel_flow_operating_condition_code FOREIGN KEY ( operating_condition_cd ) REFERENCES camdecmpsmd.operating_condition_code ( operating_condition_cd ),
    ADD CONSTRAINT fk_hrly_param_fuel_flow_parameter_code FOREIGN KEY ( parameter_cd ) REFERENCES camdecmpsmd.parameter_code ( parameter_cd ),
    ADD CONSTRAINT fk_hrly_param_fuel_flow_reporting_period FOREIGN KEY ( rpt_period_id ) REFERENCES camdecmpsmd.reporting_period ( rpt_period_id ),
    ADD CONSTRAINT fk_hrly_param_fuel_flow_sample_type_code FOREIGN KEY ( sample_type_cd ) REFERENCES camdecmpsmd.sample_type_code ( sample_type_cd ),
    ADD CONSTRAINT fk_hrly_param_fuel_flow_units_of_measure_code FOREIGN KEY ( parameter_uom_cd ) REFERENCES camdecmpsmd.units_of_measure_code ( uom_cd );

ALTER TABLE camdecmps.hrly_op_data
    ADD CONSTRAINT fk_hrly_op_data_fuel_code FOREIGN KEY ( fuel_cd ) REFERENCES camdecmpsmd.fuel_code ( fuel_cd ),
    ADD CONSTRAINT fk_hrly_op_data_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ),
    ADD CONSTRAINT fk_hrly_op_data_operating_condition_code FOREIGN KEY ( operating_condition_cd ) REFERENCES camdecmpsmd.operating_condition_code ( operating_condition_cd ),
    ADD CONSTRAINT fk_hrly_op_data_reporting_period FOREIGN KEY ( rpt_period_id ) REFERENCES camdecmpsmd.reporting_period ( rpt_period_id ),
    ADD CONSTRAINT fk_hrly_op_data_units_of_measure_code FOREIGN KEY ( load_uom_cd ) REFERENCES camdecmpsmd.units_of_measure_code ( uom_cd );

ALTER TABLE camdecmps.analyzer_range
    ADD CONSTRAINT fk_analyzer_range_analyzer_range_code FOREIGN KEY ( analyzer_range_cd ) REFERENCES camdecmpsmd.analyzer_range_code ( analyzer_range_cd ),
    ADD CONSTRAINT fk_analyzer_range_component FOREIGN KEY ( component_id ) REFERENCES camdecmps.component ( component_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.weekly_system_integrity
    ADD CONSTRAINT fk_weekly_system_integrity_gas_level_code FOREIGN KEY ( gas_level_cd ) REFERENCES camdecmpsmd.gas_level_code ( gas_level_cd ),
    ADD CONSTRAINT fk_weekly_system_integrity_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ),
    ADD CONSTRAINT fk_weekly_system_integrity_reporting_period FOREIGN KEY ( rpt_period_id ) REFERENCES camdecmpsmd.reporting_period ( rpt_period_id ),
    ADD CONSTRAINT fk_weekly_system_integrity_weekly_test_summary FOREIGN KEY ( weekly_test_sum_id ) REFERENCES camdecmps.weekly_test_summary ( weekly_test_sum_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.daily_calibration
    ADD CONSTRAINT fk_daily_calibration_daily_test_summary FOREIGN KEY ( daily_test_sum_id ) REFERENCES camdecmps.daily_test_summary ( daily_test_sum_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_daily_calibration_gas_level_code FOREIGN KEY ( upscale_gas_level_cd ) REFERENCES camdecmpsmd.gas_level_code ( gas_level_cd ),
    ADD CONSTRAINT fk_daily_calibration_injection_protocol_code FOREIGN KEY ( injection_protocol_cd ) REFERENCES camdecmpsmd.injection_protocol_code ( injection_protocol_cd ),
    ADD CONSTRAINT fk_daily_calibration_protocol_gas_vendor FOREIGN KEY ( vendor_id ) REFERENCES camdecmps.protocol_gas_vendor ( vendor_id ),
    ADD CONSTRAINT fk_daily_calibration_reporting_period FOREIGN KEY ( rpt_period_id ) REFERENCES camdecmpsmd.reporting_period ( rpt_period_id );

ALTER TABLE camdecmps.cycle_time_injection
    ADD CONSTRAINT fk_cycle_time_injection_cycle_time_summary FOREIGN KEY ( cycle_time_sum_id ) REFERENCES camdecmps.cycle_time_summary ( cycle_time_sum_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_cycle_time_injection_gas_level_code FOREIGN KEY ( gas_level_cd ) REFERENCES camdecmpsmd.gas_level_code ( gas_level_cd );

ALTER TABLE camdecmps.ae_correlation_test_run
    ADD CONSTRAINT fk_ae_correlation_test_run_ae_correlation_test_sum FOREIGN KEY ( ae_corr_test_sum_id ) REFERENCES camdecmps.ae_correlation_test_sum ( ae_corr_test_sum_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.daily_fuel
    ADD CONSTRAINT fk_daily_fuel_daily_emission FOREIGN KEY ( daily_emission_id ) REFERENCES camdecmps.daily_emission ( daily_emission_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_daily_fuel_fuel_code FOREIGN KEY ( fuel_cd ) REFERENCES camdecmpsmd.fuel_code ( fuel_cd ),
    ADD CONSTRAINT fk_daily_fuel_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ),
    ADD CONSTRAINT fk_daily_fuel_reporting_period FOREIGN KEY ( rpt_period_id ) REFERENCES camdecmpsmd.reporting_period ( rpt_period_id );

ALTER TABLE camdecmps.weekly_test_summary
    ADD CONSTRAINT fk_weekly_test_summary_component FOREIGN KEY ( component_id ) REFERENCES camdecmps.component ( component_id ),
    ADD CONSTRAINT fk_weekly_test_summary_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ),
    ADD CONSTRAINT fk_weekly_test_summary_monitor_system FOREIGN KEY ( mon_sys_id ) REFERENCES camdecmps.monitor_system ( mon_sys_id ),
    ADD CONSTRAINT fk_weekly_test_summary_reporting_period FOREIGN KEY ( rpt_period_id ) REFERENCES camdecmpsmd.reporting_period ( rpt_period_id ),
    ADD CONSTRAINT fk_weekly_test_summary_span_scale_code FOREIGN KEY ( span_scale_cd ) REFERENCES camdecmpsmd.span_scale_code ( span_scale_cd ),
    ADD CONSTRAINT fk_weekly_test_summary_test_result_code FOREIGN KEY ( test_result_cd ) REFERENCES camdecmpsmd.test_result_code ( test_result_cd ),
    ADD CONSTRAINT fk_weekly_test_summary_test_result_code_calc FOREIGN KEY ( calc_test_result_cd ) REFERENCES camdecmpsmd.test_result_code ( test_result_cd ),
    ADD CONSTRAINT fk_weekly_test_summary_test_type_code FOREIGN KEY ( test_type_cd ) REFERENCES camdecmpsmd.test_type_code ( test_type_cd );

ALTER TABLE camdecmps.unit_fuel
    ADD CONSTRAINT fk_unit_fuel_dem_method_code_gcv FOREIGN KEY ( dem_gcv ) REFERENCES camdecmpsmd.dem_method_code ( dem_method_cd ),
    ADD CONSTRAINT fk_unit_fuel_dem_method_code_so2 FOREIGN KEY ( dem_so2 ) REFERENCES camdecmpsmd.dem_method_code ( dem_method_cd ),
    ADD CONSTRAINT fk_unit_fuel_fuel_indicator_code FOREIGN KEY ( indicator_cd ) REFERENCES camdecmpsmd.fuel_indicator_code ( fuel_indicator_cd ),
    ADD CONSTRAINT fk_unit_fuel_fuel_type_code FOREIGN KEY ( fuel_type ) REFERENCES camdecmpsmd.fuel_type_code ( fuel_type_cd ),
    ADD CONSTRAINT fk_unit_fuel_unit FOREIGN KEY ( unit_id ) REFERENCES camd.unit ( unit_id );

ALTER TABLE camdecmps.unit_default_test_run
    ADD CONSTRAINT fk_unit_default_test_run_unit_default_test FOREIGN KEY ( unit_default_test_sum_id ) REFERENCES camdecmps.unit_default_test ( unit_default_test_sum_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.unit_control
    ADD CONSTRAINT fk_unit_control_control_equip_param_code FOREIGN KEY ( ce_param ) REFERENCES camdecmpsmd.control_equip_param_code ( control_equip_param_cd ),
    ADD CONSTRAINT fk_unit_control_fuel_indicator_code FOREIGN KEY ( indicator_cd ) REFERENCES camdecmpsmd.fuel_indicator_code ( fuel_indicator_cd ),
    ADD CONSTRAINT fk_unit_control_unit FOREIGN KEY ( unit_id ) REFERENCES camd.unit ( unit_id );

ALTER TABLE camdecmps.sampling_train
    ADD CONSTRAINT fk_sampling_train_component FOREIGN KEY ( component_id ) REFERENCES camdecmps.component ( component_id ),
    ADD CONSTRAINT fk_sampling_train_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ),
    ADD CONSTRAINT fk_sampling_train_reporting_period FOREIGN KEY ( rpt_period_id ) REFERENCES camdecmpsmd.reporting_period ( rpt_period_id ),
    ADD CONSTRAINT fk_sampling_train_sorbent_trap FOREIGN KEY ( trap_id ) REFERENCES camdecmps.sorbent_trap ( trap_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_sampling_train_test_result_code_post_leak FOREIGN KEY ( post_leak_test_result_cd ) REFERENCES camdecmpsmd.test_result_code ( test_result_cd ),
    ADD CONSTRAINT fk_sampling_train_test_result_code_sampling_ratio FOREIGN KEY ( sampling_ratio_test_result_cd ) REFERENCES camdecmpsmd.test_result_code ( test_result_cd ),
    ADD CONSTRAINT fk_sampling_train_train_qa_status_code FOREIGN KEY ( train_qa_status_cd ) REFERENCES camdecmpsmd.train_qa_status_code ( train_qa_status_cd );

ALTER TABLE camdecmps.test_qualification
    ADD CONSTRAINT fk_test_qualification_test_claim_code FOREIGN KEY ( test_claim_cd ) REFERENCES camdecmpsmd.test_claim_code ( test_claim_cd ),
    ADD CONSTRAINT fk_test_qualification_test_summary FOREIGN KEY ( test_sum_id ) REFERENCES camdecmps.test_summary ( test_sum_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.system_op_supp_data
    ADD CONSTRAINT fk_system_op_supp_data_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ),
    ADD CONSTRAINT fk_system_op_supp_data_monitor_system FOREIGN KEY ( mon_sys_id ) REFERENCES camdecmps.monitor_system ( mon_sys_id );

ALTER TABLE camdecmps.sorbent_trap
    ADD CONSTRAINT fk_sorbent_trap_modc_code FOREIGN KEY ( modc_cd ) REFERENCES camdecmpsmd.modc_code ( modc_cd ),
    ADD CONSTRAINT fk_sorbent_trap_modc_code_calc FOREIGN KEY ( calc_modc_cd ) REFERENCES camdecmpsmd.modc_code ( modc_cd ),
    ADD CONSTRAINT fk_sorbent_trap_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ),
    ADD CONSTRAINT fk_sorbent_trap_monitor_system FOREIGN KEY ( mon_sys_id ) REFERENCES camdecmps.monitor_system ( mon_sys_id ),
    ADD CONSTRAINT fk_sorbent_trap_reporting_period FOREIGN KEY ( rpt_period_id ) REFERENCES camdecmpsmd.reporting_period ( rpt_period_id ),
    ADD CONSTRAINT fk_sorbent_trap_sorbent_trap_aps_code FOREIGN KEY ( sorbent_trap_aps_cd ) REFERENCES camdecmpsmd.sorbent_trap_aps_code ( sorbent_trap_aps_cd );

ALTER TABLE camdecmps.sorbent_trap_supp_data
    ADD CONSTRAINT fk_sorbent_trap_supp_data_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ),
    ADD CONSTRAINT fk_sorbent_trap_supp_data_monitor_system FOREIGN KEY ( mon_sys_id ) REFERENCES camdecmps.monitor_system ( mon_sys_id );

ALTER TABLE camdecmps.sampling_train_supp_data
    ADD CONSTRAINT fk_sampling_train_supp_data_component FOREIGN KEY ( component_id ) REFERENCES camdecmps.component ( component_id ),
    ADD CONSTRAINT fk_sampling_train_supp_data_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ),
    ADD CONSTRAINT fk_sampling_train_supp_data_sorbent_trap_supp_data FOREIGN KEY ( trap_id ) REFERENCES camdecmps.sorbent_trap_supp_data ( trap_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.rata_run
    ADD CONSTRAINT fk_rata_run_rata_summary FOREIGN KEY ( rata_sum_id ) REFERENCES camdecmps.rata_summary ( rata_sum_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_rata_run_run_status_code FOREIGN KEY ( run_status_cd ) REFERENCES camdecmpsmd.run_status_code ( run_status_cd );

ALTER TABLE camdecmps.rata
    ADD CONSTRAINT fk_rata_rata_frequency_code FOREIGN KEY ( rata_frequency_cd ) REFERENCES camdecmpsmd.rata_frequency_code ( rata_frequency_cd ),
    ADD CONSTRAINT fk_rata_rata_frequency_code_calc FOREIGN KEY ( calc_rata_frequency_cd ) REFERENCES camdecmpsmd.rata_frequency_code ( rata_frequency_cd ),
    ADD CONSTRAINT fk_rata_test_summary FOREIGN KEY ( test_sum_id ) REFERENCES camdecmps.test_summary ( test_sum_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.qa_supp_attribute
    ADD CONSTRAINT fk_qa_supp_attribute_qa_supp_data FOREIGN KEY ( qa_supp_data_id ) REFERENCES camdecmps.qa_supp_data ( qa_supp_data_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.qa_cert_event_supp_data
    ADD CONSTRAINT fk_qa_cert_event_supp_data_data_cd FOREIGN KEY ( qa_cert_event_supp_data_cd ) REFERENCES camdecmpsmd.qa_cert_event_supp_data_code ( qa_cert_event_supp_data_cd ),
    ADD CONSTRAINT fk_qa_cert_event_supp_data_date_cd FOREIGN KEY ( qa_cert_event_supp_date_cd ) REFERENCES camdecmpsmd.qa_cert_event_supp_date_code ( qa_cert_event_supp_date_cd ),
    ADD CONSTRAINT fk_qa_cert_event_supp_data_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_qa_cert_event_supp_data_qa_cert_event FOREIGN KEY ( qa_cert_event_id ) REFERENCES camdecmps.qa_cert_event ( qa_cert_event_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.rata_summary
    ADD CONSTRAINT fk_rata_summary_aps_code FOREIGN KEY ( aps_cd ) REFERENCES camdecmpsmd.aps_code ( aps_cd ),
    ADD CONSTRAINT fk_rata_summary_operating_level_code FOREIGN KEY ( op_level_cd ) REFERENCES camdecmpsmd.operating_level_code ( op_level_cd ),
    ADD CONSTRAINT fk_rata_summary_rata FOREIGN KEY ( rata_id ) REFERENCES camdecmps.rata ( rata_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_rata_summary_ref_method_code FOREIGN KEY ( ref_method_cd ) REFERENCES camdecmpsmd.ref_method_code ( ref_method_cd ),
    ADD CONSTRAINT fk_rata_summary_ref_method_code_co2o2 FOREIGN KEY ( co2_o2_ref_method_cd ) REFERENCES camdecmpsmd.ref_method_code ( ref_method_cd );

ALTER TABLE camdecmps.stack_pipe
    ADD CONSTRAINT fk_stack_pipe_plant FOREIGN KEY ( fac_id ) REFERENCES camd.plant ( fac_id );

ALTER TABLE camdecmps.summary_value
    ADD CONSTRAINT fk_summary_value_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ),
    ADD CONSTRAINT fk_summary_value_parameter_code FOREIGN KEY ( parameter_cd ) REFERENCES camdecmpsmd.parameter_code ( parameter_cd ),
    ADD CONSTRAINT fk_summary_value_reporting_period FOREIGN KEY ( rpt_period_id ) REFERENCES camdecmpsmd.reporting_period ( rpt_period_id );

ALTER TABLE camdecmps.summary_value
    ADD CONSTRAINT uq_summary_value UNIQUE ( mon_loc_id, rpt_period_id, parameter_cd ) USING INDEX TABLESPACE pg_default;

ALTER TABLE camdecmps.rect_duct_waf
    ADD CONSTRAINT fk_rect_duct_waf_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_rect_duct_waf_waf_method_code FOREIGN KEY ( waf_method_cd ) REFERENCES camdecmpsmd.waf_method_code ( waf_method_cd );

ALTER TABLE camdecmps.system_fuel_flow
    ADD CONSTRAINT fk_system_fuel_flow_max_rate_source_code FOREIGN KEY ( max_rate_source_cd ) REFERENCES camdecmpsmd.max_rate_source_code ( max_rate_source_cd ),
    ADD CONSTRAINT fk_system_fuel_flow_monitor_system FOREIGN KEY ( mon_sys_id ) REFERENCES camdecmps.monitor_system ( mon_sys_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_system_fuel_flow_units_of_measure_code FOREIGN KEY ( sys_fuel_uom_cd ) REFERENCES camdecmpsmd.units_of_measure_code ( uom_cd );

ALTER TABLE camdecmps.unit_default_test
    ADD CONSTRAINT fk_unt_default_test_fuel_code FOREIGN KEY ( fuel_cd ) REFERENCES camdecmpsmd.fuel_code ( fuel_cd ),
    ADD CONSTRAINT fk_unt_default_test_operating_condition_code FOREIGN KEY ( operating_condition_cd ) REFERENCES camdecmpsmd.operating_condition_code ( operating_condition_cd ),
    ADD CONSTRAINT fk_unt_default_test_test_summary FOREIGN KEY ( test_sum_id ) REFERENCES camdecmps.test_summary ( test_sum_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.rata_traverse
    ADD CONSTRAINT fk_rata_traverse_flow_rata_run FOREIGN KEY ( flow_rata_run_id ) REFERENCES camdecmps.flow_rata_run ( flow_rata_run_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_rata_traverse_pressure_measure_code FOREIGN KEY ( pressure_meas_cd ) REFERENCES camdecmpsmd.pressure_measure_code ( pressure_meas_cd ),
    ADD CONSTRAINT fk_rata_traverse_probe_type_code FOREIGN KEY ( probe_type_cd ) REFERENCES camdecmpsmd.probe_type_code ( probe_type_cd );

ALTER TABLE camdecmps.test_summary
    ADD CONSTRAINT fk_test_summary_component FOREIGN KEY ( component_id ) REFERENCES camdecmps.component ( component_id ),
    ADD CONSTRAINT fk_test_summary_injection_protocol_code FOREIGN KEY ( injection_protocol_cd ) REFERENCES camdecmpsmd.injection_protocol_code ( injection_protocol_cd ),
    ADD CONSTRAINT fk_test_summary_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ),
    ADD CONSTRAINT fk_test_summary_monitor_system FOREIGN KEY ( mon_sys_id ) REFERENCES camdecmps.monitor_system ( mon_sys_id ),
    ADD CONSTRAINT fk_test_summary_reporting_period FOREIGN KEY ( rpt_period_id ) REFERENCES camdecmpsmd.reporting_period ( rpt_period_id ),
    ADD CONSTRAINT fk_test_summary_span_scale_code FOREIGN KEY ( span_scale_cd ) REFERENCES camdecmpsmd.span_scale_code ( span_scale_cd ),
    ADD CONSTRAINT fk_test_summary_test_reason_code FOREIGN KEY ( test_reason_cd ) REFERENCES camdecmpsmd.test_reason_code ( test_reason_cd ),
    ADD CONSTRAINT fk_test_summary_test_result_code FOREIGN KEY ( test_result_cd ) REFERENCES camdecmpsmd.test_result_code ( test_result_cd ),
    ADD CONSTRAINT fk_test_summary_test_result_code_calc FOREIGN KEY ( calc_test_result_cd ) REFERENCES camdecmpsmd.test_result_code ( test_result_cd ),
    ADD CONSTRAINT fk_test_summary_test_type_code FOREIGN KEY ( test_type_cd ) REFERENCES camdecmpsmd.test_type_code ( test_type_cd );

ALTER TABLE camdecmps.test_summary
    ADD CONSTRAINT uq_test_summary UNIQUE ( mon_loc_id, test_num, test_type_cd ) USING INDEX TABLESPACE pg_default;

ALTER TABLE camdecmps.test_extension_exemption
    ADD CONSTRAINT fk_test_extension_exemption_component FOREIGN KEY ( component_id ) REFERENCES camdecmps.component ( component_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_test_extension_exemption_extension_exemption_code FOREIGN KEY ( extens_exempt_cd ) REFERENCES camdecmpsmd.extension_exemption_code ( extens_exempt_cd ),
    ADD CONSTRAINT fk_test_extension_exemption_fuel_code FOREIGN KEY ( fuel_cd ) REFERENCES camdecmpsmd.fuel_code ( fuel_cd ),
    ADD CONSTRAINT fk_test_extension_exemption_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_test_extension_exemption_monitor_system FOREIGN KEY ( mon_sys_id ) REFERENCES camdecmps.monitor_system ( mon_sys_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_test_extension_exemption_reporting_period FOREIGN KEY ( rpt_period_id ) REFERENCES camdecmpsmd.reporting_period ( rpt_period_id ),
    ADD CONSTRAINT fk_test_extension_exemption_span_scale_code FOREIGN KEY ( span_scale_cd ) REFERENCES camdecmpsmd.span_scale_code ( span_scale_cd ),
    ADD CONSTRAINT fk_test_extension_exemption_submission_availability_code FOREIGN KEY ( submission_availability_cd ) REFERENCES camdecmpsmd.submission_availability_code ( submission_availability_cd );

ALTER TABLE camdecmps.qa_supp_data
    ADD CONSTRAINT fk_qa_supp_data_component FOREIGN KEY ( component_id ) REFERENCES camdecmps.component ( component_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_qa_supp_data_fuel_code FOREIGN KEY ( fuel_cd ) REFERENCES camdecmpsmd.fuel_code ( fuel_cd ),
    ADD CONSTRAINT fk_qa_supp_data_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_qa_supp_data_monitor_system FOREIGN KEY ( mon_sys_id ) REFERENCES camdecmps.monitor_system ( mon_sys_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_qa_supp_data_operating_condition_code FOREIGN KEY ( operating_condition_cd ) REFERENCES camdecmpsmd.operating_condition_code ( operating_condition_cd ),
    ADD CONSTRAINT fk_qa_supp_data_operating_level_code FOREIGN KEY ( op_level_cd ) REFERENCES camdecmpsmd.operating_level_code ( op_level_cd ),
    ADD CONSTRAINT fk_qa_supp_data_reporting_period FOREIGN KEY ( rpt_period_id ) REFERENCES camdecmpsmd.reporting_period ( rpt_period_id ),
    ADD CONSTRAINT fk_qa_supp_data_submission_availability_code FOREIGN KEY ( submission_availability_cd ) REFERENCES camdecmpsmd.submission_availability_code ( submission_availability_cd ),
    ADD CONSTRAINT fk_qa_supp_data_submission_test_reason_code FOREIGN KEY ( test_reason_cd ) REFERENCES camdecmpsmd.test_reason_code ( test_reason_cd ),
    ADD CONSTRAINT fk_qa_supp_data_submission_test_result_code FOREIGN KEY ( test_result_cd ) REFERENCES camdecmpsmd.test_result_code ( test_result_cd ),
    ADD CONSTRAINT fk_qa_supp_data_submission_test_type_code FOREIGN KEY ( test_type_cd ) REFERENCES camdecmpsmd.test_type_code ( test_type_cd );

ALTER TABLE camdecmps.qa_cert_event
    ADD CONSTRAINT fk_qa_cert_event_component FOREIGN KEY ( component_id ) REFERENCES camdecmps.component ( component_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_qa_cert_event_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_qa_cert_event_monitor_system FOREIGN KEY ( mon_sys_id ) REFERENCES camdecmps.monitor_system ( mon_sys_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_qa_cert_event_qa_cert_event_code FOREIGN KEY ( qa_cert_event_cd ) REFERENCES camdecmpsmd.qa_cert_event_code ( qa_cert_event_cd ),
    ADD CONSTRAINT fk_qa_cert_event_required_test_code FOREIGN KEY ( required_test_cd ) REFERENCES camdecmpsmd.required_test_code ( required_test_cd ),
    ADD CONSTRAINT fk_qa_cert_event_submission_availability_code FOREIGN KEY ( submission_availability_cd ) REFERENCES camdecmpsmd.submission_availability_code ( submission_availability_cd );

ALTER TABLE camdecmps.trans_accuracy
    ADD CONSTRAINT fk_trans_accuracy_accuracy_spec_code_high FOREIGN KEY ( high_level_accuracy_spec_cd ) REFERENCES camdecmpsmd.accuracy_spec_code ( accuracy_spec_cd ),
    ADD CONSTRAINT fk_trans_accuracy_accuracy_spec_code_low FOREIGN KEY ( low_level_accuracy_spec_cd ) REFERENCES camdecmpsmd.accuracy_spec_code ( accuracy_spec_cd ),
    ADD CONSTRAINT fk_trans_accuracy_accuracy_spec_code_mid FOREIGN KEY ( mid_level_accuracy_spec_cd ) REFERENCES camdecmpsmd.accuracy_spec_code ( accuracy_spec_cd ),
    ADD CONSTRAINT fk_trans_accuracy_test_summary FOREIGN KEY ( test_sum_id ) REFERENCES camdecmps.test_summary ( test_sum_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.unit_stack_configuration
    ADD CONSTRAINT fk_unit_stack_configuration_stack_pipe FOREIGN KEY ( stack_pipe_id ) REFERENCES camdecmps.stack_pipe ( stack_pipe_id ),
    ADD CONSTRAINT fk_unit_stack_configuration_unit FOREIGN KEY ( unit_id ) REFERENCES camd.unit ( unit_id );

ALTER TABLE camdecmps.monitor_plan
    ADD CONSTRAINT fk_monitor_plan_plant FOREIGN KEY ( fac_id ) REFERENCES camd.plant ( fac_id ),
    ADD CONSTRAINT fk_monitor_plan_reporting_period_begin_rpt_period FOREIGN KEY ( begin_rpt_period_id ) REFERENCES camdecmpsmd.reporting_period ( rpt_period_id ),
    ADD CONSTRAINT fk_monitor_plan_reporting_period_end_rpt_period FOREIGN KEY ( end_rpt_period_id ) REFERENCES camdecmpsmd.reporting_period ( rpt_period_id ),
    ADD CONSTRAINT fk_monitor_plan_submission_availability_code FOREIGN KEY ( submission_availability_cd ) REFERENCES camdecmpsmd.submission_availability_code ( submission_availability_cd );

ALTER TABLE camdecmps.mats_monitor_hrly_value
    ADD CONSTRAINT fk_mats_monitor_hrly_value_component FOREIGN KEY ( component_id ) REFERENCES camdecmps.component ( component_id ),
    ADD CONSTRAINT fk_mats_monitor_hrly_value_hrly_op_data FOREIGN KEY ( hour_id ) REFERENCES camdecmps.hrly_op_data ( hour_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_mats_monitor_hrly_value_modc_code FOREIGN KEY ( modc_cd ) REFERENCES camdecmpsmd.modc_code ( modc_cd ),
    ADD CONSTRAINT fk_mats_monitor_hrly_value_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ),
    ADD CONSTRAINT fk_mats_monitor_hrly_value_monitor_system FOREIGN KEY ( mon_sys_id ) REFERENCES camdecmps.monitor_system ( mon_sys_id ),
    ADD CONSTRAINT fk_mats_monitor_hrly_value_parameter_code FOREIGN KEY ( parameter_cd ) REFERENCES camdecmpsmd.parameter_code ( parameter_cd ),
    ADD CONSTRAINT fk_mats_monitor_hrly_value_reporting_period FOREIGN KEY ( rpt_period_id ) REFERENCES camdecmpsmd.reporting_period ( rpt_period_id );

ALTER TABLE camdecmps.mats_derived_hrly_value
    ADD CONSTRAINT fk_mats_derived_hrly_value_hrly_op_data FOREIGN KEY ( hour_id ) REFERENCES camdecmps.hrly_op_data ( hour_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_mats_derived_hrly_value_modc_code FOREIGN KEY ( modc_cd ) REFERENCES camdecmpsmd.modc_code ( modc_cd ),
    ADD CONSTRAINT fk_mats_derived_hrly_value_monitor_formula FOREIGN KEY ( mon_form_id ) REFERENCES camdecmps.monitor_formula ( mon_form_id ),
    ADD CONSTRAINT fk_mats_derived_hrly_value_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ),
    ADD CONSTRAINT fk_mats_derived_hrly_value_parameter_code FOREIGN KEY ( parameter_cd ) REFERENCES camdecmpsmd.parameter_code ( parameter_cd ),
    ADD CONSTRAINT fk_mats_derived_hrly_value_reporting_period FOREIGN KEY ( rpt_period_id ) REFERENCES camdecmpsmd.reporting_period ( rpt_period_id );

ALTER TABLE camdecmps.mats_method_data
    ADD CONSTRAINT fk_mats_method_data_mats_method_code FOREIGN KEY ( mats_method_cd ) REFERENCES camdecmpsmd.mats_method_code ( mats_method_cd ),
    ADD CONSTRAINT fk_mats_method_data_mats_method_parameter_code FOREIGN KEY ( mats_method_parameter_cd ) REFERENCES camdecmpsmd.mats_method_parameter_code ( mats_method_parameter_cd ),
    ADD CONSTRAINT fk_mats_method_data_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.monitor_location_attribute
    ADD CONSTRAINT fk_monitor_location_attribute_material_code FOREIGN KEY ( material_cd ) REFERENCES camdecmpsmd.material_code ( material_cd ),
    ADD CONSTRAINT fk_monitor_location_attribute_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_location_attribute_shape_code FOREIGN KEY ( shape_cd ) REFERENCES camdecmpsmd.shape_code ( shape_cd );

ALTER TABLE camdecmps.linearity_injection
    ADD CONSTRAINT fk_linearity_injection_linearity_summary FOREIGN KEY ( lin_sum_id ) REFERENCES camdecmps.linearity_summary ( lin_sum_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.monitor_plan_location
    ADD CONSTRAINT fk_monitor_plan_location_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_plan_location_monitor_plan FOREIGN KEY ( mon_plan_id ) REFERENCES camdecmps.monitor_plan ( mon_plan_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.monitor_plan_location
    ADD CONSTRAINT uq_monitor_plan_location UNIQUE ( mon_plan_id, mon_loc_id ) USING INDEX TABLESPACE pg_default;

ALTER TABLE camdecmps.hrly_gas_flow_meter
    ADD CONSTRAINT fk_hrly_gas_flow_meter_component FOREIGN KEY ( component_id ) REFERENCES camdecmps.component ( component_id ),
    ADD CONSTRAINT fk_hrly_gas_flow_meter_hrly_op_data FOREIGN KEY ( hour_id ) REFERENCES camdecmps.hrly_op_data ( hour_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_hrly_gas_flow_meter_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ),
    ADD CONSTRAINT fk_hrly_gas_flow_meter_reporting_period FOREIGN KEY ( rpt_period_id ) REFERENCES camdecmpsmd.reporting_period ( rpt_period_id );

ALTER TABLE camdecmps.on_off_cal
    ADD CONSTRAINT fk_on_off_cal_gas_level_code FOREIGN KEY ( upscale_gas_level_cd ) REFERENCES camdecmpsmd.gas_level_code ( gas_level_cd ),
    ADD CONSTRAINT fk_on_off_cal_test_summary FOREIGN KEY ( test_sum_id ) REFERENCES camdecmps.test_summary ( test_sum_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.linearity_summary
    ADD CONSTRAINT fk_linearity_summary_gas_level_code FOREIGN KEY ( gas_level_cd ) REFERENCES camdecmpsmd.gas_level_code ( gas_level_cd ),
    ADD CONSTRAINT fk_linearity_summary_test_summary FOREIGN KEY ( test_sum_id ) REFERENCES camdecmps.test_summary ( test_sum_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.protocol_gas
    ADD CONSTRAINT fk_protocol_gas_gas_level_code FOREIGN KEY ( gas_level_cd ) REFERENCES camdecmpsmd.gas_level_code ( gas_level_cd ),
    ADD CONSTRAINT fk_protocol_gas_test_summary FOREIGN KEY ( test_sum_id ) REFERENCES camdecmps.test_summary ( test_sum_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.operating_supp_data
    ADD CONSTRAINT fk_operating_supp_data_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id );

ALTER TABLE camdecmps.monitor_formula
    ADD CONSTRAINT fk_monitor_formula_equation_code FOREIGN KEY ( equation_cd ) REFERENCES camdecmpsmd.equation_code ( equation_cd ),
    ADD CONSTRAINT fk_monitor_formula_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_formula_parameter_code FOREIGN KEY ( parameter_cd ) REFERENCES camdecmpsmd.parameter_code ( parameter_cd );

ALTER TABLE camdecmps.monitor_default
    ADD CONSTRAINT fk_monitor_default_default_purpose_code FOREIGN KEY ( default_purpose_cd ) REFERENCES camdecmpsmd.default_purpose_code ( default_purpose_cd ),
    ADD CONSTRAINT fk_monitor_default_default_source_code FOREIGN KEY ( default_source_cd ) REFERENCES camdecmpsmd.default_source_code ( default_source_cd ),
    ADD CONSTRAINT fk_monitor_default_fuel_code FOREIGN KEY ( fuel_cd ) REFERENCES camdecmpsmd.fuel_code ( fuel_cd ),
    ADD CONSTRAINT fk_monitor_default_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_default_operating_condition_code FOREIGN KEY ( operating_condition_cd ) REFERENCES camdecmpsmd.operating_condition_code ( operating_condition_cd ),
    ADD CONSTRAINT fk_monitor_default_parameter_code FOREIGN KEY ( parameter_cd ) REFERENCES camdecmpsmd.parameter_code ( parameter_cd ),
    ADD CONSTRAINT fk_monitor_default_units_of_measure_code FOREIGN KEY ( default_uom_cd ) REFERENCES camdecmpsmd.units_of_measure_code ( uom_cd );

ALTER TABLE camdecmps.monitor_span
    ADD CONSTRAINT fk_monitor_span_component_type_code FOREIGN KEY ( component_type_cd ) REFERENCES camdecmpsmd.component_type_code ( component_type_cd ),
    ADD CONSTRAINT fk_monitor_span_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_span_span_method_code FOREIGN KEY ( span_method_cd ) REFERENCES camdecmpsmd.span_method_code ( span_method_cd ),
    ADD CONSTRAINT fk_monitor_span_span_scale_code FOREIGN KEY ( span_scale_cd ) REFERENCES camdecmpsmd.span_scale_code ( span_scale_cd ),
    ADD CONSTRAINT fk_monitor_span_units_of_measure_code FOREIGN KEY ( span_uom_cd ) REFERENCES camdecmpsmd.units_of_measure_code ( uom_cd );

ALTER TABLE camdecmps.monitor_location
    ADD CONSTRAINT fk_monitor_location_stack_pipe FOREIGN KEY ( stack_pipe_id ) REFERENCES camdecmps.stack_pipe ( stack_pipe_id ),
    ADD CONSTRAINT fk_monitor_location_unit FOREIGN KEY ( unit_id ) REFERENCES camd.unit ( unit_id );

ALTER TABLE camdecmps.monitor_system_component
    ADD CONSTRAINT fk_monitor_system_component_component FOREIGN KEY ( component_id ) REFERENCES camdecmps.component ( component_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_system_component_monitor_system FOREIGN KEY ( mon_sys_id ) REFERENCES camdecmps.monitor_system ( mon_sys_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.monitor_plan_reporting_freq
    ADD CONSTRAINT fk_monitor_plan_reporting_freq_begin_rpt_period FOREIGN KEY ( begin_rpt_period_id ) REFERENCES camdecmpsmd.reporting_period ( rpt_period_id ),
    ADD CONSTRAINT fk_monitor_plan_reporting_freq_end_rpt_period FOREIGN KEY ( end_rpt_period_id ) REFERENCES camdecmpsmd.reporting_period ( rpt_period_id ),
    ADD CONSTRAINT fk_monitor_plan_reporting_freq_monitor_plan FOREIGN KEY ( mon_plan_id ) REFERENCES camdecmps.monitor_plan ( mon_plan_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_plan_reporting_freq_report_freq_code FOREIGN KEY ( report_freq_cd ) REFERENCES camdecmpsmd.report_freq_code ( report_freq_cd );

ALTER TABLE camdecmps.monitor_load
    ADD CONSTRAINT fk_monitor_load_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.monitor_hrly_value
    ADD CONSTRAINT fk_monitor_hrly_value_component FOREIGN KEY ( component_id ) REFERENCES camdecmps.component ( component_id ),
    ADD CONSTRAINT fk_monitor_hrly_value_hrly_op_data FOREIGN KEY ( hour_id ) REFERENCES camdecmps.hrly_op_data ( hour_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_hrly_value_modc_code FOREIGN KEY ( modc_cd ) REFERENCES camdecmpsmd.modc_code ( modc_cd ),
    ADD CONSTRAINT fk_monitor_hrly_value_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ),
    ADD CONSTRAINT fk_monitor_hrly_value_monitor_system FOREIGN KEY ( mon_sys_id ) REFERENCES camdecmps.monitor_system ( mon_sys_id ),
    ADD CONSTRAINT fk_monitor_hrly_value_parameter_code FOREIGN KEY ( parameter_cd ) REFERENCES camdecmpsmd.parameter_code ( parameter_cd ),
    ADD CONSTRAINT fk_monitor_hrly_value_reporting_period FOREIGN KEY ( rpt_period_id ) REFERENCES camdecmpsmd.reporting_period ( rpt_period_id );

ALTER TABLE camdecmps.last_qa_value_supp_data
    ADD CONSTRAINT fk_last_qa_value_supp_data_component FOREIGN KEY ( component_id ) REFERENCES camdecmps.component ( component_id ),
    ADD CONSTRAINT fk_last_qa_value_supp_data_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ),
    ADD CONSTRAINT fk_last_qa_value_supp_data_monitor_system FOREIGN KEY ( mon_sys_id ) REFERENCES camdecmps.monitor_system ( mon_sys_id );

ALTER TABLE camdecmps.monitor_method
    ADD CONSTRAINT fk_monitor_method_bypass_approach_code FOREIGN KEY ( bypass_approach_cd ) REFERENCES camdecmpsmd.bypass_approach_code ( bypass_approach_cd ),
    ADD CONSTRAINT fk_monitor_method_method_code FOREIGN KEY ( method_cd ) REFERENCES camdecmpsmd.method_code ( method_cd ),
    ADD CONSTRAINT fk_monitor_method_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_method_parameter_code FOREIGN KEY ( parameter_cd ) REFERENCES camdecmpsmd.parameter_code ( parameter_cd ),
    ADD CONSTRAINT fk_monitor_method_substitute_data_code FOREIGN KEY ( sub_data_cd ) REFERENCES camdecmpsmd.substitute_data_code ( sub_data_cd );

ALTER TABLE camdecmps.fuel_flow_to_load_baseline
    ADD CONSTRAINT fk_fuel_flow_to_load_baseline_fuel_flow_load_uom FOREIGN KEY ( fuel_flow_load_uom_cd ) REFERENCES camdecmpsmd.units_of_measure_code ( uom_cd ),
    ADD CONSTRAINT fk_fuel_flow_to_load_baseline_ghr_uom FOREIGN KEY ( ghr_uom_cd ) REFERENCES camdecmpsmd.units_of_measure_code ( uom_cd ),
    ADD CONSTRAINT fk_fuel_flow_to_load_baseline_test_summary FOREIGN KEY ( test_sum_id ) REFERENCES camdecmps.test_summary ( test_sum_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.fuel_flow_to_load_check
    ADD CONSTRAINT fk_fuel_flow_to_load_check_test_basis_code FOREIGN KEY ( test_basis_cd ) REFERENCES camdecmpsmd.test_basis_code ( test_basis_cd ),
    ADD CONSTRAINT fk_fuel_flow_to_load_check_test_summary FOREIGN KEY ( test_sum_id ) REFERENCES camdecmps.test_summary ( test_sum_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.flow_to_load_check
    ADD CONSTRAINT fk_flow_to_load_check_operating_level_code FOREIGN KEY ( op_level_cd ) REFERENCES camdecmpsmd.operating_level_code ( op_level_cd ),
    ADD CONSTRAINT fk_flow_to_load_check_test_basis_code FOREIGN KEY ( test_basis_cd ) REFERENCES camdecmpsmd.test_basis_code ( test_basis_cd ),
    ADD CONSTRAINT fk_flow_to_load_check_test_summary FOREIGN KEY ( test_sum_id ) REFERENCES camdecmps.test_summary ( test_sum_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.nsps4t_compliance_period
    ADD CONSTRAINT fk_nsps4t_compliance_period_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ),
    ADD CONSTRAINT fk_nsps4t_compliance_period_nsps4t_summary FOREIGN KEY ( nsps4t_sum_id ) REFERENCES camdecmps.nsps4t_summary ( nsps4t_sum_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_nsps4t_compliance_period_reporting_period FOREIGN KEY ( rpt_period_id ) REFERENCES camdecmpsmd.reporting_period ( rpt_period_id ),
    ADD CONSTRAINT fk_nsps4t_compliance_period_units_of_measure_code FOREIGN KEY ( co2_emission_rate_uom_cd ) REFERENCES camdecmpsmd.units_of_measure_code ( uom_cd );

ALTER TABLE camdecmps.nsps4t_summary
    ADD CONSTRAINT fk_nsps4t_summary_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ),
    ADD CONSTRAINT fk_nsps4t_summary_nsps4t_electrical_load_code FOREIGN KEY ( electrical_load_cd ) REFERENCES camdecmpsmd.nsps4t_electrical_load_code ( electrical_load_cd ),
    ADD CONSTRAINT fk_nsps4t_summary_nsps4t_emission_standard_code FOREIGN KEY ( emission_standard_cd ) REFERENCES camdecmpsmd.nsps4t_emission_standard_code ( emission_standard_cd ),
    ADD CONSTRAINT fk_nsps4t_summary_reporting_period FOREIGN KEY ( rpt_period_id ) REFERENCES camdecmpsmd.reporting_period ( rpt_period_id ),
    ADD CONSTRAINT fk_nsps4t_summary_units_of_measure_code FOREIGN KEY ( modus_uom_cd ) REFERENCES camdecmpsmd.units_of_measure_code ( uom_cd );

ALTER TABLE camdecmps.hg_test_injection
    ADD CONSTRAINT fk_hg_test_injection_hg_test_summary FOREIGN KEY ( hg_test_sum_id ) REFERENCES camdecmps.hg_test_summary ( hg_test_sum_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.hg_test_summary
    ADD CONSTRAINT fk_hg_test_summary_gas_level_code FOREIGN KEY ( gas_level_cd ) REFERENCES camdecmpsmd.gas_level_code ( gas_level_cd ),
    ADD CONSTRAINT fk_hg_test_summary_test_summary FOREIGN KEY ( test_sum_id ) REFERENCES camdecmps.test_summary ( test_sum_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.hrly_fuel_flow
    ADD CONSTRAINT fk_hrly_fuel_flow_fuel_code FOREIGN KEY ( fuel_cd ) REFERENCES camdecmpsmd.fuel_code ( fuel_cd ),
    ADD CONSTRAINT fk_hrly_fuel_flow_hrly_op_data FOREIGN KEY ( hour_id ) REFERENCES camdecmps.hrly_op_data ( hour_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_hrly_fuel_flow_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ),
    ADD CONSTRAINT fk_hrly_fuel_flow_monitor_system FOREIGN KEY ( mon_sys_id ) REFERENCES camdecmps.monitor_system ( mon_sys_id ),
    ADD CONSTRAINT fk_hrly_fuel_flow_reporting_period FOREIGN KEY ( rpt_period_id ) REFERENCES camdecmpsmd.reporting_period ( rpt_period_id ),
    ADD CONSTRAINT fk_hrly_fuel_flow_sod_mass_code FOREIGN KEY ( sod_mass_cd ) REFERENCES camdecmpsmd.sod_mass_code ( sod_mass_cd ),
    ADD CONSTRAINT fk_hrly_fuel_flow_sod_volumetric_code FOREIGN KEY ( sod_volumetric_cd ) REFERENCES camdecmpsmd.sod_volumetric_code ( sod_volumetric_cd ),
    ADD CONSTRAINT fk_hrly_fuel_flow_units_of_measure_code FOREIGN KEY ( volumetric_uom_cd ) REFERENCES camdecmpsmd.units_of_measure_code ( uom_cd );

ALTER TABLE camdecmps.flow_rata_run
    ADD CONSTRAINT fk_flow_rata_run_rata_run FOREIGN KEY ( rata_run_id ) REFERENCES camdecmps.rata_run ( rata_run_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.fuel_flowmeter_accuracy
    ADD CONSTRAINT fk_fuel_flowmeter_accuracy_accuracy_test_method_code FOREIGN KEY ( acc_test_method_cd ) REFERENCES camdecmpsmd.accuracy_test_method_code ( acc_test_method_cd ),
    ADD CONSTRAINT fk_fuel_flowmeter_accuracy_test_summary FOREIGN KEY ( test_sum_id ) REFERENCES camdecmps.test_summary ( test_sum_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.flow_to_load_reference
    ADD CONSTRAINT fk_flow_to_load_reference_operating_level_code FOREIGN KEY ( op_level_cd ) REFERENCES camdecmpsmd.operating_level_code ( op_level_cd ),
    ADD CONSTRAINT fk_flow_to_load_reference_test_summary FOREIGN KEY ( test_sum_id ) REFERENCES camdecmps.test_summary ( test_sum_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.nsps4t_annual
    ADD CONSTRAINT fk_nsps4t_annual_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ),
    ADD CONSTRAINT fk_nsps4t_annual_nsps4t_electrical_load_code FOREIGN KEY ( annual_energy_sold_type_cd ) REFERENCES camdecmpsmd.nsps4t_electrical_load_code ( electrical_load_cd ),
    ADD CONSTRAINT fk_nsps4t_annual_nsps4t_summary FOREIGN KEY ( nsps4t_sum_id ) REFERENCES camdecmps.nsps4t_summary ( nsps4t_sum_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_nsps4t_annual_reporting_period FOREIGN KEY ( rpt_period_id ) REFERENCES camdecmpsmd.reporting_period ( rpt_period_id );

ALTER TABLE camdecmps.long_term_fuel_flow
    ADD CONSTRAINT fk_long_term_fuel_flow_fuel_flow_period_code FOREIGN KEY ( fuel_flow_period_cd ) REFERENCES camdecmpsmd.fuel_flow_period_code ( fuel_flow_period_cd ),
    ADD CONSTRAINT fk_long_term_fuel_flow_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ),
    ADD CONSTRAINT fk_long_term_fuel_flow_monitor_system FOREIGN KEY ( mon_sys_id ) REFERENCES camdecmps.monitor_system ( mon_sys_id ),
    ADD CONSTRAINT fk_long_term_fuel_flow_reporting_period FOREIGN KEY ( rpt_period_id ) REFERENCES camdecmpsmd.reporting_period ( rpt_period_id ),
    ADD CONSTRAINT fk_long_term_fuel_flow_units_of_measure_code_gcv FOREIGN KEY ( gcv_uom_cd ) REFERENCES camdecmpsmd.units_of_measure_code ( uom_cd ),
    ADD CONSTRAINT fk_long_term_fuel_flow_units_of_measure_code_ltff FOREIGN KEY ( ltff_uom_cd ) REFERENCES camdecmpsmd.units_of_measure_code ( uom_cd );

ALTER TABLE camdecmps.monitor_system
    ADD CONSTRAINT fk_monitor_system_fuel_code FOREIGN KEY ( fuel_cd ) REFERENCES camdecmpsmd.fuel_code ( fuel_cd ),
    ADD CONSTRAINT fk_monitor_system_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_system_system_designation_code FOREIGN KEY ( sys_designation_cd ) REFERENCES camdecmpsmd.system_designation_code ( sys_designation_cd ),
    ADD CONSTRAINT fk_monitor_system_system_type_code FOREIGN KEY ( sys_type_cd ) REFERENCES camdecmpsmd.system_type_code ( sys_type_cd );

ALTER TABLE camdecmps.emission_evaluation
    ADD CONSTRAINT fk_emission_evaluation_monitor_plan FOREIGN KEY ( mon_plan_id ) REFERENCES camdecmps.monitor_plan ( mon_plan_id ),
    ADD CONSTRAINT fk_emission_evaluation_reporting_period FOREIGN KEY ( rpt_period_id ) REFERENCES camdecmpsmd.reporting_period ( rpt_period_id ),
    ADD CONSTRAINT fk_emission_evaluation_submission_availability_code FOREIGN KEY ( submission_availability_cd ) REFERENCES camdecmpsmd.submission_availability_code ( submission_availability_cd );

ALTER TABLE camdecmps.daily_test_supp_data
    ADD CONSTRAINT fk_daily_test_supp_data_component FOREIGN KEY ( component_id ) REFERENCES camdecmps.component ( component_id ),
    ADD CONSTRAINT fk_daily_test_supp_data_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id );

ALTER TABLE camdecmps.derived_hrly_value
    ADD CONSTRAINT fk_derived_hrly_value_fuel_code FOREIGN KEY ( fuel_cd ) REFERENCES camdecmpsmd.fuel_code ( fuel_cd ),
    ADD CONSTRAINT fk_derived_hrly_value_hrly_op_data FOREIGN KEY ( hour_id ) REFERENCES camdecmps.hrly_op_data ( hour_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_derived_hrly_value_modc_code FOREIGN KEY ( modc_cd ) REFERENCES camdecmpsmd.modc_code ( modc_cd ),
    ADD CONSTRAINT fk_derived_hrly_value_monitor_formula FOREIGN KEY ( mon_form_id ) REFERENCES camdecmps.monitor_formula ( mon_form_id ),
    ADD CONSTRAINT fk_derived_hrly_value_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ),
    ADD CONSTRAINT fk_derived_hrly_value_monitor_system FOREIGN KEY ( mon_sys_id ) REFERENCES camdecmps.monitor_system ( mon_sys_id ),
    ADD CONSTRAINT fk_derived_hrly_value_operating_condition_code FOREIGN KEY ( operating_condition_cd ) REFERENCES camdecmpsmd.operating_condition_code ( operating_condition_cd ),
    ADD CONSTRAINT fk_derived_hrly_value_parameter_code FOREIGN KEY ( parameter_cd ) REFERENCES camdecmpsmd.parameter_code ( parameter_cd ),
    ADD CONSTRAINT fk_derived_hrly_value_reporting_period FOREIGN KEY ( rpt_period_id ) REFERENCES camdecmpsmd.reporting_period ( rpt_period_id );

ALTER TABLE camdecmps.daily_test_summary
    ADD CONSTRAINT fk_daily_test_summary_component FOREIGN KEY ( component_id ) REFERENCES camdecmps.component ( component_id ),
    ADD CONSTRAINT fk_daily_test_summary_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ),
    ADD CONSTRAINT fk_daily_test_summary_monitor_system FOREIGN KEY ( mon_sys_id ) REFERENCES camdecmps.monitor_system ( mon_sys_id ),
    ADD CONSTRAINT fk_daily_test_summary_reporting_period FOREIGN KEY ( rpt_period_id ) REFERENCES camdecmpsmd.reporting_period ( rpt_period_id ),
    ADD CONSTRAINT fk_daily_test_summary_span_scale_code FOREIGN KEY ( span_scale_cd ) REFERENCES camdecmpsmd.span_scale_code ( span_scale_cd ),
    ADD CONSTRAINT fk_daily_test_summary_test_result_code FOREIGN KEY ( test_result_cd ) REFERENCES camdecmpsmd.test_result_code ( test_result_cd ),
    ADD CONSTRAINT fk_daily_test_summary_test_result_code_calc FOREIGN KEY ( calc_test_result_cd ) REFERENCES camdecmpsmd.test_result_code ( test_result_cd ),
    ADD CONSTRAINT fk_daily_test_summary_test_type_code FOREIGN KEY ( test_type_cd ) REFERENCES camdecmpsmd.test_type_code ( test_type_cd );

ALTER TABLE camdecmps.daily_test_system_supp_data
    ADD CONSTRAINT fk_daily_test_system_supp_data_daily_test_supp_data FOREIGN KEY ( daily_test_supp_data_id ) REFERENCES camdecmps.daily_test_supp_data ( daily_test_supp_data_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_daily_test_system_supp_data_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ),
    ADD CONSTRAINT fk_daily_test_system_supp_data_monitor_system FOREIGN KEY ( mon_sys_id ) REFERENCES camdecmps.monitor_system ( mon_sys_id );

ALTER TABLE camdecmps.daily_emission
    ADD CONSTRAINT fk_daily_emission_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ),
    ADD CONSTRAINT fk_daily_emission_parameter_code FOREIGN KEY ( parameter_cd ) REFERENCES camdecmpsmd.parameter_code ( parameter_cd ),
    ADD CONSTRAINT fk_daily_emission_reporting_period FOREIGN KEY ( rpt_period_id ) REFERENCES camdecmpsmd.reporting_period ( rpt_period_id );

ALTER TABLE camdecmps.calibration_injection
    ADD CONSTRAINT fk_calibration_injection_gas_level_code FOREIGN KEY ( upscale_gas_level_cd ) REFERENCES camdecmpsmd.gas_level_code ( gas_level_cd ),
    ADD CONSTRAINT fk_calibration_injection_test_summary FOREIGN KEY ( test_sum_id ) REFERENCES camdecmps.test_summary ( test_sum_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.cycle_time_summary
    ADD CONSTRAINT fk_cycle_time_summary_test_summary FOREIGN KEY ( test_sum_id ) REFERENCES camdecmps.test_summary ( test_sum_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.component
    ADD CONSTRAINT fk_component_acquisition_method_code FOREIGN KEY ( acq_cd ) REFERENCES camdecmpsmd.acquisition_method_code ( acq_cd ),
    ADD CONSTRAINT fk_component_basis_code FOREIGN KEY ( basis_cd ) REFERENCES camdecmpsmd.basis_code ( basis_cd ),
    ADD CONSTRAINT fk_component_component_type_code FOREIGN KEY ( component_type_cd ) REFERENCES camdecmpsmd.component_type_code ( component_type_cd ),
    ADD CONSTRAINT fk_component_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.component_op_supp_data
    ADD CONSTRAINT fk_component_op_supp_data_component FOREIGN KEY ( component_id ) REFERENCES camdecmps.component ( component_id ),
    ADD CONSTRAINT fk_component_op_supp_data_monitor_location FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id );

ALTER TABLE camdecmps.air_emission_testing
    ADD CONSTRAINT fk_air_emission_testing_test_summary FOREIGN KEY ( test_sum_id ) REFERENCES camdecmps.test_summary ( test_sum_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.ae_hi_oil
    ADD CONSTRAINT fk_ae_hi_oil_ae_correlation_test_run FOREIGN KEY ( ae_corr_test_run_id ) REFERENCES camdecmps.ae_correlation_test_run ( ae_corr_test_run_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_ae_hi_oil_monitor_system FOREIGN KEY ( mon_sys_id ) REFERENCES camdecmps.monitor_system ( mon_sys_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_ae_hi_oil_oil_density_uom FOREIGN KEY ( oil_density_uom_cd ) REFERENCES camdecmpsmd.units_of_measure_code ( uom_cd ),
    ADD CONSTRAINT fk_ae_hi_oil_oil_gcv_uom FOREIGN KEY ( oil_gcv_uom_cd ) REFERENCES camdecmpsmd.units_of_measure_code ( uom_cd ),
    ADD CONSTRAINT fk_ae_hi_oil_oil_volume_uom FOREIGN KEY ( oil_volume_uom_cd ) REFERENCES camdecmpsmd.units_of_measure_code ( uom_cd );

ALTER TABLE camdecmps.ae_hi_gas
    ADD CONSTRAINT fk_ae_hi_gas_ae_correlation_test_run FOREIGN KEY ( ae_corr_test_run_id ) REFERENCES camdecmps.ae_correlation_test_run ( ae_corr_test_run_id ) ON DELETE CASCADE,
    ADD CONSTRAINT fk_ae_hi_gas_monitor_system FOREIGN KEY ( mon_sys_id ) REFERENCES camdecmps.monitor_system ( mon_sys_id ) ON DELETE CASCADE;

ALTER TABLE camdecmps.ae_correlation_test_sum
    ADD CONSTRAINT fk_ae_correlation_test_sum_test_summary FOREIGN KEY ( test_sum_id ) REFERENCES camdecmps.test_summary ( test_sum_id ) ON DELETE CASCADE;

