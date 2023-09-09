----------------------------------------------------------------------------------------------------------------------------------
/* EMISSION VIEW TABLES */
----------------------------------------------------------------------------------------------------------------------------------
DO $$
DECLARE
	dataset record;
	sqlStatement text;
BEGIN
	FOR dataset IN SELECT * FROM camdaux.dataset WHERE group_cd = 'EMVIEW' AND dataset_cd NOT IN ('LTFF', 'NSPS4T', 'DAILYBACKSTOP', 'COUNTS')
	LOOP
		sqlStatement := format('
			DROP INDEX IF EXISTS camdecmps.idx_emission_view_%s_mon_plan_id;
			DROP INDEX IF EXISTS camdecmps.idx_emission_view_%s_mon_loc_id;
			DROP INDEX IF EXISTS camdecmps.idx_emission_view_%s_rpt_period_id;
			DROP INDEX IF EXISTS camdecmps.idx_emission_view_%s_rpt_period_id_mon_loc_id;
			DROP INDEX IF EXISTS camdecmpswks.idx_emission_view_%s_mon_plan_id;
			DROP INDEX IF EXISTS camdecmpswks.idx_emission_view_%s_mon_loc_id;
			DROP INDEX IF EXISTS camdecmpswks.idx_emission_view_%s_rpt_period_id;
			DROP INDEX IF EXISTS camdecmpswks.idx_emission_view_%s_rpt_period_id_mon_loc_id;
	    ', lower(dataset.dataset_cd), lower(dataset.dataset_cd), lower(dataset.dataset_cd), lower(dataset.dataset_cd),
		   lower(dataset.dataset_cd), lower(dataset.dataset_cd), lower(dataset.dataset_cd), lower(dataset.dataset_cd)
		);
		RAISE NOTICE 'Executing...%', sqlStatement;
		EXECUTE sqlStatement;
		DROP INDEX IF EXISTS camdecmps.idx_emission_view_count_mon_plan_id;
		DROP INDEX IF EXISTS camdecmps.idx_emission_view_count_mon_loc_id;
		DROP INDEX IF EXISTS camdecmps.idx_emission_view_count_dataset_cd;
		DROP INDEX IF EXISTS camdecmps.idx_emission_view_count_rpt_period_id;
		DROP INDEX IF EXISTS camdecmps.idx_emission_view_count_rpt_period_id_mon_loc_id;
		DROP INDEX IF EXISTS camdecmpswks.idx_emission_view_count_mon_plan_id;
		DROP INDEX IF EXISTS camdecmpswks.idx_emission_view_count_mon_loc_id;
		DROP INDEX IF EXISTS camdecmpswks.idx_emission_view_count_dataset_cd;
		DROP INDEX IF EXISTS camdecmpswks.idx_emission_view_count_rpt_period_id;
		DROP INDEX IF EXISTS camdecmpswks.idx_emission_view_count_rpt_period_id_mon_loc_id;
	END LOOP;
END $$;
----------------------------------------------------------------------------------------------------------------------------------
/* CAMDECMPSAUX */
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmpsaux.apportionment_data_rng_ix;
DROP INDEX IF EXISTS camdecmpsaux.idx_apportionment_data_apport_range_id;
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmpsaux.apportionment_data
    DROP CONSTRAINT IF EXISTS apportionment_data_pk,
    DROP CONSTRAINT IF EXISTS apportionment_data_rng_fk,
	DROP CONSTRAINT IF EXISTS pk_apportionment_data,
    DROP CONSTRAINT IF EXISTS fk_apportionment_data_apportionment_range;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmpsaux.idx_submission_queue_submission_set_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_submission_queue_process_cd;
DROP INDEX IF EXISTS camdecmpsaux.idx_submission_queue_test_sum_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_submission_queue_qa_cert_event_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_submission_queue_test_extension_exemption_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_submission_queue_rpt_period_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_submission_queue_mats_bulk_file_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_submission_queue_severity_cd;
DROP INDEX IF EXISTS camdecmpsaux.idx_submission_queue_status_cd;

ALTER TABLE IF EXISTS camdecmpsaux.submission_queue
	DROP CONSTRAINT IF EXISTS pk_submission_queue,
    DROP CONSTRAINT IF EXISTS fk_evaluation_queue_qa_cert_event,
    DROP CONSTRAINT IF EXISTS fk_evaluation_queue_reporting_period,
    DROP CONSTRAINT IF EXISTS fk_evaluation_queue_test_extension_exemption,
    DROP CONSTRAINT IF EXISTS fk_evaluation_queue_test_summary,
    DROP CONSTRAINT IF EXISTS fk_submission_queue_submission_set,
    DROP CONSTRAINT IF EXISTS fk_submission_queue_reporting_period,
    DROP CONSTRAINT IF EXISTS fk_submission_queue_severity_code,
    DROP CONSTRAINT IF EXISTS fk_submission_queue_submission_set;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmpsaux.idx_evaluation_queue_evaluation_set_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_evaluation_queue_process_cd;
DROP INDEX IF EXISTS camdecmpsaux.idx_evaluation_queue_test_sum_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_evaluation_queue_qa_cert_event_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_evaluation_queue_test_extension_exemption_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_evaluation_queue_rpt_period_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_evaluation_queue_severity_cd;
DROP INDEX IF EXISTS camdecmpsaux.idx_evaluation_queue_status_cd;

ALTER TABLE IF EXISTS camdecmpsaux.evaluation_queue
    DROP CONSTRAINT IF EXISTS pk_evaluation_queue,
    DROP CONSTRAINT IF EXISTS fk_evaluation_queue_evaluation_set,
    DROP CONSTRAINT IF EXISTS fk_evaluation_queue_qa_cert_event,
    DROP CONSTRAINT IF EXISTS fk_evaluation_queue_reporting_period,
    DROP CONSTRAINT IF EXISTS fk_evaluation_queue_test_extension_exemption,
    DROP CONSTRAINT IF EXISTS fk_evaluation_queue_test_summary,
    DROP CONSTRAINT IF EXISTS fk_evaluation_queue_severity_code;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmpsaux.idx_email_to_send_template_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_email_to_send_status_cd;

ALTER TABLE IF EXISTS camdecmpsaux.email_to_send
    DROP CONSTRAINT IF EXISTS pk_email_to_send,
    DROP CONSTRAINT IF EXISTS fk_email_to_send_email_template;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmpsaux.idx_email_to_process_fac_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_email_to_process_email_type;
DROP INDEX IF EXISTS camdecmpsaux.idx_email_to_process_event_code;
DROP INDEX IF EXISTS camdecmpsaux.idx_email_to_process_mon_plan_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_email_to_process_rpt_period_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_email_to_process_em_sub_access_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_email_to_process_submission_type;
DROP INDEX IF EXISTS camdecmpsaux.idx_email_to_process_status_cd;

ALTER TABLE IF EXISTS camdecmpsaux.email_to_process
    DROP CONSTRAINT IF EXISTS pk_email_to_process,
    DROP CONSTRAINT IF EXISTS fk_email_to_process_em_sub_access,
    DROP CONSTRAINT IF EXISTS fk_email_to_process_monitor_plan,
    DROP CONSTRAINT IF EXISTS fk_email_to_process_plant,
    DROP CONSTRAINT IF EXISTS fk_email_to_process_rpt_period_id;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmpsaux.idx_check_log_1471;
DROP INDEX IF EXISTS camdecmpsaux.idx_check_log_6400;
DROP INDEX IF EXISTS camdecmpsaux.idx_check_log_9600;
DROP INDEX IF EXISTS camdecmpsaux.idx_check_log_9738;
DROP INDEX IF EXISTS camdecmpsaux.idx_check_log_9814;
DROP INDEX IF EXISTS camdecmpsaux.idx_check_log_chk_session_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_check_log_rule_check_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_check_log_check_catalog_result_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_check_log_mon_loc_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_check_log_test_sum_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_check_log_check_result;
DROP INDEX IF EXISTS camdecmpsaux.idx_check_log_severity_cd;
DROP INDEX IF EXISTS camdecmpsaux.idx_check_log_suppressed_severity_cd;
DROP INDEX IF EXISTS camdecmpsaux.idx_check_log_check_cd;
DROP INDEX IF EXISTS camdecmpsaux.idx_check_log_error_suppress_id;

ALTER TABLE IF EXISTS camdecmpsaux.check_log
    DROP CONSTRAINT IF EXISTS pk_check_log,
    DROP CONSTRAINT IF EXISTS check_log_r01,
    DROP CONSTRAINT IF EXISTS check_log_severity_fk,
    DROP CONSTRAINT IF EXISTS check_log_suppress_severity_fk,
    DROP CONSTRAINT IF EXISTS pk_check_session_check_log,
    DROP CONSTRAINT IF EXISTS fk_check_log_check_session,
    DROP CONSTRAINT IF EXISTS fk_check_log_rule_check,
    DROP CONSTRAINT IF EXISTS fk_check_log_check_catalog_result,
	DROP CONSTRAINT IF EXISTS fk_check_log_monitor_location,
	DROP CONSTRAINT IF EXISTS fk_check_log_test_summary,
    DROP CONSTRAINT IF EXISTS fk_check_log_severity_code,
    DROP CONSTRAINT IF EXISTS fk_check_log_severity_code_suppressed,
    DROP CONSTRAINT IF EXISTS fk_check_log_es_spec;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmpsaux.apportionment_range_app_ix;
DROP INDEX IF EXISTS camdecmpsaux.idx_apportionment_range_apport_id;

ALTER TABLE IF EXISTS camdecmpsaux.apportionment_range
    DROP CONSTRAINT IF EXISTS apportionment_range_pk,
    DROP CONSTRAINT IF EXISTS apportionment_range_app_fk,
	DROP CONSTRAINT IF EXISTS pk_apportionment_range,
    DROP CONSTRAINT IF EXISTS fk_apportionment_range_apportionment;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmpsaux.idx_submission_set_mon_plan_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_submission_set_status_cd;
DROP INDEX IF EXISTS camdecmpsaux.idx_submission_set_fac_id;

ALTER TABLE IF EXISTS camdecmpsaux.submission_set
    DROP CONSTRAINT IF EXISTS pk_submission_set,
    DROP CONSTRAINT IF EXISTS pk_submission_set_plant,	
	DROP CONSTRAINT IF EXISTS fk_submission_set_monitor_plan;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmpsaux.idx_prg_param_begin_rpt_period;
DROP INDEX IF EXISTS camdecmpsaux.idx_prg_param_end_rpt_period;
DROP INDEX IF EXISTS camdecmpsaux.idx_prg_param_param_cd;
DROP INDEX IF EXISTS camdecmpsaux.idx_prg_param_prg_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_program_parameter_begin_rpt_period_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_program_parameter_end_rpt_period_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_program_parameter_parameter_cd;
DROP INDEX IF EXISTS camdecmpsaux.idx_program_parameter_prg_id;

ALTER TABLE IF EXISTS camdecmpsaux.program_parameter
    DROP CONSTRAINT IF EXISTS pk_program_parameter,
    DROP CONSTRAINT IF EXISTS uq_program_parameter,
    DROP CONSTRAINT IF EXISTS fk_program_parameter_begin_rpt_period,
    DROP CONSTRAINT IF EXISTS fk_program_parameter_end_rpt_period,
    DROP CONSTRAINT IF EXISTS fk_program_parameter_parameter_code,
    DROP CONSTRAINT IF EXISTS fk_program_parameter_program;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmpsaux.idx_evaluation_set_mon_plan_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_evaluation_set_fac_id;

ALTER TABLE IF EXISTS camdecmpsaux.evaluation_set
    DROP CONSTRAINT IF EXISTS pk_evaluation_set,
	DROP CONSTRAINT IF EXISTS fk_evaluation_set_plant,
    DROP CONSTRAINT IF EXISTS fk_evaluation_set_monitor_plan;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmpsaux.es_spec_ccr_ix;
DROP INDEX IF EXISTS camdecmpsaux.es_spec_fac_ix;
DROP INDEX IF EXISTS camdecmpsaux.idx_es_spec_check_catalog_result_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_es_spec_severity_cd;
DROP INDEX IF EXISTS camdecmpsaux.idx_es_spec_fac_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_es_spec_es_match_data_type_cd;
DROP INDEX IF EXISTS camdecmpsaux.idx_es_spec_es_match_time_type_cd;
DROP INDEX IF EXISTS camdecmpsaux.idx_es_spec_es_reason_cd;

ALTER TABLE IF EXISTS camdecmpsaux.es_spec
    DROP CONSTRAINT IF EXISTS es_spec_pk,
	DROP CONSTRAINT IF EXISTS pk_es_spec,
	DROP CONSTRAINT IF EXISTS es_spec_ccr_fk,
    DROP CONSTRAINT IF EXISTS es_spec_dat_fk,
    DROP CONSTRAINT IF EXISTS es_spec_fac_fk,
    DROP CONSTRAINT IF EXISTS es_spec_rea_fk,
    DROP CONSTRAINT IF EXISTS es_spec_sev_fk,
    DROP CONSTRAINT IF EXISTS es_spec_tim_fk,
    DROP CONSTRAINT IF EXISTS fk_es_spec_check_catalog_result,
    DROP CONSTRAINT IF EXISTS fk_es_spec_es_match_data_type_code,
    DROP CONSTRAINT IF EXISTS fk_es_spec_plant,
    DROP CONSTRAINT IF EXISTS fk_es_spec_es_reason_code,
    DROP CONSTRAINT IF EXISTS fk_es_spec_severity_code,
    DROP CONSTRAINT IF EXISTS fk_es_spec_es_match_time_type_code;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmpsaux."em_submission_a_idx$$_15a60001";
DROP INDEX IF EXISTS camdecmpsaux.idx_em_submission_a_em_status_;
DROP INDEX IF EXISTS camdecmpsaux.idx_em_submission_a_em_sub_typ;
DROP INDEX IF EXISTS camdecmpsaux.idx_em_submission_access_0729;
DROP INDEX IF EXISTS camdecmpsaux.idx_em_submission_access_mon_plan_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_em_submission_access_em_status_cd;
DROP INDEX IF EXISTS camdecmpsaux.idx_em_submission_access_em_sub_type_cd;
DROP INDEX IF EXISTS camdecmpsaux.idx_em_submission_access_rpt_period_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_em_submission_access_sub_availability_cd;
DROP INDEX IF EXISTS camdecmpsaux.idx_em_submission_access_rpt_period_id_mon_plan_id;

ALTER TABLE IF EXISTS camdecmpsaux.em_submission_access
    DROP CONSTRAINT IF EXISTS pk_em_submission_access,
    DROP CONSTRAINT IF EXISTS em_submission_access_u01,
    DROP CONSTRAINT IF EXISTS em_submission_access_r04,
    DROP CONSTRAINT IF EXISTS em_submission_access_r05,
    DROP CONSTRAINT IF EXISTS fk_em_status_cod_em_submission,
    DROP CONSTRAINT IF EXISTS fk_em_sub_type_c_em_submission,
    DROP CONSTRAINT IF EXISTS em_submission_access_c01,
    DROP CONSTRAINT IF EXISTS uq_em_submission_access,
    DROP CONSTRAINT IF EXISTS fk_em_submission_access_monitor_plan,
    DROP CONSTRAINT IF EXISTS fk_em_submission_access_reporting_period,
    DROP CONSTRAINT IF EXISTS fk_em_submission_access_em_status_code,
    DROP CONSTRAINT IF EXISTS fk_em_submission_access_em_sub_type_code,
    DROP CONSTRAINT IF EXISTS fk_em_submission_access_submission_availability_code,
    DROP CONSTRAINT IF EXISTS chk_em_submission_access_begin_date_lte_end_date;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmpsaux.idx_check_session_1526;
