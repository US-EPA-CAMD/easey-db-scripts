DO $$
DECLARE
	datasetCode text = 'DAILYCAL';
	datatableId integer;
BEGIN
	INSERT INTO camdaux.dataset(dataset_cd, template_cd, display_name, no_results_msg)
	VALUES(datasetCode, 'Emissions View', 'Daily Calibration View', 'Daily Calibration data does not exist for the specified monitor plan and reporting period.');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'Daily Calibration', null, null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'component_identifier', 'componentIdentifier', 'Component Id'),
		(datatableId, 2, 'component_type_cd', 'componentTypeCode', 'Component Type'),
		(datatableId, 3, 'span_scale_cd', 'spanScaleCode', 'Span Scale'),
		--(datatableId, 4, 'datehour', 'datehour', 'End Date/Time'),
		--end_date
		--end_time
		(datatableId, 5, 'rpt_test_result_cd', 'rptTestResultCode', 'Rpt. Test Result'),
		(datatableId, 6, 'calc_test_result_cd', 'calcTestResultCode', 'Calc. Test Result'),
		--applicable_span_value
		(datatableId, 8, 'upscale_gas_level_cd', 'upscaleGasLevelCode', 'Upscale Gas Level'),
		(datatableId, 9, 'upscale_injection_date', 'upscaleInjectionDate', 'Upscale Injection Date'),
		(datatableId, 10, 'upscale_injection_time', 'upscaleInjectionTime', 'Upscale Injection Time'),
		(datatableId, 11, 'upscale_measured_value', 'upscaleMeasuredValue', 'Upscale Measured Value'),
		(datatableId, 12, 'upscale_ref_value', 'upscaleReferenceValue', 'Upscale Reference Value'),
		(datatableId, 14, 'rpt_upscale_ce_or_mean_diff', 'rptUpscaleCEorMeanDifference', 'Rpt. Upscale CE or Mean Diff.'),
		(datatableId, 15, 'rpt_upscale_aps_ind', 'rptUpscaleApsIndicator', 'Rpt. Upscale APS Ind.'),
		(datatableId, 16, 'calc_upscale_ce_or_mean_diff', 'calcUpscaleCEorMeanDifference', 'Calc. Upscale CE or Mean Diff.'),
		(datatableId, 17, 'calc_upscale_aps_ind', 'calcUpscaleApsIndicator', 'Calc. Upscale APS Ind.'),
		(datatableId, 18, 'zero_injection_date', 'zeroInjectionDate', 'Zero Injection Date'),
		(datatableId, 19, 'zero_injection_time', 'zeroInjectionTime', 'Zero Injection Time'),
		(datatableId, 20, 'zero_measured_value', 'zeroMeasuredValue', 'Zero Measured Value'),
		(datatableId, 21, 'zero_ref_value', 'zeroReferenceValue', 'Zero Reference Value'),
		(datatableId, 22, 'rpt_zero_ce_or_mean_diff', 'rptZeroCEorMeanDifference', 'Rpt. Zero CE or Mean Diff.'),
		(datatableId, 23, 'rpt_zero_aps_ind', 'rptZeroApsIndicator', 'Rpt. Zero APS Ind.'),
		(datatableId, 24, 'calc_zero_ce_or_mean_diff', 'calcZeroCEorMeanDifference', 'Calc. Zero CE or Mean Diff.'),
		(datatableId, 25, 'calc_zero_aps_ind', 'calcZeroApsIndicator', 'Calc. Zero APS Ind.'),
		(datatableId, 26, 'rpt_online_offline_ind', 'rptOnlineOfflineIndicator', 'Rpt. Online Offline Ind.'),
		(datatableId, 27, 'calc_online_offline_ind', 'calcOnlineOfflineIndicator', 'Calc. Online Offline Ind.'),
		(datatableId, 28, 'upscale_gas_type_cd', 'upscaleGasTypeCode', 'Upscale Gas Type'),
		(datatableId, 29, 'vendor_id', 'vendorIdentifier', 'Vendor Id'),
		(datatableId, 30, 'cylinder_id', 'cylinderIdentifier', 'Cylinder Id'),
		(datatableId, 31, 'expiration_date', 'expirationDate', 'Expiration Date'),
		(datatableId, 32, 'error_codes', 'errorCodes', 'Test Errors');
END $$;