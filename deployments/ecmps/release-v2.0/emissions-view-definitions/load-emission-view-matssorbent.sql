DO $$
DECLARE
	datasetCode text = 'MATSSORBENT';
	datatableId integer;
BEGIN
	INSERT INTO camdaux.dataset(dataset_cd, template_cd, display_name, sort_order, no_results_msg)
	VALUES(datasetCode, 'EMVIEW', 'MATS Sorbent View', 20, 'MATS Sorbent data does not exist for the specified monitor plan and reporting period.');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'MATS Sorbent', null, null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'system_identifier', 'systemIdentifier', 'System ID'),
		(datatableId, 2, 'date_hour', 'dateHour', 'Begin Date'),
		(datatableId, 3, 'end_date_time', 'endDateTime', 'End Date'),
		(datatableId, 4, 'paired_trap_agreement', 'pairedTrapAgreement', 'Paired Trap Agreement'),
		(datatableId, 5, 'absolute_difference_ind', 'absoluteDifferenceIndicator', 'Absolute Difference Ind'),
		(datatableId, 6, 'modc_cd', 'modcCode', 'MODC Code'),
		(datatableId, 7, 'hg_concentration', 'hgConcentration', 'Hg Conc'),
		(datatableId, 8, 'rata_ind', 'rataIndicator', 'RATA Ind'),
		(datatableId, 9, 'sorbent_trap_aps_cd', 'sorbentTrapAPSCode', 'APS Code'),
		(datatableId, 10, 'a_component_id', 'aComponentIdentifier', 'A Component'),
		(datatableId, 11, 'a_sorbent_trap_serial_number', 'aSorbentTrapSerialNumber', 'A Serial Number'),
		(datatableId, 12, 'a_main_trap_hg', 'aMainTrapHG', 'A Main Trap Hg'),
		(datatableId, 13, 'a_breakthrough_trap_hg', 'aBreakthroughTrapHG', 'A Breakthrough Trap Hg'),
		(datatableId, 14, 'a_spike_trap_hg', 'aSpikeTrapHG', 'A Spike Trap Hg'),
		(datatableId, 15, 'a_spike_ref_value', 'aSpikeReferenceValue', 'A Spike Trap Ref Value'),
		(datatableId, 16, 'a_total_sample_volume', 'aTotalSampleVolume', 'A Total Sample Volume'),
		(datatableId, 17, 'a_ref_flow_to_sampling_ratio', 'aReferenceFlowToSamplingRatio', 'A Ref SFSR Ratio'),
		(datatableId, 18, 'a_hg_concentration', 'aHGConcentration', 'A Hg Conc'),
		(datatableId, 19, 'a_percent_breakthrough', 'aPercentBreakthrough', 'A Pct Breakthrough'),
		(datatableId, 20, 'a_percent_spike_recovery', 'aPercentSpikeRecovery', 'A Pct Spike Recovery'),
		(datatableId, 21, 'a_sampling_ratio_test_result_cd', 'aSamplingRatioTestResultCode', 'A Sample Ratio Test Result'),
		(datatableId, 22, 'a_post_leak_test_result_cd', 'aPostLeakTestResultCode', 'A Post Leak Result'),
		(datatableId, 23, 'a_train_qa_status_cd', 'aTrainQAStatusCode', 'A Train Qa Status'),
		(datatableId, 24, 'a_sample_damage_explanation', 'aSampleDamageExplanation', 'A Sample Damage Explanation'),
		(datatableId, 25, 'b_component_id', 'bComponentIdentifier', 'B Component'),
		(datatableId, 26, 'b_sorbent_trap_serial_number', 'bSorbentTrapSerialNumber', 'B Serial Number'),
		(datatableId, 27, 'b_main_trap_hg', 'bMainTrapHG', 'B Main Trap Hg'),
		(datatableId, 28, 'b_breakthrough_trap_hg', 'bBreakthroughTrapHG', 'B Breakthrough Trap Hg'),
		(datatableId, 29, 'b_spike_trap_hg', 'bSpikeTrapHG', 'B Spike Trap Hg'),
		(datatableId, 30, 'b_spike_ref_value', 'bSpikeReferenceValue', 'B Spike Trap Ref Value'),
		(datatableId, 31, 'b_total_sample_volume', 'bTotalSampleVolume', 'B Total Sample Volume'),
		(datatableId, 32, 'b_ref_flow_to_sampling_ratio', 'bReferenceFlowTOSamplingRatio', 'B Ref SFSR Ratio'),
		(datatableId, 33, 'b_hg_concentration', 'bHGConcentration', 'B Hg Conc'),
		(datatableId, 34, 'b_percent_breakthrough', 'bPercentBreakthrough', 'B Pct Breakthrough'),
		(datatableId, 35, 'b_percent_spike_recovery', 'bPercentSpikeRecovery', 'B Pct Spike Recovery'),
		(datatableId, 36, 'b_sampling_ratio_test_result_cd', 'bSamplingRatioTestResultCode', 'B Sample Ratio Test Result'),
		(datatableId, 37, 'b_post_leak_test_result_cd', 'bPostLeakTestResultCode', 'B Post Leak Result'),
		(datatableId, 38, 'b_train_qa_status_cd', 'bTrainQAStatusCode', 'B Train Qa Status'),
		(datatableId, 39, 'b_sample_damage_explanation', 'bSampleDamageExplanation', 'B Sample Damage Explanation'),
		(datatableId, 40, 'error_codes', 'errorCodes', 'Hourly Errors');
END $$;