DROP INDEX IF EXISTS camdecmpsaux.idx_check_session_2816;
DROP INDEX IF EXISTS camdecmpsaux.idx_check_session_6459;
DROP INDEX IF EXISTS camdecmpsaux.idx_check_session_7529;
DROP INDEX IF EXISTS camdecmpsaux.idx_check_session_8070;
DROP INDEX IF EXISTS camdecmpsaux.idx_check_session_category_c;
DROP INDEX IF EXISTS camdecmpsaux.idx_check_session_process_cd;
DROP INDEX IF EXISTS camdecmpsaux.idx_check_session_severity_c;
DROP INDEX IF EXISTS camdecmpsaux.idx_check_session_test_extension_exemption_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_check_session_qa_cert_event_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_check_session_mon_plan_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_check_session_test_sum_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_check_session_rpt_period_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_check_session_submission_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_check_session_category_cd;
DROP INDEX IF EXISTS camdecmpsaux.idx_check_session_process_cd;
DROP INDEX IF EXISTS camdecmpsaux.idx_check_session_severity_cd;

ALTER TABLE IF EXISTS camdecmpsaux.check_session
    DROP CONSTRAINT IF EXISTS pk_check_session,
    DROP CONSTRAINT IF EXISTS check_session_r05,
    DROP CONSTRAINT IF EXISTS fk_category_code_check_session,
    DROP CONSTRAINT IF EXISTS fk_process_code_check_session,
    DROP CONSTRAINT IF EXISTS fk_severity_code_check_session,
    DROP CONSTRAINT IF EXISTS check_session_c01,
    DROP CONSTRAINT IF EXISTS fk_check_session_reporting_period,
    DROP CONSTRAINT IF EXISTS fk_check_session_category_code,
    DROP CONSTRAINT IF EXISTS fk_check_session_process_code,
    DROP CONSTRAINT IF EXISTS fk_check_session_severity_code,
    DROP CONSTRAINT IF EXISTS chk_check_session_begin_date_lte_end_date;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmpsaux.idx_apportionment_mon_plan_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_apportionment_begin_rpt_period_id;
DROP INDEX IF EXISTS camdecmpsaux.idx_apportionment_end_rpt_period_id;

ALTER TABLE IF EXISTS camdecmpsaux.apportionment
    DROP CONSTRAINT IF EXISTS apportionment_pk,
	DROP CONSTRAINT IF EXISTS pk_apportionment,
	DROP CONSTRAINT IF EXISTS apportionment_bprd_fk,
    DROP CONSTRAINT IF EXISTS apportionment_eprd_fk,
    DROP CONSTRAINT IF EXISTS apportionment_pln_fk,
    DROP CONSTRAINT IF EXISTS apportionment_mon_plan_id_check,
    DROP CONSTRAINT IF EXISTS apportionment_begin_rpt_period_id_check,
    DROP CONSTRAINT IF EXISTS apportionment_userid_check,
    DROP CONSTRAINT IF EXISTS apportionment_add_date_check,
    DROP CONSTRAINT IF EXISTS fk_apportionment_monitor_plan,	
    DROP CONSTRAINT IF EXISTS fk_apportionment_begin_rpt_period_id,
    DROP CONSTRAINT IF EXISTS fk_apportionment_end_rpt_period_id;
----------------------------------------------------------------------------------------------------------------------------------
/* CAMDECMPS */
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_rata_traverse_flow_rata;
DROP INDEX IF EXISTS camdecmps.idx_rata_traverse_pressure_m;
DROP INDEX IF EXISTS camdecmps.idx_rata_traverse_probe_type;
DROP INDEX IF EXISTS camdecmps.idx_rata_traverse_flow_rata_run_id;
DROP INDEX IF EXISTS camdecmps.idx_rata_traverse_pressure_meas_cd;
DROP INDEX IF EXISTS camdecmps.idx_rata_traverse_probe_type_cd;

ALTER TABLE IF EXISTS camdecmps.rata_traverse
    DROP CONSTRAINT IF EXISTS pk_rata_traverse,
    DROP CONSTRAINT IF EXISTS fk_rata_traverse_flow_rata_run,
    DROP CONSTRAINT IF EXISTS fk_rata_traverse_pressure_measure_code,
    DROP CONSTRAINT IF EXISTS fk_rata_traverse_probe_type_code;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.flow_rata_run_idx001;
DROP INDEX IF EXISTS camdecmps.idx_flow_rata_run_rata_run_id;

ALTER TABLE IF EXISTS camdecmps.flow_rata_run
    DROP CONSTRAINT IF EXISTS pk_flow_rata_run,
    DROP CONSTRAINT IF EXISTS fk_flow_rata_run_rata_run;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_rata_run_run_status;
DROP INDEX IF EXISTS camdecmps.rata_run_idx001;
DROP INDEX IF EXISTS camdecmps.idx_rata_run_run_status_cd;
DROP INDEX IF EXISTS camdecmps.idx_rata_run_rata_sum_id;

ALTER TABLE IF EXISTS camdecmps.rata_run
    DROP CONSTRAINT IF EXISTS pk_rata_run,
    DROP CONSTRAINT IF EXISTS fk_rata_run_rata_summary,
    DROP CONSTRAINT IF EXISTS fk_rata_run_run_status_code;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_ae_hi_oil_ae_corr_te;
DROP INDEX IF EXISTS camdecmps.idx_ae_hi_oil_mon_sys_id;
DROP INDEX IF EXISTS camdecmps.idx_ae_hi_oil_oil_densit;
DROP INDEX IF EXISTS camdecmps.idx_ae_hi_oil_oil_gcv_uo;
DROP INDEX IF EXISTS camdecmps.idx_ae_hi_oil_oil_volume;
DROP INDEX IF EXISTS camdecmps.idx_ae_hi_oil_ae_corr_test_run_id;
DROP INDEX IF EXISTS camdecmps.idx_ae_hi_oil_mon_sys_id;
DROP INDEX IF EXISTS camdecmps.idx_ae_hi_oil_oil_density_uom_cd;
DROP INDEX IF EXISTS camdecmps.idx_ae_hi_oil_oil_gcv_uom_cd;
DROP INDEX IF EXISTS camdecmps.idx_ae_hi_oil_oil_volume_uom_cd;

ALTER TABLE IF EXISTS camdecmps.ae_hi_oil
    DROP CONSTRAINT IF EXISTS pk_ae_hi_oil,
    DROP CONSTRAINT IF EXISTS fk_ae_hi_oil_ae_correlation_test_run,
    DROP CONSTRAINT IF EXISTS fk_ae_hi_oil_monitor_system,
    DROP CONSTRAINT IF EXISTS fk_ae_hi_oil_oil_density_uom,
    DROP CONSTRAINT IF EXISTS fk_ae_hi_oil_oil_gcv_uom,
    DROP CONSTRAINT IF EXISTS fk_ae_hi_oil_oil_volume_uom;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_ae_hi_gas_ae_corr_te;
DROP INDEX IF EXISTS camdecmps.idx_ae_hi_gas_mon_sys_id;
DROP INDEX IF EXISTS camdecmps.idx_ae_hi_gas_ae_corr_test_run_id;
DROP INDEX IF EXISTS camdecmps.idx_ae_hi_gas_mon_sys_id;

ALTER TABLE IF EXISTS camdecmps.ae_hi_gas
    DROP CONSTRAINT IF EXISTS pk_ae_hi_gas,
    DROP CONSTRAINT IF EXISTS fk_ae_hi_gas_ae_correlation_test_run,
    DROP CONSTRAINT IF EXISTS fk_ae_hi_gas_monitor_system;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_unit_default_te_unit_defau;
DROP INDEX IF EXISTS camdecmps.idx_unit_default_test_run_unit_default_test_sum_id;

ALTER TABLE IF EXISTS camdecmps.unit_default_test_run
    DROP CONSTRAINT IF EXISTS pk_unit_default_test_run,
    DROP CONSTRAINT IF EXISTS fk_unit_default_test_run_unit_default_test;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_rata_summary_co2_o2_ref;
DROP INDEX IF EXISTS camdecmps.idx_rata_summary_op_level_c;
DROP INDEX IF EXISTS camdecmps.idx_rata_summary_rata_id;
DROP INDEX IF EXISTS camdecmps.idx_rata_summary_ref_method;
DROP INDEX IF EXISTS camdecmps.idx_rata_summary_aps_code;
DROP INDEX IF EXISTS camdecmps.idx_rata_summary_co2_o2_ref_method_cd;
DROP INDEX IF EXISTS camdecmps.idx_rata_summary_op_level_cd;
DROP INDEX IF EXISTS camdecmps.idx_rata_summary_rata_id;
DROP INDEX IF EXISTS camdecmps.idx_rata_summary_ref_method_cd;

ALTER TABLE IF EXISTS camdecmps.rata_summary
    DROP CONSTRAINT IF EXISTS pk_rata_summary,
    DROP CONSTRAINT IF EXISTS fk_rata_summary_aps_code,
    DROP CONSTRAINT IF EXISTS fk_rata_summary_operating_level_code,
    DROP CONSTRAINT IF EXISTS fk_rata_summary_rata,
    DROP CONSTRAINT IF EXISTS fk_rata_summary_ref_method_code,
    DROP CONSTRAINT IF EXISTS fk_rata_summary_ref_method_code_co2o2;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.qa_supp_attribute_idx001;
DROP INDEX IF EXISTS camdecmps.idx_qa_supp_attribute_qa_supp_data_id;

ALTER TABLE IF EXISTS camdecmps.qa_supp_attribute
    DROP CONSTRAINT IF EXISTS pk_qa_supp_attribute,
    DROP CONSTRAINT IF EXISTS fk_qa_supp_attribute_qa_supp_data;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.linearity_injection_idx001;
DROP INDEX IF EXISTS camdecmps.idx_linearity_injection_lin_sum_id;

ALTER TABLE IF EXISTS camdecmps.linearity_injection
    DROP CONSTRAINT IF EXISTS pk_linearity_injection,
    DROP CONSTRAINT IF EXISTS fk_linearity_injection_linearity_summary;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.hg_test_injection_idx001;
DROP INDEX IF EXISTS camdecmps.idx_hg_test_injection_hg_test_sum_id;

ALTER TABLE IF EXISTS camdecmps.hg_test_injection
    DROP CONSTRAINT IF EXISTS pk_hg_test_injection,
    DROP CONSTRAINT IF EXISTS fk_hg_test_injection_hg_test_summary;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_daily_test_sys_sup_data_dt;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_sys_sup_data_em;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_sys_sup_data_ml;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_sys_sup_data_ms;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_sys_sup_data_rp;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_system_supp_data_daily_test_supp_data_id;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_system_supp_data_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_system_supp_data_mon_sys_id;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_system_supp_data_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_system_supp_data_rpt_period_id_mon_loc_id;

ALTER TABLE IF EXISTS camdecmps.daily_test_system_supp_data
	DROP CONSTRAINT IF EXISTS pk_daily_test_sys_sup_data,
	DROP CONSTRAINT IF EXISTS fk_daily_test_sys_sup_data_rpp,
	DROP CONSTRAINT IF EXISTS pk_daily_test_system_supp_data,
    DROP CONSTRAINT IF EXISTS fk_daily_test_system_sup_data_reporting_period,
    DROP CONSTRAINT IF EXISTS fk_daily_test_system_supp_data_daily_test_supp_data,
    DROP CONSTRAINT IF EXISTS fk_daily_test_system_supp_data_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_daily_test_system_supp_data_monitor_system;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.cycle_time_injection_idx001;
DROP INDEX IF EXISTS camdecmps.idx_cycle_time_inje_gas_level;
DROP INDEX IF EXISTS camdecmps.idx_cycle_time_injection_cycle_time_sum_id;
DROP INDEX IF EXISTS camdecmps.idx_cycle_time_injection_gas_level_cd;

ALTER TABLE IF EXISTS camdecmps.cycle_time_injection
    DROP CONSTRAINT IF EXISTS pk_cycle_time_injection,
    DROP CONSTRAINT IF EXISTS fk_cycle_time_injection_cycle_time_summary,
    DROP CONSTRAINT IF EXISTS fk_cycle_time_injection_gas_level_code;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_ae_correlation_ae_corr_te;
DROP INDEX IF EXISTS camdecmps.idx_ae_correlation_test_run_ae_corr_test_sum_id;
DROP INDEX IF EXISTS camdecmps.idx_ae_correlation_test_run_ae_correlation_test_sum_id;

ALTER TABLE IF EXISTS camdecmps.ae_correlation_test_run
    DROP CONSTRAINT IF EXISTS pk_ae_correlation_test_run,
    DROP CONSTRAINT IF EXISTS fk_ae_correlation_test_run_ae_correlation_test_sum;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_wsi_gas_level;
DROP INDEX IF EXISTS camdecmps.idx_wsi_prd_loc;
DROP INDEX IF EXISTS camdecmps.idx_wsi_weekly_test_sum_id;
DROP INDEX IF EXISTS camdecmps.idx_weekly_system_integrity_gas_level_cd;
DROP INDEX IF EXISTS camdecmps.idx_weekly_system_integrity_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_weekly_system_integrity_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_weekly_system_integrity_weekly_test_sum_id;
DROP INDEX IF EXISTS camdecmps.idx_weekly_system_integrity_rpt_period_id_mon_loc_id;

ALTER TABLE IF EXISTS camdecmps.weekly_system_integrity
    DROP CONSTRAINT IF EXISTS pk_weekly_system_integrity,
    DROP CONSTRAINT IF EXISTS fk_weekly_system_integrity_gas_level_code,
    DROP CONSTRAINT IF EXISTS fk_weekly_system_integrity_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_weekly_system_integrity_reporting_period,
    DROP CONSTRAINT IF EXISTS fk_weekly_system_integrity_weekly_test_summary;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_unit_default_te_fuel_cd;
DROP INDEX IF EXISTS camdecmps.idx_unit_default_te_operating;
DROP INDEX IF EXISTS camdecmps.idx_unit_default_test_001;
DROP INDEX IF EXISTS camdecmps.idx_unit_default_test_fuel_cd;
DROP INDEX IF EXISTS camdecmps.idx_unit_default_test_operating_condition_cd;
DROP INDEX IF EXISTS camdecmps.idx_unit_default_test_test_sum_id;

ALTER TABLE IF EXISTS camdecmps.unit_default_test
    DROP CONSTRAINT IF EXISTS pk_unt_default_test,
    DROP CONSTRAINT IF EXISTS fk_unt_default_test_fuel_code,
    DROP CONSTRAINT IF EXISTS fk_unt_default_test_operating_condition_code,
    DROP CONSTRAINT IF EXISTS fk_unt_default_test_test_summary;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_trans_accuracy_001;
DROP INDEX IF EXISTS camdecmps.idx_trans_accuracy_high_level;
DROP INDEX IF EXISTS camdecmps.idx_trans_accuracy_low_level;
DROP INDEX IF EXISTS camdecmps.idx_trans_accuracy_mid_level;
DROP INDEX IF EXISTS camdecmps.idx_trans_accuracy_test_sum_id;
DROP INDEX IF EXISTS camdecmps.idx_trans_accuracy_high_level_accuracy_spec_cd;
DROP INDEX IF EXISTS camdecmps.idx_trans_accuracy_low_level_accuracy_spec_cd;
DROP INDEX IF EXISTS camdecmps.idx_trans_accuracy_mid_level_accuracy_spec_cd;

ALTER TABLE IF EXISTS camdecmps.trans_accuracy
    DROP CONSTRAINT IF EXISTS pk_trans_accuracy,
    DROP CONSTRAINT IF EXISTS fk_trans_accuracy_accuracy_spec_code_high,
    DROP CONSTRAINT IF EXISTS fk_trans_accuracy_accuracy_spec_code_low,
    DROP CONSTRAINT IF EXISTS fk_trans_accuracy_accuracy_spec_code_mid,
    DROP CONSTRAINT IF EXISTS fk_trans_accuracy_test_summary;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_test_qualificat_test_claim;
DROP INDEX IF EXISTS camdecmps.idx_test_qualification_001;
DROP INDEX IF EXISTS camdecmps.idx_test_qualification_test_claim_cd;
DROP INDEX IF EXISTS camdecmps.idx_test_qualification_test_sum_id;

ALTER TABLE IF EXISTS camdecmps.test_qualification
    DROP CONSTRAINT IF EXISTS pk_test_qualification,
    DROP CONSTRAINT IF EXISTS fk_test_qualification_test_claim_code,
    DROP CONSTRAINT IF EXISTS fk_test_qualification_test_summary;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_sampling_train_001;
DROP INDEX IF EXISTS camdecmps.idx_sampling_train_trp;
DROP INDEX IF EXISTS camdecmps.idx_train_add_date;
DROP INDEX IF EXISTS camdecmps.idx_train_component_id;
DROP INDEX IF EXISTS camdecmps.idx_sampling_train_trap_id;
DROP INDEX IF EXISTS camdecmps.idx_sampling_train_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_sampling_train_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_sampling_train_component_id;
DROP INDEX IF EXISTS camdecmps.idx_sampling_train_sampling_ratio_test_result_cd;
DROP INDEX IF EXISTS camdecmps.idx_sampling_train_post_leak_test_result_cd;
DROP INDEX IF EXISTS camdecmps.idx_sampling_train_train_qa_status_cd;
DROP INDEX IF EXISTS camdecmps.idx_sampling_train_rpt_period_id_mon_loc_id;

ALTER TABLE IF EXISTS camdecmps.sampling_train
    DROP CONSTRAINT IF EXISTS pk_sampling_train,
    DROP CONSTRAINT IF EXISTS fk_sampling_train_component,
    DROP CONSTRAINT IF EXISTS fk_sampling_train_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_sampling_train_reporting_period,
    DROP CONSTRAINT IF EXISTS fk_sampling_train_sorbent_trap,
    DROP CONSTRAINT IF EXISTS fk_sampling_train_test_result_code_post_leak,
    DROP CONSTRAINT IF EXISTS fk_sampling_train_test_result_code_sampling_ratio,
    DROP CONSTRAINT IF EXISTS fk_sampling_train_train_qa_status_code;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_sampling_train_sd_cmp;
DROP INDEX IF EXISTS camdecmps.idx_sampling_train_sd_loc;
DROP INDEX IF EXISTS camdecmps.idx_sampling_train_sd_prd_loc;
DROP INDEX IF EXISTS camdecmps.idx_sampling_train_sd_rrc;
DROP INDEX IF EXISTS camdecmps.idx_sampling_train_sd_tqs;
DROP INDEX IF EXISTS camdecmps.idx_sampling_train_sd_trp;
DROP INDEX IF EXISTS camdecmps.idx_sampling_train_supp_data_trap_id;
DROP INDEX IF EXISTS camdecmps.idx_sampling_train_supp_data_component_id;
DROP INDEX IF EXISTS camdecmps.idx_sampling_train_supp_data_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_sampling_train_supp_data_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_sampling_train_supp_data_sampling_ratio_test_result_cd;
DROP INDEX IF EXISTS camdecmps.idx_sampling_train_supp_data_train_qa_status_cd;
DROP INDEX IF EXISTS camdecmps.idx_sampling_train_supp_data_rpt_period_id_mon_loc_id;

ALTER TABLE IF EXISTS camdecmps.sampling_train_supp_data
    DROP CONSTRAINT IF EXISTS pk_sampling_train_sd,
	DROP CONSTRAINT IF EXISTS pk_sampling_train_supp_data,
	DROP CONSTRAINT IF EXISTS fk_sampling_train_sd_prd,
    DROP CONSTRAINT IF EXISTS fk_sampling_train_sd_rrc,
    DROP CONSTRAINT IF EXISTS fk_sampling_train_sd_tqs,
    DROP CONSTRAINT IF EXISTS fk_sampling_train_supp_data_component,
    DROP CONSTRAINT IF EXISTS fk_sampling_train_supp_data_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_sampling_train_supp_data_sorbent_trap_supp_data,
    DROP CONSTRAINT IF EXISTS fk_sampling_train_supp_data_reporting_period,
    DROP CONSTRAINT IF EXISTS fk_sampling_train_supp_data_test_result_code,
    DROP CONSTRAINT IF EXISTS fk_sampling_train_supp_data_train_qa_status_code,
    DROP CONSTRAINT IF EXISTS fk_sampling_train_supp_data_component,
    DROP CONSTRAINT IF EXISTS fk_sampling_train_supp_data_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_sampling_train_supp_data_sorbent_trap_supp_data;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_rata_001;
DROP INDEX IF EXISTS camdecmps.idx_rata_calc_rata;
DROP INDEX IF EXISTS camdecmps.idx_rata_rata_frequ;
DROP INDEX IF EXISTS camdecmps.idx_rata_test_sum_id;
DROP INDEX IF EXISTS camdecmps.idx_rata_rata_frequency_cd;

ALTER TABLE IF EXISTS camdecmps.rata
	DROP CONSTRAINT IF EXISTS pk_rata,
    DROP CONSTRAINT IF EXISTS fk_rata_rata_frequency_code,
	DROP CONSTRAINT IF EXISTS fk_rata_rata_frequency_code_calc,
    DROP CONSTRAINT IF EXISTS fk_rata_test_summary;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_qa_supp_data_001;
DROP INDEX IF EXISTS camdecmps.idx_qa_supp_data_chk_sessio;
DROP INDEX IF EXISTS camdecmps.idx_qa_supp_data_component;
DROP INDEX IF EXISTS camdecmps.idx_qa_supp_data_fuel_cd;
DROP INDEX IF EXISTS camdecmps.idx_qa_supp_data_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_qa_supp_data_mon_sys_id;
DROP INDEX IF EXISTS camdecmps.idx_qa_supp_data_op_level_c;
DROP INDEX IF EXISTS camdecmps.idx_qa_supp_data_operating_;
DROP INDEX IF EXISTS camdecmps.idx_qa_supp_data_submission;
DROP INDEX IF EXISTS camdecmps.idx_qa_supp_data_submission1;
DROP INDEX IF EXISTS camdecmps.idx_qa_supp_data_test_reaso;
DROP INDEX IF EXISTS camdecmps.idx_qa_supp_data_test_resul;
DROP INDEX IF EXISTS camdecmps.idx_qa_supp_data_test_type;
DROP INDEX IF EXISTS camdecmps.qa_supp_data_idx001;
DROP INDEX IF EXISTS camdecmps.idx_qa_supp_data_test_sum_id;
DROP INDEX IF EXISTS camdecmps.idx_qa_supp_data_chk_session_id;
DROP INDEX IF EXISTS camdecmps.idx_qa_supp_data_component_id;
DROP INDEX IF EXISTS camdecmps.idx_qa_supp_data_fuel_cd;
DROP INDEX IF EXISTS camdecmps.idx_qa_supp_data_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_qa_supp_data_mon_sys_id;
DROP INDEX IF EXISTS camdecmps.idx_qa_supp_data_op_level_cd;
DROP INDEX IF EXISTS camdecmps.idx_qa_supp_data_operating_condition_cd;
DROP INDEX IF EXISTS camdecmps.idx_qa_supp_data_submission_availability_cd;
DROP INDEX IF EXISTS camdecmps.idx_qa_supp_data_submission_id;
DROP INDEX IF EXISTS camdecmps.idx_qa_supp_data_test_reason_cd;
DROP INDEX IF EXISTS camdecmps.idx_qa_supp_data_test_result_cd;
DROP INDEX IF EXISTS camdecmps.idx_qa_supp_data_test_type_cd;
DROP INDEX IF EXISTS camdecmps.idx_qa_supp_data_rpt_period_id;

ALTER TABLE IF EXISTS camdecmps.qa_supp_data
    DROP CONSTRAINT IF EXISTS pk_qa_supp_data,
    DROP CONSTRAINT IF EXISTS fk_qa_supp_data_component,
    DROP CONSTRAINT IF EXISTS fk_qa_supp_data_fuel_code,
    DROP CONSTRAINT IF EXISTS fk_qa_supp_data_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_qa_supp_data_monitor_system,
    DROP CONSTRAINT IF EXISTS fk_qa_supp_data_operating_condition_code,
    DROP CONSTRAINT IF EXISTS fk_qa_supp_data_operating_level_code,
    DROP CONSTRAINT IF EXISTS fk_qa_supp_data_reporting_period,
    DROP CONSTRAINT IF EXISTS fk_qa_supp_data_submission_availability_code,
    DROP CONSTRAINT IF EXISTS fk_qa_supp_data_submission_test_reason_code,
    DROP CONSTRAINT IF EXISTS fk_qa_supp_data_submission_test_result_code,
    DROP CONSTRAINT IF EXISTS fk_qa_supp_data_submission_test_type_code;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_qa_cert_event_supp_data_ce;
DROP INDEX IF EXISTS camdecmps.idx_qa_cert_event_supp_data_da;
DROP INDEX IF EXISTS camdecmps.idx_qa_cert_event_supp_data_de;
DROP INDEX IF EXISTS camdecmps.idx_qa_cert_event_supp_data_er;
DROP INDEX IF EXISTS camdecmps.idx_qa_cert_event_supp_data_ml;
DROP INDEX IF EXISTS camdecmps.idx_qa_cert_event_supp_data_qa_cert_event_id;
DROP INDEX IF EXISTS camdecmps.idx_qa_cert_event_supp_data_qa_cert_event_supp_data_cd;
DROP INDEX IF EXISTS camdecmps.idx_qa_cert_event_supp_data_qa_cert_event_supp_date_cd;
DROP INDEX IF EXISTS camdecmps.idx_qa_cert_event_supp_data_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_qa_cert_event_supp_data_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_qa_cert_event_supp_data_rpt_period_id_mon_loc_id;

ALTER TABLE IF EXISTS camdecmps.qa_cert_event_supp_data
    DROP CONSTRAINT IF EXISTS pk_qa_cert_event_supp_data,
    DROP CONSTRAINT IF EXISTS fk_qa_cert_event_supp_data_data_cd,
    DROP CONSTRAINT IF EXISTS fk_qa_cert_event_supp_data_date_cd,
    DROP CONSTRAINT IF EXISTS fk_qa_cert_event_supp_data_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_qa_cert_event_supp_data_reporting_period,
    DROP CONSTRAINT IF EXISTS fk_qa_cert_event_supp_data_qa_cert_event;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_protocol_gas_0001;
DROP INDEX IF EXISTS camdecmps.idx_protocol_gas_test_sum_id;
DROP INDEX IF EXISTS camdecmps.idx_protocol_gas_gas_level_cd;
DROP INDEX IF EXISTS camdecmps.idx_protocol_gas_gas_type_cd;
DROP INDEX IF EXISTS camdecmps.idx_protocol_gas_vendor_id;

ALTER TABLE IF EXISTS camdecmps.protocol_gas
    DROP CONSTRAINT IF EXISTS pk_protocol_gas,
    DROP CONSTRAINT IF EXISTS fk_protocol_gas_gas_level_code,
    DROP CONSTRAINT IF EXISTS fk_protocol_gas_gas_type_code,
    DROP CONSTRAINT IF EXISTS fk_protocol_gas_protocol_gas_vendor,
    DROP CONSTRAINT IF EXISTS fk_protocol_gas_test_summary;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_on_off_cal_001;
DROP INDEX IF EXISTS camdecmps.idx_on_off_cal_upscale_ga;
DROP INDEX IF EXISTS camdecmps.idx_on_off_cal_test_sum_id;
DROP INDEX IF EXISTS camdecmps.idx_on_off_cal_upscale_gas_level_cd;

ALTER TABLE IF EXISTS camdecmps.on_off_cal
    DROP CONSTRAINT IF EXISTS pk_on_off_cal,
    DROP CONSTRAINT IF EXISTS fk_on_off_cal_gas_level_code,
    DROP CONSTRAINT IF EXISTS fk_on_off_cal_test_summary;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_linearity_summa_gas_level;
DROP INDEX IF EXISTS camdecmps.idx_linearity_summary_001;
DROP INDEX IF EXISTS camdecmps.idx_linearity_summary_gas_level_cd;
DROP INDEX IF EXISTS camdecmps.idx_linearity_summary_test_sum_id;

ALTER TABLE IF EXISTS camdecmps.linearity_summary
    DROP CONSTRAINT IF EXISTS pk_linearity_summary,
    DROP CONSTRAINT IF EXISTS fk_linearity_summary_gas_level_code,
    DROP CONSTRAINT IF EXISTS fk_linearity_summary_test_summary;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_hrly_param_fuel_flow_fuel_flow_id;
DROP INDEX IF EXISTS camdecmps.idx_hrly_param_fuel_flow_hrly_fuel_flow_id;
DROP INDEX IF EXISTS camdecmps.idx_hrly_param_fuel_flow_mon_form_id;
DROP INDEX IF EXISTS camdecmps.idx_hrly_param_fuel_flow_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_hrly_param_fuel_flow_mon_sys_id;
DROP INDEX IF EXISTS camdecmps.idx_hrly_param_fuel_flow_operating_condition_cd;
DROP INDEX IF EXISTS camdecmps.idx_hrly_param_fuel_flow_parameter_cd;
DROP INDEX IF EXISTS camdecmps.idx_hrly_param_fuel_flow_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_hrly_param_fuel_flow_sample_type_cd;
DROP INDEX IF EXISTS camdecmps.idx_hrly_param_fuel_flow_parameter_uom_cd;
DROP INDEX IF EXISTS camdecmps.idx_hrly_param_fuel_flow_rpt_period_id_mon_loc_id;

ALTER TABLE IF EXISTS camdecmps.hrly_param_fuel_flow
    DROP CONSTRAINT IF EXISTS pk_hrly_param_fuel_flow,
    DROP CONSTRAINT IF EXISTS fk_hrly_param_fuel_flow_hrly_fuel_flow,
    DROP CONSTRAINT IF EXISTS fk_hrly_param_fuel_flow_monitor_formula,
    DROP CONSTRAINT IF EXISTS fk_hrly_param_fuel_flow_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_hrly_param_fuel_flow_monitor_system,
    DROP CONSTRAINT IF EXISTS fk_hrly_param_fuel_flow_operating_condition_code,
    DROP CONSTRAINT IF EXISTS fk_hrly_param_fuel_flow_parameter_code,
    DROP CONSTRAINT IF EXISTS fk_hrly_param_fuel_flow_reporting_period,
    DROP CONSTRAINT IF EXISTS fk_hrly_param_fuel_flow_sample_type_code,
    DROP CONSTRAINT IF EXISTS fk_hrly_param_fuel_flow_units_of_measure_code;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_hg_test_summary_001;
DROP INDEX IF EXISTS camdecmps.idx_hg_test_summary_gas_level;
DROP INDEX IF EXISTS camdecmps.idx_hg_test_summary_test_sum_id;
DROP INDEX IF EXISTS camdecmps.idx_hg_test_summary_gas_level_cd;

ALTER TABLE IF EXISTS camdecmps.hg_test_summary
    DROP CONSTRAINT IF EXISTS pk_hg_test_summary,
    DROP CONSTRAINT IF EXISTS fk_hg_test_summary_gas_level_code,
    DROP CONSTRAINT IF EXISTS fk_hg_test_summary_test_summary;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_ff_accuracy_001;
DROP INDEX IF EXISTS camdecmps.idx_fuel_flowmeter_acc_test_m;
DROP INDEX IF EXISTS camdecmps.idx_fuel_flowmeter_accuracy_test_sum_id;
DROP INDEX IF EXISTS camdecmps.idx_fuel_flowmeter_accuracy_acc_test_method_cd;

ALTER TABLE IF EXISTS camdecmps.fuel_flowmeter_accuracy
    DROP CONSTRAINT IF EXISTS pk_fuel_flowmeter_accuracy,
    DROP CONSTRAINT IF EXISTS fk_fuel_flowmeter_accuracy_accuracy_test_method_code,
    DROP CONSTRAINT IF EXISTS fk_fuel_flowmeter_accuracy_test_summary;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_ffload_check_001;
DROP INDEX IF EXISTS camdecmps.idx_fuel_flow_to_lo_test_basis;
DROP INDEX IF EXISTS camdecmps.idx_fuel_flow_to_load_check_test_sum_id;
DROP INDEX IF EXISTS camdecmps.idx_fuel_flow_to_load_check_test_basis_cd;

ALTER TABLE IF EXISTS camdecmps.fuel_flow_to_load_check
    DROP CONSTRAINT IF EXISTS pk_fuel_flow_to_load_check,
    DROP CONSTRAINT IF EXISTS fk_fuel_flow_to_load_check_test_basis_code,
    DROP CONSTRAINT IF EXISTS fk_fuel_flow_to_load_check_test_summary;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_ffload_baseline_001;
DROP INDEX IF EXISTS camdecmps.idx_fuel_flow_to_lo_fuel_flow;
DROP INDEX IF EXISTS camdecmps.idx_fuel_flow_to_lo_ghr_uom_cd;
DROP INDEX IF EXISTS camdecmps.idx_fuel_flow_to_load_baseline_test_sum_id;
DROP INDEX IF EXISTS camdecmps.idx_fuel_flow_to_load_baseline_fuel_flow_load_uom_cd;
DROP INDEX IF EXISTS camdecmps.idx_fuel_flow_to_load_baseline_ghr_uom_cd;

ALTER TABLE IF EXISTS camdecmps.fuel_flow_to_load_baseline
    DROP CONSTRAINT IF EXISTS pk_fuel_flow_to_load_baseline,
    DROP CONSTRAINT IF EXISTS fk_fuel_flow_to_load_baseline_fuel_flow_load_uom,
    DROP CONSTRAINT IF EXISTS fk_fuel_flow_to_load_baseline_ghr_uom,
    DROP CONSTRAINT IF EXISTS fk_fuel_flow_to_load_baseline_test_summary;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_flow_to_load_re_op_level_c;
DROP INDEX IF EXISTS camdecmps.idx_flow_to_load_reference_001;
DROP INDEX IF EXISTS camdecmps.idx_flow_to_load_reference_op_level_cd;
DROP INDEX IF EXISTS camdecmps.idx_flow_to_load_reference_test_sum_id;

ALTER TABLE IF EXISTS camdecmps.flow_to_load_reference
    DROP CONSTRAINT IF EXISTS pk_flow_to_load_reference,
    DROP CONSTRAINT IF EXISTS fk_flow_to_load_reference_operating_level_code,
    DROP CONSTRAINT IF EXISTS fk_flow_to_load_reference_test_summary;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_flow_to_load_ch_op_level_c;
DROP INDEX IF EXISTS camdecmps.idx_flow_to_load_ch_test_basis;
DROP INDEX IF EXISTS camdecmps.idx_flow_to_load_check_001;
DROP INDEX IF EXISTS camdecmps.idx_flow_to_load_check_op_level_cd;
DROP INDEX IF EXISTS camdecmps.idx_flow_to_load_check_test_basis_cd;
DROP INDEX IF EXISTS camdecmps.idx_flow_to_load_check_test_sum_id;

ALTER TABLE IF EXISTS camdecmps.flow_to_load_check
    DROP CONSTRAINT IF EXISTS pk_flow_to_load_check,
    DROP CONSTRAINT IF EXISTS fk_flow_to_load_check_operating_level_code,
    DROP CONSTRAINT IF EXISTS fk_flow_to_load_check_test_basis_code,
    DROP CONSTRAINT IF EXISTS fk_flow_to_load_check_test_summary;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_daily_test_supp_data_cmp;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_supp_data_ctr;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_supp_data_dst;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_supp_data_emr;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_supp_data_kyo;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_supp_data_kyv;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_supp_data_ool;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_supp_data_prd;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_supp_data_ssc;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_supp_data_trs;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_supp_data_tty;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_supp_data_component_id;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_supp_data_daily_test_sum_id;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_supp_data_key_online_ind;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_supp_data_key_valid_ind;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_supp_data_online_offline_ind;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_supp_data_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_supp_data_span_scale_cd;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_supp_data_test_result_cd;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_supp_data_test_type_cd;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_supp_data_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_supp_data_rpt_period_id_mon_loc_id;

ALTER TABLE IF EXISTS camdecmps.daily_test_supp_data
	DROP CONSTRAINT IF EXISTS fk_daily_test_supp_data_ctr,
	DROP CONSTRAINT IF EXISTS fk_daily_test_supp_data_rpp,
	DROP CONSTRAINT IF EXISTS fk_daily_test_supp_data_trs,
	DROP CONSTRAINT IF EXISTS fk_daily_test_supp_data_tty,
    DROP CONSTRAINT IF EXISTS fk_daily_test_supp_data_test_result_code,
	DROP CONSTRAINT IF EXISTS fk_daily_test_supp_data_test_result_code_calc,
    DROP CONSTRAINT IF EXISTS fk_daily_test_supp_data_reporting_period,
	DROP CONSTRAINT IF EXISTS fk_daily_test_supp_data_test_type_code,
    DROP CONSTRAINT IF EXISTS pk_daily_test_supp_data,
    DROP CONSTRAINT IF EXISTS fk_daily_test_supp_data_component,
    DROP CONSTRAINT IF EXISTS fk_daily_test_supp_data_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_daily_test_supp_data_reporting_period,
    DROP CONSTRAINT IF EXISTS fk_daily_test_supp_data_test_result_code,
    DROP CONSTRAINT IF EXISTS fk_daily_test_supp_data_test_type_code,
    DROP CONSTRAINT IF EXISTS ck_daily_test_supp_data_cmp,
	DROP CONSTRAINT IF EXISTS ck_daily_test_supp_data_dti,
	DROP CONSTRAINT IF EXISTS ck_daily_test_supp_data_dtt,
	DROP CONSTRAINT IF EXISTS ck_daily_test_supp_data_ohc,
	DROP CONSTRAINT IF EXISTS ck_daily_test_supp_data_ssc,
	DROP CONSTRAINT IF EXISTS ck_daily_test_supp_data_stt,
	DROP CONSTRAINT IF EXISTS ck_daily_test_supp_data_trs;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_dcal_add_date;
DROP INDEX IF EXISTS camdecmps.daily_calibration_indx001;
DROP INDEX IF EXISTS camdecmps.idx_daily_calibrati_daily_test;
DROP INDEX IF EXISTS camdecmps.idx_daily_calibration_0002;
DROP INDEX IF EXISTS camdecmps.idx_daily_calibration_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_daily_calibrati_daily_test_sum_id;
DROP INDEX IF EXISTS camdecmps.idx_daily_calibration_vendor_id;
DROP INDEX IF EXISTS camdecmps.idx_daily_calibration_upscale_gas_level_cd;
DROP INDEX IF EXISTS camdecmps.idx_daily_calibration_injection_protocol_cd;

ALTER TABLE IF EXISTS camdecmps.daily_calibration
    DROP CONSTRAINT IF EXISTS pk_daily_calibration,
    DROP CONSTRAINT IF EXISTS fk_daily_calibration_daily_test_summary,
    DROP CONSTRAINT IF EXISTS fk_daily_calibration_gas_level_code,
    DROP CONSTRAINT IF EXISTS fk_daily_calibration_injection_protocol_code,
    DROP CONSTRAINT IF EXISTS fk_daily_calibration_protocol_gas_vendor,
    DROP CONSTRAINT IF EXISTS fk_daily_calibration_reporting_period;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_cycle_time_summary_001;
DROP INDEX IF EXISTS camdecmps.idx_cycle_time_summary_test_sum_id;

ALTER TABLE IF EXISTS camdecmps.cycle_time_summary
    DROP CONSTRAINT IF EXISTS pk_cycle_time_summary,
    DROP CONSTRAINT IF EXISTS fk_cycle_time_summary_test_summary;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_calibration_inj_upscale_ga;
DROP INDEX IF EXISTS camdecmps.idx_calibration_injection_001;
DROP INDEX IF EXISTS camdecmps.idx_calibration_injection_upscale_gas_level_cd;
DROP INDEX IF EXISTS camdecmps.idx_calibration_injection_test_sum_id;

ALTER TABLE IF EXISTS camdecmps.calibration_injection
    DROP CONSTRAINT IF EXISTS pk_calibration_injection,
    DROP CONSTRAINT IF EXISTS fk_calibration_injection_gas_level_code,
    DROP CONSTRAINT IF EXISTS fk_calibration_injection_test_summary;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_aet_testsumid;
DROP INDEX IF EXISTS camdecmps.idx_air_emission_testing_test_sum_id;

ALTER TABLE IF EXISTS camdecmps.air_emission_testing
    DROP CONSTRAINT IF EXISTS pk_air_emission_testing,
    DROP CONSTRAINT IF EXISTS fk_air_emission_testing_test_summary;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_ae_corr_test_sum_001;
DROP INDEX IF EXISTS camdecmps.idx_ae_correlation_test_sum_test_sum_id;

ALTER TABLE IF EXISTS camdecmps.ae_correlation_test_sum
    DROP CONSTRAINT IF EXISTS pk_ae_correlation_test_sum,
    DROP CONSTRAINT IF EXISTS fk_ae_correlation_test_sum_test_summary;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_wts_add_date;
DROP INDEX IF EXISTS camdecmps.idx_wts_calc_test;
DROP INDEX IF EXISTS camdecmps.idx_wts_component;
DROP INDEX IF EXISTS camdecmps.idx_wts_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_wts_span_scale;
DROP INDEX IF EXISTS camdecmps.idx_wts_sys;
DROP INDEX IF EXISTS camdecmps.idx_wts_test_resul;
DROP INDEX IF EXISTS camdecmps.idx_wts_test_type;
DROP INDEX IF EXISTS camdecmps.weekly_test_summary_idx002;
DROP INDEX IF EXISTS camdecmps.idx_weekly_test_summary_component_id;
DROP INDEX IF EXISTS camdecmps.idx_weekly_test_summary_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_weekly_test_summary_span_scale_cd;
DROP INDEX IF EXISTS camdecmps.idx_weekly_test_summary_mon_sys_id;
DROP INDEX IF EXISTS camdecmps.idx_weekly_test_summary_test_result_cd;
DROP INDEX IF EXISTS camdecmps.idx_weekly_test_summary_test_type_cd;
DROP INDEX IF EXISTS camdecmps.idx_weekly_test_summary_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_weekly_test_summary_rpt_period_id_mon_loc_id;

ALTER TABLE IF EXISTS camdecmps.weekly_test_summary
    DROP CONSTRAINT IF EXISTS pk_weekly_test_summary,
    DROP CONSTRAINT IF EXISTS fk_weekly_test_summary_test_result_code_calc,
    DROP CONSTRAINT IF EXISTS pk_weekly_test_summary,
    DROP CONSTRAINT IF EXISTS fk_weekly_test_summary_component,
    DROP CONSTRAINT IF EXISTS fk_weekly_test_summary_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_weekly_test_summary_monitor_system,
    DROP CONSTRAINT IF EXISTS fk_weekly_test_summary_reporting_period,
    DROP CONSTRAINT IF EXISTS fk_weekly_test_summary_span_scale_code,
    DROP CONSTRAINT IF EXISTS fk_weekly_test_summary_test_result_code,
    DROP CONSTRAINT IF EXISTS fk_weekly_test_summary_test_type_code;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_test_summary_calc_test;
DROP INDEX IF EXISTS camdecmps.idx_test_summary_chk_sessio;
DROP INDEX IF EXISTS camdecmps.idx_test_summary_component;
DROP INDEX IF EXISTS camdecmps.idx_test_summary_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_test_summary_mon_sys_id;
DROP INDEX IF EXISTS camdecmps.idx_test_summary_rpt_period;
DROP INDEX IF EXISTS camdecmps.idx_test_summary_span_scale;
DROP INDEX IF EXISTS camdecmps.idx_test_summary_test_reaso;
DROP INDEX IF EXISTS camdecmps.idx_test_summary_test_resul;
DROP INDEX IF EXISTS camdecmps.idx_test_summary_test_type;
DROP INDEX IF EXISTS camdecmps.idx_test_summary_chk_session_id;
DROP INDEX IF EXISTS camdecmps.idx_test_summary_component_id;
DROP INDEX IF EXISTS camdecmps.idx_test_summary_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_test_summary_mon_sys_id;
DROP INDEX IF EXISTS camdecmps.idx_test_summary_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_test_summary_span_scale_cd;
DROP INDEX IF EXISTS camdecmps.idx_test_summary_test_reason_cd;
DROP INDEX IF EXISTS camdecmps.idx_test_summary_test_result_cd;
DROP INDEX IF EXISTS camdecmps.idx_test_summary_test_type_cd;
DROP INDEX IF EXISTS camdecmps.idx_test_summary_injection_protocol_cd;
DROP INDEX IF EXISTS camdecmps.idx_test_summary_rpt_period_id_mon_loc_id;

ALTER TABLE IF EXISTS camdecmps.test_summary
	DROP CONSTRAINT IF EXISTS pk_test_summary,
	DROP CONSTRAINT IF EXISTS uq_test_summary,
	DROP CONSTRAINT IF EXISTS fk_test_summary_test_result_code_calc,
    DROP CONSTRAINT IF EXISTS fk_test_summary_component,
    DROP CONSTRAINT IF EXISTS fk_test_summary_injection_protocol_code,
    DROP CONSTRAINT IF EXISTS fk_test_summary_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_test_summary_monitor_system,
    DROP CONSTRAINT IF EXISTS fk_test_summary_reporting_period,
    DROP CONSTRAINT IF EXISTS fk_test_summary_span_scale_code,
    DROP CONSTRAINT IF EXISTS fk_test_summary_test_reason_code,
    DROP CONSTRAINT IF EXISTS fk_test_summary_test_result_code,
    DROP CONSTRAINT IF EXISTS fk_test_summary_test_type_code;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_test_extension__chk_sessio;
DROP INDEX IF EXISTS camdecmps.idx_test_extension__submission;
DROP INDEX IF EXISTS camdecmps.idx_test_extension_component;
DROP INDEX IF EXISTS camdecmps.idx_test_extension_extens_exe;
DROP INDEX IF EXISTS camdecmps.idx_test_extension_fuel_cd;
DROP INDEX IF EXISTS camdecmps.idx_test_extension_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_test_extension_mon_sys_id;
DROP INDEX IF EXISTS camdecmps.idx_test_extension_span_scale;
DROP INDEX IF EXISTS camdecmps.idx_test_extension_submission;
DROP INDEX IF EXISTS camdecmps.test_ext_exempt_idx001;
DROP INDEX IF EXISTS camdecmps.idx_test_extension_exemption_chk_session_id;
DROP INDEX IF EXISTS camdecmps.idx_test_extension_exemption_submission_id;
DROP INDEX IF EXISTS camdecmps.idx_test_extension_exemption_component_id;
DROP INDEX IF EXISTS camdecmps.idx_test_extension_exemption_extens_exempt_cd;
DROP INDEX IF EXISTS camdecmps.idx_test_extension_exemption_fuel_cd;
DROP INDEX IF EXISTS camdecmps.idx_test_extension_exemption_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_test_extension_exemption_mon_sys_id;
DROP INDEX IF EXISTS camdecmps.idx_test_extension_exemption_span_scale_cd;
DROP INDEX IF EXISTS camdecmps.idx_test_extension_exemption_submission_availability_cd;
DROP INDEX IF EXISTS camdecmps.idx_test_extension_exemption_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_test_extension_exemption_rpt_period_id_mon_loc_id;

ALTER TABLE IF EXISTS camdecmps.test_extension_exemption
    DROP CONSTRAINT IF EXISTS pk_test_extension_exemption,
    DROP CONSTRAINT IF EXISTS fk_test_extension_exemption_component,
    DROP CONSTRAINT IF EXISTS fk_test_extension_exemption_extension_exemption_code,
    DROP CONSTRAINT IF EXISTS fk_test_extension_exemption_fuel_code,
    DROP CONSTRAINT IF EXISTS fk_test_extension_exemption_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_test_extension_exemption_monitor_system,
    DROP CONSTRAINT IF EXISTS fk_test_extension_exemption_reporting_period,
    DROP CONSTRAINT IF EXISTS fk_test_extension_exemption_span_scale_code,
    DROP CONSTRAINT IF EXISTS fk_test_extension_exemption_submission_availability_code;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_system_op_supp_data_cod;
DROP INDEX IF EXISTS camdecmps.idx_system_op_supp_data_emr;
DROP INDEX IF EXISTS camdecmps.idx_system_op_supp_data_loc;
DROP INDEX IF EXISTS camdecmps.idx_system_op_supp_data_prd;
DROP INDEX IF EXISTS camdecmps.idx_system_op_supp_data_sys;
DROP INDEX IF EXISTS camdecmps.idx_system_op_supp_data_op_supp_data_type_cd;
DROP INDEX IF EXISTS camdecmps.idx_system_op_supp_data_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_system_op_supp_data_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_system_op_supp_data_mon_sys_id;
DROP INDEX IF EXISTS camdecmps.idx_system_op_supp_data_rpt_period_id_mon_loc_id;
 
ALTER TABLE IF EXISTS camdecmps.system_op_supp_data
	DROP CONSTRAINT IF EXISTS pk_system_op_supp_data,
	DROP CONSTRAINT IF EXISTS fk_system_op_supp_data_cod,
	DROP CONSTRAINT IF EXISTS fk_system_op_supp_data_op_supp_data_type_code,
    DROP CONSTRAINT IF EXISTS fk_system_op_supp_data_prd,
    DROP CONSTRAINT IF EXISTS fk_system_op_supp_data_reporting_period,
    DROP CONSTRAINT IF EXISTS fk_system_op_supp_data_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_system_op_supp_data_monitor_system;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_system_fuel_flo_max_rate_s;
DROP INDEX IF EXISTS camdecmps.idx_system_fuel_flo_mon_sys_id;
DROP INDEX IF EXISTS camdecmps.idx_system_fuel_flo_sys_fuel_u;
DROP INDEX IF EXISTS camdecmps.idx_system_fuel_flow_max_rate_source_cd;
DROP INDEX IF EXISTS camdecmps.idx_system_fuel_flow_mon_sys_id;
DROP INDEX IF EXISTS camdecmps.idx_system_fuel_flow_sys_fuel_uom_cd;

ALTER TABLE IF EXISTS camdecmps.system_fuel_flow
    DROP CONSTRAINT IF EXISTS pk_system_fuel_flow,
    DROP CONSTRAINT IF EXISTS fk_system_fuel_flow_max_rate_source_code,
    DROP CONSTRAINT IF EXISTS fk_system_fuel_flow_monitor_system,
    DROP CONSTRAINT IF EXISTS fk_system_fuel_flow_units_of_measure_code;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_sorbent_trap_001;
DROP INDEX IF EXISTS camdecmps.idx_trap_add_date;
DROP INDEX IF EXISTS camdecmps.idx_trap_modc_cd;
DROP INDEX IF EXISTS camdecmps.idx_trap_sys_id;
DROP INDEX IF EXISTS camdecmps.idx_sorbent_trap_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_sorbent_trap_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_sorbent_trap_modc_cd;
DROP INDEX IF EXISTS camdecmps.idx_sorbent_trap_sorbent_trap_aps_cd;
DROP INDEX IF EXISTS camdecmps.idx_sorbent_trap_mon_sys_id;
DROP INDEX IF EXISTS camdecmps.idx_sorbent_trap_rpt_period_id_mon_loc_id;

ALTER TABLE IF EXISTS camdecmps.sorbent_trap
    DROP CONSTRAINT IF EXISTS pk_sorbent_trap,
    DROP CONSTRAINT IF EXISTS fk_sorbent_trap_modc_code,
    DROP CONSTRAINT IF EXISTS fk_sorbent_trap_modc_code_calc,
    DROP CONSTRAINT IF EXISTS fk_sorbent_trap_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_sorbent_trap_monitor_system,
    DROP CONSTRAINT IF EXISTS fk_sorbent_trap_reporting_period,
    DROP CONSTRAINT IF EXISTS fk_sorbent_trap_sorbent_trap_aps_code;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_st_supp_data_emr;
DROP INDEX IF EXISTS camdecmps.idx_st_supp_data_modc;
DROP INDEX IF EXISTS camdecmps.idx_st_supp_data_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_st_supp_data_mon_sys_id;
DROP INDEX IF EXISTS camdecmps.st_supp_data_idx001;
DROP INDEX IF EXISTS camdecmps.idx_sorbent_trap_supp_data_modc_cd;
DROP INDEX IF EXISTS camdecmps.idx_sorbent_trap_supp_data_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_sorbent_trap_supp_data_mon_sys_id;
DROP INDEX IF EXISTS camdecmps.idx_sorbent_trap_supp_data_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_sorbent_trap_supp_data_rpt_period_id_mon_loc_id;

ALTER TABLE IF EXISTS camdecmps.sorbent_trap_supp_data
    DROP CONSTRAINT IF EXISTS pk_st_supp_data,
    DROP CONSTRAINT IF EXISTS fk_sorbent_trap_supp_data_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_sorbent_trap_supp_data_monitor_system,
    DROP CONSTRAINT IF EXISTS fk_st_supp_data_aps_cd,
    DROP CONSTRAINT IF EXISTS fk_st_supp_data_modc_cd,
    DROP CONSTRAINT IF EXISTS fk_st_supp_data_rpt_period_id;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_qa_cert_event_chk_sessio;
DROP INDEX IF EXISTS camdecmps.idx_qa_cert_event_component;
DROP INDEX IF EXISTS camdecmps.idx_qa_cert_event_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_qa_cert_event_mon_sys_id;
DROP INDEX IF EXISTS camdecmps.idx_qa_cert_event_qa_cert_ev;
DROP INDEX IF EXISTS camdecmps.idx_qa_cert_event_required_t;
DROP INDEX IF EXISTS camdecmps.idx_qa_cert_event_submission;
DROP INDEX IF EXISTS camdecmps.idx_qa_cert_event_submission1;
DROP INDEX IF EXISTS camdecmps.idx_qa_cert_event_chk_session_id;
DROP INDEX IF EXISTS camdecmps.idx_qa_cert_event_component_id;
DROP INDEX IF EXISTS camdecmps.idx_qa_cert_event_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_qa_cert_event_mon_sys_id;
DROP INDEX IF EXISTS camdecmps.idx_qa_cert_event_qa_cert_event_cd;
DROP INDEX IF EXISTS camdecmps.idx_qa_cert_event_required_test_cd;
DROP INDEX IF EXISTS camdecmps.idx_qa_cert_event_submission_availability_cd;
DROP INDEX IF EXISTS camdecmps.idx_qa_cert_event_submission_id;

ALTER TABLE IF EXISTS camdecmps.qa_cert_event
	DROP CONSTRAINT IF EXISTS pk_qa_cert_event,
    DROP CONSTRAINT IF EXISTS fk_qa_cert_event_component,
    DROP CONSTRAINT IF EXISTS fk_qa_cert_event_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_qa_cert_event_monitor_system,
    DROP CONSTRAINT IF EXISTS fk_qa_cert_event_qa_cert_event_code,
    DROP CONSTRAINT IF EXISTS fk_qa_cert_event_required_test_code,
    DROP CONSTRAINT IF EXISTS fk_qa_cert_event_submission_availability_code;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_nsps4t_compliance_prd_loc;
DROP INDEX IF EXISTS camdecmps.idx_nsps4t_compliance_prd_prd;
DROP INDEX IF EXISTS camdecmps.idx_nsps4t_compliance_prd_rpt;
DROP INDEX IF EXISTS camdecmps.idx_nsps4t_compliance_prd_sum;
DROP INDEX IF EXISTS camdecmps.idx_nsps4t_compliance_prd_uom;
DROP INDEX IF EXISTS camdecmps.idx_nsps4t_compliance_period_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_nsps4t_compliance_period_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_nsps4t_compliance_period_nsps4t_sum_id;
DROP INDEX IF EXISTS camdecmps.idx_nsps4t_compliance_period_co2_emission_rate_uom_cd;
DROP INDEX IF EXISTS camdecmps.idx_nsps4t_compliance_period_rpt_period_id_mon_loc_id;

ALTER TABLE IF EXISTS camdecmps.nsps4t_compliance_period
    DROP CONSTRAINT IF EXISTS pk_nsps4t_compliance_period,
    DROP CONSTRAINT IF EXISTS fk_nsps4t_compliance_period_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_nsps4t_compliance_period_nsps4t_summary,
    DROP CONSTRAINT IF EXISTS fk_nsps4t_compliance_period_reporting_period,
    DROP CONSTRAINT IF EXISTS fk_nsps4t_compliance_period_units_of_measure_code;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_nsps4t_annual_loc;
DROP INDEX IF EXISTS camdecmps.idx_nsps4t_annual_prd;
DROP INDEX IF EXISTS camdecmps.idx_nsps4t_annual_rpt;
DROP INDEX IF EXISTS camdecmps.idx_nsps4t_annual_sum;
DROP INDEX IF EXISTS camdecmps.idx_nsps4t_annual_uom;
DROP INDEX IF EXISTS camdecmps.idx_nsps4t_annual_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_nsps4t_annual_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_nsps4t_annual_nsps4t_sum_id;
DROP INDEX IF EXISTS camdecmps.idx_nsps4t_annual_annual_energy_sold_type_cd;
DROP INDEX IF EXISTS camdecmps.idx_nsps4t_annual_rpt_period_id_mon_loc_id;

ALTER TABLE IF EXISTS camdecmps.nsps4t_annual
    DROP CONSTRAINT IF EXISTS pk_nsps4t_annual,
    DROP CONSTRAINT IF EXISTS fk_nsps4t_annual_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_nsps4t_annual_nsps4t_electrical_load_code,
    DROP CONSTRAINT IF EXISTS fk_nsps4t_annual_nsps4t_summary,
    DROP CONSTRAINT IF EXISTS fk_nsps4t_annual_reporting_period;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_mon_sys_comp_01;
DROP INDEX IF EXISTS camdecmps.idx_monitor_system_component_;
DROP INDEX IF EXISTS camdecmps.idx_monitor_system_component_mon_sys_id;
DROP INDEX IF EXISTS camdecmps.idx_monitor_system_component_component_id;

ALTER TABLE IF EXISTS camdecmps.monitor_system_component
    DROP CONSTRAINT IF EXISTS pk_monitor_system_component,
    DROP CONSTRAINT IF EXISTS fk_monitor_system_component_component,
    DROP CONSTRAINT IF EXISTS fk_monitor_system_component_monitor_system;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_monitor_qualification_pct_mon_qual_id;
DROP INDEX IF EXISTS camdecmps.idx_monitor_qualification_pct_yr1_qual_data_type_cd;
DROP INDEX IF EXISTS camdecmps.idx_monitor_qualification_pct_yr2_qual_data_type_cd;
DROP INDEX IF EXISTS camdecmps.idx_monitor_qualification_pct_yr3_qual_data_type_cd;

ALTER TABLE IF EXISTS camdecmps.monitor_qualification_pct
    DROP CONSTRAINT IF EXISTS pk_monitor_qualification_pct,
    DROP CONSTRAINT IF EXISTS fk_monitor_qualification_pct_monitor_qualification,
    DROP CONSTRAINT IF EXISTS fk_monitor_qualification_pct_qual_data_type_code_yr1,
    DROP CONSTRAINT IF EXISTS fk_monitor_qualification_pct_qual_data_type_code_yr2,
    DROP CONSTRAINT IF EXISTS fk_monitor_qualification_pct_qual_data_type_code_yr3;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_monitor_qualification_lme_mon_qual_id;

ALTER TABLE IF EXISTS camdecmps.monitor_qualification_lme
    DROP CONSTRAINT IF EXISTS pk_monitor_qualification_lme,
    DROP CONSTRAINT IF EXISTS fk_monitor_qualification_lme_monitor_qualification;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_monitor_qualification_lee_emission_standard_uom;
DROP INDEX IF EXISTS camdecmps.idx_monitor_qualification_lee_mon_qual_id;
DROP INDEX IF EXISTS camdecmps.idx_monitor_qualification_lee_parameter_cd;
DROP INDEX IF EXISTS camdecmps.idx_monitor_qualification_lee_qaul_lee_test_type_cd;
DROP INDEX IF EXISTS camdecmps.idx_monitor_qualification_lee_emission_standard_uom;
DROP INDEX IF EXISTS camdecmps.idx_monitor_qualification_lee_mon_qual_id;
DROP INDEX IF EXISTS camdecmps.idx_monitor_qualification_lee_parameter_cd;
DROP INDEX IF EXISTS camdecmps.idx_monitor_qualification_lee_qaul_lee_test_type_cd;

ALTER TABLE IF EXISTS camdecmps.monitor_qualification_lee
    DROP CONSTRAINT IF EXISTS pk_monitor_qualification_lee,
    DROP CONSTRAINT IF EXISTS fk_monitor_qualification_lee_monitor_qualification,
    DROP CONSTRAINT IF EXISTS fk_monitor_qualification_lee_parameter_code,
    DROP CONSTRAINT IF EXISTS fk_monitor_qualification_lee_qual_test_type_code,
    DROP CONSTRAINT IF EXISTS fk_monitor_qualification_lee_units_of_measure_code;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_monitor_qualification_cpms_mon_qual_id;

ALTER TABLE IF EXISTS camdecmps.monitor_qualification_cpms
	DROP CONSTRAINT IF EXISTS pk_monitor_qualification_cpms,
  	DROP CONSTRAINT IF EXISTS fk_monitor_qualification_cpms_monitor_qualification;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_mhv_add_date;
DROP INDEX IF EXISTS camdecmps.idx_mon_hrly_param1;
DROP INDEX IF EXISTS camdecmps.idx_mon_hrly_param2;
DROP INDEX IF EXISTS camdecmps.idx_monitor_hrly_va_component;
DROP INDEX IF EXISTS camdecmps.idx_monitor_hrly_va_mon_sys_id;
DROP INDEX IF EXISTS camdecmps.idx_monitor_hrly_va_parameter_;
DROP INDEX IF EXISTS camdecmps.monitor_hrly_value_idx003;
DROP INDEX IF EXISTS camdecmps.idx_monitor_hrly_value_hour_id;
DROP INDEX IF EXISTS camdecmps.idx_monitor_hrly_value_mon_sys_id;
DROP INDEX IF EXISTS camdecmps.idx_monitor_hrly_value_component_id;
DROP INDEX IF EXISTS camdecmps.idx_monitor_hrly_value_parameter_cd;
DROP INDEX IF EXISTS camdecmps.idx_monitor_hrly_value_modc_cd;
DROP INDEX IF EXISTS camdecmps.idx_monitor_hrly_value_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_monitor_hrly_value_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_monitor_hrly_value_rpt_period_id_mon_loc_id;

ALTER TABLE IF EXISTS camdecmps.monitor_hrly_value
    DROP CONSTRAINT IF EXISTS pk_monitor_hrly_value,
    DROP CONSTRAINT IF EXISTS fk_monitor_hrly_value_component,
    DROP CONSTRAINT IF EXISTS fk_monitor_hrly_value_hrly_op_data,
    DROP CONSTRAINT IF EXISTS fk_monitor_hrly_value_modc_code,
    DROP CONSTRAINT IF EXISTS fk_monitor_hrly_value_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_monitor_hrly_value_monitor_system,
    DROP CONSTRAINT IF EXISTS fk_monitor_hrly_value_parameter_code,
    DROP CONSTRAINT IF EXISTS fk_monitor_hrly_value_reporting_period,
    DROP CONSTRAINT IF EXISTS chk_monitor_hrly_value_hour_id,
    DROP CONSTRAINT IF EXISTS chk_monitor_hrly_value_mon_loc_id,
    DROP CONSTRAINT IF EXISTS chk_monitor_hrly_value_monitor_hrly_val_id,
    DROP CONSTRAINT IF EXISTS chk_monitor_hrly_value_parameter_cd,
    DROP CONSTRAINT IF EXISTS chk_monitor_hrly_value_rpt_period_id,
    DROP CONSTRAINT IF EXISTS monitor_hrly_value_hour_id_check,
    DROP CONSTRAINT IF EXISTS monitor_hrly_value_mon_loc_id_check,
    DROP CONSTRAINT IF EXISTS monitor_hrly_value_monitor_hrly_val_id_check,
    DROP CONSTRAINT IF EXISTS monitor_hrly_value_parameter_cd_check,
    DROP CONSTRAINT IF EXISTS monitor_hrly_value_rpt_period_id_check;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_matsmhv_add_date;
DROP INDEX IF EXISTS camdecmps.idx_matsmhv_component;
DROP INDEX IF EXISTS camdecmps.idx_matsmhv_mon_sys_id;
DROP INDEX IF EXISTS camdecmps.idx_matsmhv_param1;
DROP INDEX IF EXISTS camdecmps.idx_matsmhv_param2;
DROP INDEX IF EXISTS camdecmps.idx_matsmhv_parameter_;
DROP INDEX IF EXISTS camdecmps.idx_matsmhv_rpt_per_loc;
DROP INDEX IF EXISTS camdecmps.idx_mats_monitor_hrly_value_component_id;
DROP INDEX IF EXISTS camdecmps.idx_mats_monitor_hrly_value_hour_id;
DROP INDEX IF EXISTS camdecmps.idx_mats_monitor_hrly_value_modc_cd;
DROP INDEX IF EXISTS camdecmps.idx_mats_monitor_hrly_value_mon_sys_id;
DROP INDEX IF EXISTS camdecmps.idx_mats_monitor_hrly_value_parameter_cd;
DROP INDEX IF EXISTS camdecmps.idx_mats_monitor_hrly_value_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_mats_monitor_hrly_value_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_mats_monitor_hrly_value_rpt_period_id_mon_loc_id;

ALTER TABLE IF EXISTS camdecmps.mats_monitor_hrly_value
    DROP CONSTRAINT IF EXISTS pk_mats_monitor_hrly_value,
    DROP CONSTRAINT IF EXISTS fk_mats_monitor_hrly_value_component,
    DROP CONSTRAINT IF EXISTS fk_mats_monitor_hrly_value_hrly_op_data,
    DROP CONSTRAINT IF EXISTS fk_mats_monitor_hrly_value_modc_code,
    DROP CONSTRAINT IF EXISTS fk_mats_monitor_hrly_value_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_mats_monitor_hrly_value_monitor_system,
    DROP CONSTRAINT IF EXISTS fk_mats_monitor_hrly_value_parameter_code,
    DROP CONSTRAINT IF EXISTS fk_mats_monitor_hrly_value_reporting_period;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_matsdhv_002;
DROP INDEX IF EXISTS camdecmps.idx_matsdhv_add_date;
DROP INDEX IF EXISTS camdecmps.idx_matsdhv_hour_id;
DROP INDEX IF EXISTS camdecmps.idx_matsdhv_mon_form_id;
DROP INDEX IF EXISTS camdecmps.idx_matsdhv_parameter_;
DROP INDEX IF EXISTS camdecmps.matsdhv_idx001;
DROP INDEX IF EXISTS camdecmps.idx_mats_derived_hrly_value_hour_id;
DROP INDEX IF EXISTS camdecmps.idx_mats_derived_hrly_value_mon_form_id;
DROP INDEX IF EXISTS camdecmps.idx_mats_derived_hrly_value_parameter_cd;
DROP INDEX IF EXISTS camdecmps.idx_mats_derived_hrly_value_modc_cd;
DROP INDEX IF EXISTS camdecmps.idx_mats_derived_hrly_value_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_mats_derived_hrly_value_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_mats_derived_hrly_value_rpt_period_id_mon_loc_id;

ALTER TABLE IF EXISTS camdecmps.mats_derived_hrly_value
    DROP CONSTRAINT IF EXISTS pk_mats_derived_hrly_value,
    DROP CONSTRAINT IF EXISTS fk_mats_derived_hrly_value_hrly_op_data,
    DROP CONSTRAINT IF EXISTS fk_mats_derived_hrly_value_modc_code,
    DROP CONSTRAINT IF EXISTS fk_mats_derived_hrly_value_monitor_formula,
    DROP CONSTRAINT IF EXISTS fk_mats_derived_hrly_value_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_mats_derived_hrly_value_parameter_code,
    DROP CONSTRAINT IF EXISTS fk_mats_derived_hrly_value_reporting_period;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_long_term_fuel_flow_emr;
DROP INDEX IF EXISTS camdecmps.idx_long_term_fuel_fuel_flow;
DROP INDEX IF EXISTS camdecmps.idx_long_term_fuel_gcv_uom_cd;
DROP INDEX IF EXISTS camdecmps.idx_long_term_fuel_ltff_uom_c;
DROP INDEX IF EXISTS camdecmps.idx_long_term_fuel_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_long_term_fuel_mon_sys_id;
DROP INDEX IF EXISTS camdecmps.idx_ltff_add_date;
DROP INDEX IF EXISTS camdecmps.long_term_fuel_flow_idx001;
DROP INDEX IF EXISTS camdecmps.idx_long_term_fuel_fuel_flow_fuel_flow_period_cd;
DROP INDEX IF EXISTS camdecmps.idx_long_term_fuel_fuel_flow_gcv_uom_cd;
DROP INDEX IF EXISTS camdecmps.idx_long_term_fuel_fuel_flow_ltff_uom_cd;
DROP INDEX IF EXISTS camdecmps.idx_long_term_fuel_fuel_flow_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_long_term_fuel_fuel_flow_mon_sys_id;
DROP INDEX IF EXISTS camdecmps.idx_long_term_fuel_flow_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_long_term_fuel_flow_rpt_period_id_mon_loc_id;

ALTER TABLE IF EXISTS camdecmps.long_term_fuel_flow
    DROP CONSTRAINT IF EXISTS pk_long_term_fuel_flow,
    DROP CONSTRAINT IF EXISTS fk_long_term_fuel_flow_fuel_flow_period_code,
    DROP CONSTRAINT IF EXISTS fk_long_term_fuel_flow_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_long_term_fuel_flow_monitor_system,
    DROP CONSTRAINT IF EXISTS fk_long_term_fuel_flow_reporting_period,
    DROP CONSTRAINT IF EXISTS fk_long_term_fuel_flow_units_of_measure_code_gcv,
    DROP CONSTRAINT IF EXISTS fk_long_term_fuel_flow_units_of_measure_code_ltff;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_last_qa_value_supp_data_cp;
DROP INDEX IF EXISTS camdecmps.idx_last_qa_value_supp_data_er;
DROP INDEX IF EXISTS camdecmps.idx_last_qa_value_supp_data_ml;
DROP INDEX IF EXISTS camdecmps.idx_last_qa_value_supp_data_ms;
DROP INDEX IF EXISTS camdecmps.idx_last_qa_value_supp_data_pc;
DROP INDEX IF EXISTS camdecmps.idx_last_qa_value_supp_data_pr;
DROP INDEX IF EXISTS camdecmps.idx_last_qa_value_supp_data_component_id;
DROP INDEX IF EXISTS camdecmps.idx_last_qa_value_supp_data_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_last_qa_value_supp_data_mon_sys_id;
DROP INDEX IF EXISTS camdecmps.idx_last_qa_value_supp_data_parameter_cd;
DROP INDEX IF EXISTS camdecmps.idx_last_qa_value_supp_data_hourly_type_cd;
DROP INDEX IF EXISTS camdecmps.idx_last_qa_value_supp_data_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_last_qa_value_supp_data_rpt_period_id_mon_loc_id;

ALTER TABLE IF EXISTS camdecmps.last_qa_value_supp_data
	DROP CONSTRAINT IF EXISTS pk_last_qa_value_supp_data,
	DROP CONSTRAINT IF EXISTS fk_last_qa_value_supp_data_ht,
    DROP CONSTRAINT IF EXISTS fk_last_qa_value_supp_data_pc,
    DROP CONSTRAINT IF EXISTS fk_last_qa_value_supp_data_pr,
    DROP CONSTRAINT IF EXISTS fk_last_qa_value_supp_data_component,
    DROP CONSTRAINT IF EXISTS fk_last_qa_value_supp_data_hourly_type_code,
    DROP CONSTRAINT IF EXISTS fk_last_qa_value_supp_data_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_last_qa_value_supp_data_monitor_system,
    DROP CONSTRAINT IF EXISTS fk_last_qa_value_supp_data_parameter_code,
    DROP CONSTRAINT IF EXISTS fk_last_qa_value_supp_data_reporting_period;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_component_id;
DROP INDEX IF EXISTS camdecmps.idx_hrlygfm_001;
DROP INDEX IF EXISTS camdecmps.idx_hrlygfm_add_date;
DROP INDEX IF EXISTS camdecmps.idx_hrlygfm_hour_id;
DROP INDEX IF EXISTS camdecmps.idx_hrly_gas_flow_meter_hour_id;
DROP INDEX IF EXISTS camdecmps.idx_hrly_gas_flow_meter_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_hrly_gas_flow_meter_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_hrly_gas_flow_meter_component_id;
DROP INDEX IF EXISTS camdecmps.idx_hrly_gas_flow_meter_begin_end_hour_flg;
DROP INDEX IF EXISTS camdecmps.idx_hrly_gas_flow_meter_sampling_rate_uom;
DROP INDEX IF EXISTS camdecmps.idx_hrly_gas_flow_meter_rpt_period_id_mon_loc_id;

ALTER TABLE IF EXISTS camdecmps.hrly_gas_flow_meter
    DROP CONSTRAINT IF EXISTS pk_hrly_gas_flow_meter,
    DROP CONSTRAINT IF EXISTS fk_hrly_gas_flow_meter_component,
    DROP CONSTRAINT IF EXISTS fk_hrly_gas_flow_meter_hrly_op_data,
    DROP CONSTRAINT IF EXISTS fk_hrly_gas_flow_meter_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_hrly_gas_flow_meter_reporting_period,
	DROP CONSTRAINT IF EXISTS fk_hrly_gas_flow_meter_begin_end_hour_flg,
	DROP CONSTRAINT IF EXISTS fk_hrly_gas_flow_meter_sampling_rate_uom;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.hrly_fuel_flow_idx001;
DROP INDEX IF EXISTS camdecmps.idx_hff_add_date;
DROP INDEX IF EXISTS camdecmps.idx_hrly_fuel_flow_fuel_cd;
DROP INDEX IF EXISTS camdecmps.idx_hrly_fuel_flow_hour_id;
DROP INDEX IF EXISTS camdecmps.idx_hrly_fuel_flow_mon_sys_id;
DROP INDEX IF EXISTS camdecmps.idx_hrly_fuel_flow_sod_mass_c;
DROP INDEX IF EXISTS camdecmps.idx_hrly_fuel_flow_sod_volume;
DROP INDEX IF EXISTS camdecmps.idx_hrly_fuel_flow_volumetric;
DROP INDEX IF EXISTS camdecmps.idx_hrly_fuel_flow_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_hrly_fuel_flow_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_hrly_fuel_flow_fuel_cd;
DROP INDEX IF EXISTS camdecmps.idx_hrly_fuel_flow_hour_id;
DROP INDEX IF EXISTS camdecmps.idx_hrly_fuel_flow_mon_sys_id;
DROP INDEX IF EXISTS camdecmps.idx_hrly_fuel_flow_sod_mass_cd;
DROP INDEX IF EXISTS camdecmps.idx_hrly_fuel_flow_sod_volumetric_cd;
DROP INDEX IF EXISTS camdecmps.idx_hrly_fuel_flow_volumetric_uom_cd;
DROP INDEX IF EXISTS camdecmps.idx_hrly_fuel_flow_rpt_period_id_mon_loc_id;

ALTER TABLE If EXISTS camdecmps.hrly_fuel_flow
    DROP CONSTRAINT IF EXISTS pk_hrly_fuel_flow,
    DROP CONSTRAINT IF EXISTS fk_hrly_fuel_flow_fuel_code,
    DROP CONSTRAINT IF EXISTS fk_hrly_fuel_flow_hrly_op_data,
    DROP CONSTRAINT IF EXISTS fk_hrly_fuel_flow_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_hrly_fuel_flow_monitor_system,
    DROP CONSTRAINT IF EXISTS fk_hrly_fuel_flow_reporting_period,
    DROP CONSTRAINT IF EXISTS fk_hrly_fuel_flow_sod_mass_code,
    DROP CONSTRAINT IF EXISTS fk_hrly_fuel_flow_sod_volumetric_code,
    DROP CONSTRAINT IF EXISTS fk_hrly_fuel_flow_units_of_measure_code;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.derived_hrly_value_idx001;
DROP INDEX IF EXISTS camdecmps.idx_derived_hrly_frm;
DROP INDEX IF EXISTS camdecmps.idx_derived_hrly_va_fuel_cd;
DROP INDEX IF EXISTS camdecmps.idx_derived_hrly_va_hour_id;
DROP INDEX IF EXISTS camdecmps.idx_derived_hrly_va_mon_form_i;
DROP INDEX IF EXISTS camdecmps.idx_derived_hrly_va_mon_sys_id;
DROP INDEX IF EXISTS camdecmps.idx_derived_hrly_va_operating;
DROP INDEX IF EXISTS camdecmps.idx_derived_hrly_va_parameter_;
DROP INDEX IF EXISTS camdecmps.idx_dhv_add_date;
DROP INDEX IF EXISTS camdecmps.idx_derived_hrly_value_fuel_cd;
DROP INDEX IF EXISTS camdecmps.idx_derived_hrly_value_hour_id;
DROP INDEX IF EXISTS camdecmps.idx_derived_hrly_value_mon_form_id;
DROP INDEX IF EXISTS camdecmps.idx_derived_hrly_value_mon_sys_id;
DROP INDEX IF EXISTS camdecmps.idx_derived_hrly_value_operating_condition_cd;
DROP INDEX IF EXISTS camdecmps.idx_derived_hrly_value_parameter_cd;
DROP INDEX IF EXISTS camdecmps.idx_derived_hrly_value_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_derived_hrly_value_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_derived_hrly_value_rpt_period_id_mon_loc_id;

ALTER TABLE IF EXISTS camdecmps.derived_hrly_value
    DROP CONSTRAINT IF EXISTS pk_derived_hrly_value,
    DROP CONSTRAINT IF EXISTS fk_derived_hrly_value_fuel_code,
    DROP CONSTRAINT IF EXISTS fk_derived_hrly_value_hrly_op_data,
    DROP CONSTRAINT IF EXISTS fk_derived_hrly_value_modc_code,
    DROP CONSTRAINT IF EXISTS fk_derived_hrly_value_monitor_formula,
    DROP CONSTRAINT IF EXISTS fk_derived_hrly_value_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_derived_hrly_value_monitor_system,
    DROP CONSTRAINT IF EXISTS fk_derived_hrly_value_operating_condition_code,
    DROP CONSTRAINT IF EXISTS fk_derived_hrly_value_parameter_code,
    DROP CONSTRAINT IF EXISTS fk_derived_hrly_value_reporting_period;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.daily_test_summary_idx002;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_summ_calc_test;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_summ_component;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_summ_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_summ_span_scale;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_summ_test_resul;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_summ_test_type;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_summary_01;
DROP INDEX IF EXISTS camdecmps.idx_dts_add_date;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_summary_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_summary_component_id;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_summary_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_summary_span_scale_cd;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_summary_test_result_cd;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_summary_test_type_cd;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_summary_mon_sys_id;
DROP INDEX IF EXISTS camdecmps.idx_daily_test_summary_rpt_period_id_mon_loc_id;

ALTER TABLE IF EXISTS camdecmps.daily_test_summary
    DROP CONSTRAINT IF EXISTS pk_daily_test_summary,
    DROP CONSTRAINT IF EXISTS fk_daily_test_summary_component,
    DROP CONSTRAINT IF EXISTS fk_daily_test_summary_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_daily_test_summary_monitor_system,
    DROP CONSTRAINT IF EXISTS fk_daily_test_summary_reporting_period,
    DROP CONSTRAINT IF EXISTS fk_daily_test_summary_span_scale_code,
    DROP CONSTRAINT IF EXISTS fk_daily_test_summary_test_result_code,
    DROP CONSTRAINT IF EXISTS fk_daily_test_summary_test_result_code_calc,
    DROP CONSTRAINT IF EXISTS fk_daily_test_summary_test_type_code;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_daily_fuel_01;
DROP INDEX IF EXISTS camdecmps.idx_daily_fuel_prd_loc;
DROP INDEX IF EXISTS camdecmps.idx_daily_fuel_daily_emission_id;
DROP INDEX IF EXISTS camdecmps.idx_daily_fuel_fuel_cd;
DROP INDEX IF EXISTS camdecmps.idx_daily_fuel_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_daily_fuel_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_daily_fuel_rpt_period_id_mon_loc_id;

ALTER TABLE IF EXISTS camdecmps.daily_fuel
    DROP CONSTRAINT IF EXISTS pk_daily_fuel,
    DROP CONSTRAINT IF EXISTS fk_daily_fuel_daily_emission,
    DROP CONSTRAINT IF EXISTS fk_daily_fuel_fuel_code,
    DROP CONSTRAINT IF EXISTS fk_daily_fuel_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_daily_fuel_reporting_period;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_component_op_supp_data_cmp;
DROP INDEX IF EXISTS camdecmps.idx_component_op_supp_data_cod;
DROP INDEX IF EXISTS camdecmps.idx_component_op_supp_data_emr;
DROP INDEX IF EXISTS camdecmps.idx_component_op_supp_data_loc;
DROP INDEX IF EXISTS camdecmps.idx_component_op_supp_data_prd;
DROP INDEX IF EXISTS camdecmps.idx_component_op_supp_data_component_id;
DROP INDEX IF EXISTS camdecmps.idx_component_op_supp_data_op_supp_data_type_cd;
DROP INDEX IF EXISTS camdecmps.idx_component_op_supp_data_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_component_op_supp_data_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_component_op_supp_data_rpt_period_id_mon_loc_id;

ALTER TABLE IF EXISTS camdecmps.component_op_supp_data
	DROP CONSTRAINT IF EXISTS pk_component_op_supp_data,
	DROP CONSTRAINT IF EXISTS fk_component_op_supp_data_cod,
	DROP CONSTRAINT IF EXISTS fk_component_op_supp_data_prd,
    DROP CONSTRAINT IF EXISTS fk_component_op_supp_data_component,
    DROP CONSTRAINT IF EXISTS fk_component_op_supp_data_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_component_op_supp_data_op_supp_data_type_code,
    DROP CONSTRAINT IF EXISTS fk_component_op_supp_data_reporting_period;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_analyzer_range_analyzer_r;
DROP INDEX IF EXISTS camdecmps.idx_analyzer_range_component;
DROP INDEX IF EXISTS camdecmps.idx_analyzer_range_analyzer_range_cd;
DROP INDEX IF EXISTS camdecmps.idx_analyzer_range_component_id;

ALTER TABLE IF EXISTS camdecmps.analyzer_range
    DROP CONSTRAINT IF EXISTS pk_analyzer_range,
    DROP CONSTRAINT IF EXISTS fk_analyzer_range_analyzer_range_code,
    DROP CONSTRAINT IF EXISTS fk_analyzer_range_component,
    DROP CONSTRAINT IF EXISTS ck_analyzer_range_begin_date_end_date;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS idx_used_identifier_mon_loc_id;
DROP INDEX IF EXISTS idx_used_identifier_table_cd;
DROP INDEX IF EXISTS idx_used_identifier_identifier;
DROP INDEX IF EXISTS idx_used_identifier_type_or_parameter_cd;
DROP INDEX IF EXISTS idx_used_identifier_formula_or_basis_cd;

ALTER TABLE IF EXISTS camdecmps.used_identifier
    DROP CONSTRAINT IF EXISTS pk_used_identifier,
    DROP CONSTRAINT IF EXISTS fk_monitor_locat_used_identifi,
    DROP CONSTRAINT IF EXISTS fk_used_identifier_monitor_location;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_summary_value_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_sv_add_date;
DROP INDEX IF EXISTS camdecmps.summary_value_idx001;
DROP INDEX IF EXISTS camdecmps.summary_value_idx002;
DROP INDEX IF EXISTS camdecmps.idx_summary_value_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_summary_value_parameter_cd;
DROP INDEX IF EXISTS camdecmps.idx_summary_value_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_summary_value_rpt_period_id_mon_loc_id;

ALTER TABLE IF EXISTS camdecmps.summary_value
    DROP CONSTRAINT IF EXISTS pk_summary_value,
    DROP CONSTRAINT IF EXISTS uq_summary_value,
    DROP CONSTRAINT IF EXISTS fk_summary_value_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_summary_value_parameter_code,
    DROP CONSTRAINT IF EXISTS fk_summary_value_reporting_period;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_rect_duct_waf_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_rect_duct_waf_waf_method;
DROP INDEX IF EXISTS camdecmps.idx_rect_duct_waf_waf_method_cd;
DROP INDEX IF EXISTS camdecmps."rect_duct_waf_idx$$_15f60009";

ALTER TABLE IF EXISTS camdecmps.rect_duct_waf
    DROP CONSTRAINT IF EXISTS pk_rect_duct_waf,
    DROP CONSTRAINT IF EXISTS fk_rect_duct_waf_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_rect_duct_waf_waf_method_code;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_operating_supp_data_emr;
DROP INDEX IF EXISTS camdecmps.idx_operating_supp_fuel_cd;
DROP INDEX IF EXISTS camdecmps.idx_operating_supp_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_operating_supp_op_type_cd;
DROP INDEX IF EXISTS camdecmps.operating_supp_data_idx001;
DROP INDEX IF EXISTS camdecmps.idx_operating_supp_data_fuel_cd;
DROP INDEX IF EXISTS camdecmps.idx_operating_supp_data_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_operating_supp_data_op_type_cd;
DROP INDEX IF EXISTS camdecmps.idx_operating_supp_data_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_operating_supp_data_rpt_period_id_mon_loc_id;

ALTER TABLE IF EXISTS camdecmps.operating_supp_data
    DROP CONSTRAINT IF EXISTS pk_operating_supp_data,
    DROP CONSTRAINT IF EXISTS fk_fuel_code_operating_sup,
	DROP CONSTRAINT IF EXISTS fk_operating_supp_data_fuel_code,
    DROP CONSTRAINT IF EXISTS fk_operating_supp_data_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_operating_typ_operating_sup,
	DROP CONSTRAINT IF EXISTS fk_operating_supp_data_operating_type_code,
    DROP CONSTRAINT IF EXISTS fk_reporting_per_operating_sup,
	DROP CONSTRAINT IF EXISTS fk_operating_supp_data_reporting_period;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_nsps4t_summary_loc;
DROP INDEX IF EXISTS camdecmps.idx_nsps4t_summary_lod;
DROP INDEX IF EXISTS camdecmps.idx_nsps4t_summary_prd;
DROP INDEX IF EXISTS camdecmps.idx_nsps4t_summary_rpt;
DROP INDEX IF EXISTS camdecmps.idx_nsps4t_summary_stn;
DROP INDEX IF EXISTS camdecmps.idx_nsps4t_summary_uom;
DROP INDEX IF EXISTS camdecmps.idx_nsps4t_summary_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_nsps4t_summary_electrical_load_cd;
DROP INDEX IF EXISTS camdecmps.idx_nsps4t_summary_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_nsps4t_summary_emission_standard_cd;
DROP INDEX IF EXISTS camdecmps.idx_nsps4t_summary_modus_uom_cd;
DROP INDEX IF EXISTS camdecmps.idx_nsps4t_summary_rpt_period_id_mon_loc_id;

ALTER TABLE IF EXISTS camdecmps.nsps4t_summary
    DROP CONSTRAINT IF EXISTS pk_nsps4t_summary,
    DROP CONSTRAINT IF EXISTS fk_nsps4t_summary_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_nsps4t_summary_nsps4t_electrical_load_code,
    DROP CONSTRAINT IF EXISTS fk_nsps4t_summary_nsps4t_emission_standard_code,
    DROP CONSTRAINT IF EXISTS fk_nsps4t_summary_reporting_period,
    DROP CONSTRAINT IF EXISTS fk_nsps4t_summary_units_of_measure_code;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_monitor_system_fuel_cd;
DROP INDEX IF EXISTS camdecmps.idx_monitor_system_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_monitor_system_sys_design;
DROP INDEX IF EXISTS camdecmps.idx_monitor_system_sys_type_c;
DROP INDEX IF EXISTS camdecmps.idx_monitor_system_uq;
DROP INDEX IF EXISTS camdecmps.idx_monitor_system_fuel_cd;
DROP INDEX IF EXISTS camdecmps.idx_monitor_system_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_monitor_system_system_identifier;
DROP INDEX IF EXISTS camdecmps.idx_monitor_system_sys_designation_cd;
DROP INDEX IF EXISTS camdecmps.idx_monitor_system_sys_type_cd;

ALTER TABLE IF EXISTS camdecmps.monitor_system
    DROP CONSTRAINT IF EXISTS pk_monitor_system,
    DROP CONSTRAINT IF EXISTS fk_monitor_system_fuel_code,
    DROP CONSTRAINT IF EXISTS fk_monitor_system_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_monitor_system_system_designation_code,
    DROP CONSTRAINT IF EXISTS fk_monitor_system_system_type_code;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_monitor_span_component;
DROP INDEX IF EXISTS camdecmps.idx_monitor_span_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_monitor_span_span_metho;
DROP INDEX IF EXISTS camdecmps.idx_monitor_span_span_scale;
DROP INDEX IF EXISTS camdecmps.idx_monitor_span_span_uom_c;
DROP INDEX IF EXISTS camdecmps.idx_monitor_span_component_type_cd;
DROP INDEX IF EXISTS camdecmps.idx_monitor_span_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_monitor_span_span_method_cd;
DROP INDEX IF EXISTS camdecmps.idx_monitor_span_span_scale_cd;
DROP INDEX IF EXISTS camdecmps.idx_monitor_span_span_uom_cd;

ALTER TABLE IF EXISTS camdecmps.monitor_span
    DROP CONSTRAINT IF EXISTS pk_monitor_span,
    DROP CONSTRAINT IF EXISTS fk_monitor_span_component_type_code,
    DROP CONSTRAINT IF EXISTS fk_monitor_span_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_monitor_span_span_method_code,
    DROP CONSTRAINT IF EXISTS fk_monitor_span_span_scale_code,
    DROP CONSTRAINT IF EXISTS fk_monitor_span_units_of_measure_code;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_monitor_qualification_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_monitor_qualification_qual_type_cd;

ALTER TABLE IF EXISTS camdecmps.monitor_qualification
    DROP CONSTRAINT IF EXISTS pk_monitor_qualification,
    DROP CONSTRAINT IF EXISTS fk_monitor_qualification_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_monitor_qualification_qual_type_code;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_mon_plan_loc_plan_loc;
DROP INDEX IF EXISTS camdecmps.idx_monitor_plan_location_mon_plan_id;
DROP INDEX IF EXISTS camdecmps.idx_monitor_plan_location_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_monitor_plan_location_mon_plan_id_mon_loc_id;

ALTER TABLE IF EXISTS camdecmps.monitor_plan_location
    DROP CONSTRAINT IF EXISTS pk_monitor_plan_location,
    DROP CONSTRAINT IF EXISTS uq_monitor_plan_location,
    DROP CONSTRAINT IF EXISTS fk_monitor_plan_location_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_monitor_plan_location_monitor_plan;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_mm_monlocid;
DROP INDEX IF EXISTS camdecmps.idx_mm_paramcd;
DROP INDEX IF EXISTS camdecmps.idx_monitor_method_bypass_app;
DROP INDEX IF EXISTS camdecmps.idx_monitor_method_method_cd;
DROP INDEX IF EXISTS camdecmps.idx_monitor_method_sub_data_c;
DROP INDEX IF EXISTS camdecmps."monitor_method_idx$$_15f60005";
DROP INDEX IF EXISTS camdecmps.idx_monitor_method_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_monitor_method_parameter_cd;
DROP INDEX IF EXISTS camdecmps.idx_monitor_method_bypass_approach_cd;
DROP INDEX IF EXISTS camdecmps.idx_monitor_method_method_cd;
DROP INDEX IF EXISTS camdecmps.idx_monitor_method_sub_data_cd;

ALTER TABLE IF EXISTS camdecmps.monitor_method
    DROP CONSTRAINT IF EXISTS pk_monitor_method,
    DROP CONSTRAINT IF EXISTS fk_monitor_method_bypass_approach_code,
    DROP CONSTRAINT IF EXISTS fk_monitor_method_method_code,
    DROP CONSTRAINT IF EXISTS fk_monitor_method_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_monitor_method_parameter_code,
    DROP CONSTRAINT IF EXISTS fk_monitor_method_substitute_data_code;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_monitor_locatio_material_c;
DROP INDEX IF EXISTS camdecmps.idx_monitor_locatio_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_monitor_locatio_shape_cd;
DROP INDEX IF EXISTS camdecmps."monitor_locatio_idx$$_15b0000b";
DROP INDEX IF EXISTS camdecmps.idx_monitor_location_material_cd;
DROP INDEX IF EXISTS camdecmps.idx_monitor_location_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_monitor_location_shape_cd;

ALTER TABLE IF EXISTS camdecmps.monitor_location_attribute
    DROP CONSTRAINT IF EXISTS pk_monitor_location_attribute,
    DROP CONSTRAINT IF EXISTS fk_monitor_location_attribute_material_code,
    DROP CONSTRAINT IF EXISTS fk_monitor_location_attribute_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_monitor_location_attribute_shape_code;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_monitor_load_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_monitor_load_max_load_uom_cd;

ALTER TABLE IF EXISTS camdecmps.monitor_load
    DROP CONSTRAINT IF EXISTS pk_monitor_load,
    DROP CONSTRAINT IF EXISTS fk_monitor_load_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_monitor_load_units_of_measure_code;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_monitor_formula_equation_c;
DROP INDEX IF EXISTS camdecmps.idx_monitor_formula_mon_loc_id;
DROP INDEX IF EXISTS camdecmps."monitor_formula_idx$$_15b00008";
DROP INDEX IF EXISTS camdecmps.monitor_formula_idx001;
DROP INDEX IF EXISTS camdecmps.idx_monitor_formula_equation_cd;
DROP INDEX IF EXISTS camdecmps.idx_monitor_formula_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_monitor_formula_formula_identifier;
DROP INDEX IF EXISTS camdecmps.idx_monitor_formula_parameter_cd;

ALTER TABLE IF EXISTS camdecmps.monitor_formula
    DROP CONSTRAINT IF EXISTS pk_monitor_formula,
    DROP CONSTRAINT IF EXISTS fk_monitor_formula_equation_code,
    DROP CONSTRAINT IF EXISTS fk_monitor_formula_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_monitor_formula_parameter_code;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_monitor_default_default_pu;
DROP INDEX IF EXISTS camdecmps.idx_monitor_default_default_so;
DROP INDEX IF EXISTS camdecmps.idx_monitor_default_default_uo;
DROP INDEX IF EXISTS camdecmps.idx_monitor_default_fuel_cd;
DROP INDEX IF EXISTS camdecmps.idx_monitor_default_loc_prp;
DROP INDEX IF EXISTS camdecmps.idx_monitor_default_operating;
DROP INDEX IF EXISTS camdecmps."monitor_default_idx$$_15b00006";
DROP INDEX IF EXISTS camdecmps.monitor_default_idx001;
DROP INDEX IF EXISTS camdecmps.idx_monitor_default_default_purpose_cd;
DROP INDEX IF EXISTS camdecmps.idx_monitor_default_default_source_cd;
DROP INDEX IF EXISTS camdecmps.idx_monitor_default_default_uom_cd;
DROP INDEX IF EXISTS camdecmps.idx_monitor_default_fuel_cd;
DROP INDEX IF EXISTS camdecmps.idx_monitor_default_operating_condition_cd;
DROP INDEX IF EXISTS camdecmps.idx_monitor_default_parameter_cd;
DROP INDEX IF EXISTS camdecmps.idx_monitor_default_mon_loc_id;

ALTER TABLE IF EXISTS camdecmps.monitor_default
    DROP CONSTRAINT IF EXISTS pk_monitor_default,
    DROP CONSTRAINT IF EXISTS fk_monitor_default_default_purpose_code,
    DROP CONSTRAINT IF EXISTS fk_monitor_default_default_source_code,
    DROP CONSTRAINT IF EXISTS fk_monitor_default_fuel_code,
    DROP CONSTRAINT IF EXISTS fk_monitor_default_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_monitor_default_operating_condition_code,
    DROP CONSTRAINT IF EXISTS fk_monitor_default_parameter_code,
    DROP CONSTRAINT IF EXISTS fk_monitor_default_units_of_measure_code;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.mats_method_data_method_cd;
DROP INDEX IF EXISTS camdecmps.mats_method_data_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.mats_method_data_param_cd;
DROP INDEX IF EXISTS camdecmps.idx_mats_method_data_mats_method_cd;
DROP INDEX IF EXISTS camdecmps.idx_mats_method_data_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_mats_method_data_mats_method_parameter_cd;

ALTER TABLE IF EXISTS camdecmps.mats_method_data
    DROP CONSTRAINT IF EXISTS pk_mats_method_data,
    DROP CONSTRAINT IF EXISTS fk_mats_method_data_mats_method_code,
    DROP CONSTRAINT IF EXISTS fk_mats_method_data_mats_method_parameter_code,
    DROP CONSTRAINT IF EXISTS fk_mats_method_data_monitor_location;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_hod_add_date;
DROP INDEX IF EXISTS camdecmps.idx_hrly_op_data_1;
DROP INDEX IF EXISTS camdecmps.idx_hrly_op_data_2;
DROP INDEX IF EXISTS camdecmps.idx_hrly_op_data_emr;
DROP INDEX IF EXISTS camdecmps.idx_hrly_op_data_fuel_cd;
DROP INDEX IF EXISTS camdecmps.idx_hrly_op_data_operating_;
DROP INDEX IF EXISTS camdecmps.idx_hrly_op_data_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_hrly_op_data_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_hrly_op_data_fuel_cd;
DROP INDEX IF EXISTS camdecmps.idx_hrly_op_data_load_uom_cd;
DROP INDEX IF EXISTS camdecmps.idx_hrly_op_data_operating_condition_cd;
DROP INDEX IF EXISTS camdecmps.idx_hrly_op_data_rpt_period_id_mon_loc_id;

ALTER TABLE IF EXISTS camdecmps.hrly_op_data
    DROP CONSTRAINT IF EXISTS pk_hrly_op_data,
    DROP CONSTRAINT IF EXISTS fk_hrly_op_data_fuel_code,
    DROP CONSTRAINT IF EXISTS fk_hrly_op_data_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_hrly_op_data_operating_condition_code,
    DROP CONSTRAINT IF EXISTS fk_hrly_op_data_reporting_period,
    DROP CONSTRAINT IF EXISTS fk_hrly_op_data_units_of_measure_code;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS idx_dm_emissions_dm_emissions_id;
DROP INDEX IF EXISTS idx_dm_emissions_dm_emissions_user_cd;

ALTER TABLE IF EXISTS camdecmps.dm_emissions_user
    DROP CONSTRAINT IF EXISTS dm_emissions_user_pk,
    DROP CONSTRAINT IF EXISTS dm_emissions_user_em__cd_uq,
    DROP CONSTRAINT IF EXISTS dm_emissions_user_cd_fk,
	DROP CONSTRAINT IF EXISTS pk_dm_emissions_user,
    DROP CONSTRAINT IF EXISTS uq_dm_emissions_user,
    DROP CONSTRAINT IF EXISTS fk_dm_emissions_user_dm_emissions,
	DROP CONSTRAINT IF EXISTS fk_dm_emissions_user_dm_emissions_user_code;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_de_add_date;
DROP INDEX IF EXISTS camdecmps.daily_emission_idx001;
DROP INDEX IF EXISTS camdecmps.daily_emission_idx003;
DROP INDEX IF EXISTS camdecmps.idx_daily_emission_parameter_cd;
DROP INDEX IF EXISTS camdecmps.idx_daily_emission_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_daily_emission_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_daily_emission_rpt_period_id_mon_loc_id;

ALTER TABLE IF EXISTS camdecmps.daily_emission
    DROP CONSTRAINT IF EXISTS pk_daily_emission,
    DROP CONSTRAINT IF EXISTS fk_daily_emission_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_daily_emission_parameter_code,
    DROP CONSTRAINT IF EXISTS fk_daily_emission_reporting_period;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS idx_daily_backstop_unit_id;
DROP INDEX IF EXISTS idx_daily_backstop_mon_loc_id;
DROP INDEX IF EXISTS idx_daily_backstop_rpt_period_id;
DROP INDEX IF EXISTS idx_daily_backstop_rpt_period_id_mon_loc_id;

ALTER TABLE IF EXISTS camdecmps.daily_backstop
    DROP CONSTRAINT IF EXISTS pk_daily_backstop,
    DROP CONSTRAINT IF EXISTS fk_daily_backstop_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_daily_backstop_reporting_period,
    DROP CONSTRAINT IF EXISTS fk_daily_backstop_unit;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_component_mon_loc_id;
DROP INDEX IF EXISTS camdecmps."component_idx$$_15b00009";
DROP INDEX IF EXISTS camdecmps.idx_component_acq_cd;
DROP INDEX IF EXISTS camdecmps.idx_component_analytical_principle_code;
DROP INDEX IF EXISTS camdecmps.idx_component_basis_cd;
DROP INDEX IF EXISTS camdecmps.idx_component_component;
DROP INDEX IF EXISTS camdecmps.idx_component_monlocid;
DROP INDEX IF EXISTS camdecmps.idx_component_component_identifier;

ALTER TABLE IF EXISTS camdecmps.component
    DROP CONSTRAINT IF EXISTS pk_component,
    DROP CONSTRAINT IF EXISTS fk_component_acquisition_method_code,
    DROP CONSTRAINT IF EXISTS fk_component_analytical_principle_code,
    DROP CONSTRAINT IF EXISTS fk_component_basis_code,
    DROP CONSTRAINT IF EXISTS fk_component_component_type_code,
	DROP CONSTRAINT IF EXISTS fk_component_monitor_location;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_unit_stack_configuration_b;
DROP INDEX IF EXISTS camdecmps.idx_unit_stack_configuration_s;
DROP INDEX IF EXISTS camdecmps.idx_unit_stack_configuration_u;
DROP INDEX IF EXISTS camdecmps.idx_unit_stack_configuration_stack_pipe_id;
DROP INDEX IF EXISTS camdecmps.idx_unit_stack_configuration_unit_id;
DROP INDEX IF EXISTS camdecmps.idx_unit_stack_configuration_stack_pipe_id_unit_id;

ALTER TABLE IF EXISTS camdecmps.unit_stack_configuration
    DROP CONSTRAINT IF EXISTS pk_unit_stack_configuration,
    DROP CONSTRAINT IF EXISTS fk_unit_stack_configuration_stack_pipe,
    DROP CONSTRAINT IF EXISTS fk_unit_stack_configuration_unit;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_monitor_plan_re_begin_rpt_;
DROP INDEX IF EXISTS camdecmps.idx_monitor_plan_re_end_rpt_pe;
DROP INDEX IF EXISTS camdecmps.idx_monitor_plan_re_mon_plan_i;
DROP INDEX IF EXISTS camdecmps.idx_monitor_plan_re_report_fre;
DROP INDEX IF EXISTS camdecmps.idx_monitor_plan_reporting_freq_begin_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_monitor_plan_reporting_freq_end_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_monitor_plan_reporting_freq_mon_plan_id;
DROP INDEX IF EXISTS camdecmps.idx_monitor_plan_reporting_freq_report_freq_cd;

ALTER TABLE IF EXISTS camdecmps.monitor_plan_reporting_freq
    DROP CONSTRAINT IF EXISTS pk_monitor_plan_reporting_freq,
    DROP CONSTRAINT IF EXISTS fk_monitor_plan_reporting_freq_begin_rpt_period,
    DROP CONSTRAINT IF EXISTS fk_monitor_plan_reporting_freq_end_rpt_period,
    DROP CONSTRAINT IF EXISTS fk_monitor_plan_reporting_freq_monitor_plan,
    DROP CONSTRAINT IF EXISTS fk_monitor_plan_reporting_freq_report_freq_code;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_monitor_plan_comment_mon_plan_id;
DROP INDEX IF EXISTS camdecmps.idx_monitor_plan_comment_submission_availability_cd;

ALTER TABLE IF EXISTS camdecmps.monitor_plan_comment
    DROP CONSTRAINT IF EXISTS pk_monitor_plan_comment,
    DROP CONSTRAINT IF EXISTS fk_monitor_plan_comment_monitor_plan,
    DROP CONSTRAINT IF EXISTS fk_monitor_plan_comment_submission_availability_code;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_monitor_location_id;
DROP INDEX IF EXISTS camdecmps.idx_monitor_location_stp;
DROP INDEX IF EXISTS camdecmps.idx_monitor_location_unt;
DROP INDEX IF EXISTS camdecmps.idx_monitor_location_mon_loc_id;
DROP INDEX IF EXISTS camdecmps.idx_monitor_location_stack_pipe_id;
DROP INDEX IF EXISTS camdecmps.idx_monitor_location_unit_id;

ALTER TABLE IF EXISTS camdecmps.monitor_location
    DROP CONSTRAINT IF EXISTS pk_monitor_location,
    DROP CONSTRAINT IF EXISTS fk_monitor_location_stack_pipe,
    DROP CONSTRAINT IF EXISTS fk_monitor_location_unit;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.emission_evaluation_idx001;
DROP INDEX IF EXISTS camdecmps.idx_emission_evalua1;
DROP INDEX IF EXISTS camdecmps.idx_emission_evalua_chk_sessio;
DROP INDEX IF EXISTS camdecmps.idx_emission_evalua_submission;
DROP INDEX IF EXISTS camdecmps.idx_emission_evaluation_mon_plan_id;
DROP INDEX IF EXISTS camdecmps.idx_emission_evaluation_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_emission_evaluation_submission_id;
DROP INDEX IF EXISTS camdecmps.idx_emission_evaluation_chk_session_id;
DROP INDEX IF EXISTS camdecmps.idx_emission_evaluation_submission_availability_cd;
DROP INDEX IF EXISTS camdecmps.idx_emission_evaluation_rpt_period_id_mon_plan_id;

ALTER TABLE camdecmps.emission_evaluation
    DROP CONSTRAINT IF EXISTS pk_emission_evaluation,
    DROP CONSTRAINT IF EXISTS uq_emission_evaluation,
    DROP CONSTRAINT IF EXISTS fk_emission_evaluation_monitor_plan,
    DROP CONSTRAINT IF EXISTS fk_emission_evaluation_reporting_period,
    DROP CONSTRAINT IF EXISTS fk_emission_evaluation_submission_availability_code;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_dm_emissions_mon_plan_id;
DROP INDEX IF EXISTS camdecmps.idx_dm_emissions_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_dm_emissions_apportionment_type_cd;
DROP INDEX IF EXISTS camdecmps.idx_dm_emissions_fac_id;

ALTER TABLE IF EXISTS camdecmps.dm_emissions
    DROP CONSTRAINT IF EXISTS dm_emissions_pk CASCADE,
    DROP CONSTRAINT IF EXISTS dm_emissions_uq,
    DROP CONSTRAINT IF EXISTS dm_emissions_apptype_fk,
    DROP CONSTRAINT IF EXISTS pk_dm_emissions,
    DROP CONSTRAINT IF EXISTS uq_dm_emissions,
    DROP CONSTRAINT IF EXISTS fk_dm_emissions_plant,
    DROP CONSTRAINT IF EXISTS fk_dm_emissions_monitor_plan,
    DROP CONSTRAINT IF EXISTS fk_dm_emissions_reporting_period,
    DROP CONSTRAINT IF EXISTS fk_dm_emissions_apportionment_type_code;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_unit_fuel_unit_id;
DROP INDEX IF EXISTS camdecmps.idx_unit_fuel_fuel_type;
DROP INDEX IF EXISTS camdecmps.idx_unit_fuel_indicator_cd;
DROP INDEX IF EXISTS camdecmps.idx_unit_fuel_dem_so2;
DROP INDEX IF EXISTS camdecmps.idx_unit_fuel_dem_gcv;

ALTER TABLE IF EXISTS camdecmps.unit_fuel
    DROP CONSTRAINT IF EXISTS pk_unit_fuel,
    DROP CONSTRAINT IF EXISTS uq_unit_fuel,
    DROP CONSTRAINT IF EXISTS fk_unit_fuel_dem_method_code_gcv,
    DROP CONSTRAINT IF EXISTS fk_unit_fuel_dem_method_code_so2,
    DROP CONSTRAINT IF EXISTS fk_unit_fuel_fuel_indicator_code,
    DROP CONSTRAINT IF EXISTS fk_unit_fuel_fuel_type_code,
    DROP CONSTRAINT IF EXISTS fk_unit_fuel_unit,
    DROP CONSTRAINT IF EXISTS ck_unit_fuel_act_or_proj_cd;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_unit_control_unit;
DROP INDEX IF EXISTS camdecmps.idx_unit_control_unit_id;
DROP INDEX IF EXISTS camdecmps.idx_unit_control_control_cd;
DROP INDEX IF EXISTS camdecmps.idx_unit_control_ce_param;
DROP INDEX IF EXISTS camdecmps.idx_unit_control_indicator_cd;

ALTER TABLE IF EXISTS camdecmps.unit_control
    DROP CONSTRAINT IF EXISTS pk_unit_control,
    DROP CONSTRAINT IF EXISTS fk_unit_control_control_code,
	DROP CONSTRAINT IF EXISTS fk_unit_control_control_equip_param_code,
    DROP CONSTRAINT IF EXISTS fk_unit_control_fuel_indicator_code,
    DROP CONSTRAINT IF EXISTS fk_unit_control_unit;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_unit_capacity_unit;

ALTER TABLE IF EXISTS camdecmps.unit_capacity
    DROP CONSTRAINT IF EXISTS pk_unit_capacity,
    DROP CONSTRAINT IF EXISTS fk_unit_capacity_unit;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_stack_pipe_fac;
DROP INDEX IF EXISTS camdecmps.idx_stack_pipe_fac_name;
DROP INDEX IF EXISTS camdecmps.idx_stack_pipe_fac_id;
DROP INDEX IF EXISTS camdecmps.idx_stack_pipe_stack_name;

ALTER TABLE IF EXISTS camdecmps.stack_pipe
    DROP CONSTRAINT IF EXISTS pk_stack_pipe,
    DROP CONSTRAINT IF EXISTS fk_stack_pipe_plant;
----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE IF EXISTS camdecmps.protocol_gas_vendor
    DROP CONSTRAINT IF EXISTS pk_protocol_gas_vendor;
----------------------------------------------------------------------------------------------------------------------------------
DROP INDEX IF EXISTS camdecmps.idx_monitor_plan_fac_id;
DROP INDEX IF EXISTS camdecmps.idx_monitor_plan_chk_session;
DROP INDEX IF EXISTS camdecmps.idx_monitor_plan_chk_session_id;
DROP INDEX IF EXISTS camdecmps.idx_monitor_plan_submission;
DROP INDEX IF EXISTS camdecmps.idx_monitor_plan_submission_id;
DROP INDEX IF EXISTS camdecmps.idx_monitor_plan_submission_availability_cd;
DROP INDEX IF EXISTS camdecmps.idx_monitor_plan_begin_rpt_period_id;
DROP INDEX IF EXISTS camdecmps.idx_monitor_plan_end_rpt_period_id;

ALTER TABLE IF EXISTS camdecmps.monitor_plan
    DROP CONSTRAINT IF EXISTS pk_monitor_plan,
    DROP CONSTRAINT IF EXISTS fk_monitor_plan_plant,
    DROP CONSTRAINT IF EXISTS fk_monitor_plan_reporting_period_begin_rpt_period,
    DROP CONSTRAINT IF EXISTS fk_monitor_plan_reporting_period_end_rpt_period,
    DROP CONSTRAINT IF EXISTS fk_monitor_plan_submission_availability_code;
----------------------------------------------------------------------------------------------------------------------------------
