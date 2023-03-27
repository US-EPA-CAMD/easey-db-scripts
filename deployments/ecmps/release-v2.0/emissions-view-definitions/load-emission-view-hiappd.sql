DO $$
DECLARE
	datasetCode text := 'HIAPPD';
	groupCode text := 'EMVIEW';
	datatableId integer;
BEGIN
	DELETE FROM camdaux.dataset WHERE dataset_cd = datasetCode;
	
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name, sort_order, no_results_msg)
	VALUES(datasetCode, groupCode, 'Hourly Heat Input Appendix D View', 8, 'Hourly Heat Input Appendix D data does not exist for the specified monitor plan and reporting period.');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'Hourly Heat Input Appendix D', null, null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'date_hour', 'dateHour', 'Date/Hr'),
		(datatableId, 3, 'fuel_sys_id', 'fuelSystemIdentifier', 'Fuel System ID'),
		(datatableId, 4, 'fuel_type', 'fuelType', 'Fuel Type'),
		(datatableId, 5, 'fuel_use_time', 'fuelUseTime', 'Fuel Use Time'),
		(datatableId, 6, 'unit_load', 'unitLoad', 'Load'),
		(datatableId, 7, 'load_uom', 'loadUOM', 'Load UOM'),
		(datatableId, 8, 'rpt_fuel_flow', 'rptFuelFlow', 'Rpt. Fuel Flow'),
		(datatableId, 9, 'calc_fuel_flow', 'calcFuelFlow', 'Fuel Flow Used in Calc.'),
		(datatableId, 10, 'fuel_flow_uom', 'fuelFlowUOM', 'Fuel Flow Units of Measure'),
		(datatableId, 11, 'fuel_flow_sodc', 'fuelFlowSodc', 'Fuel Flow SODC'),
		(datatableId, 12, 'gross_calorific_value', 'grossCalorificValue', 'GCV'),
		(datatableId, 13, 'gcv_uom', 'gcvUOM', 'GCV Units of Measure '),
		(datatableId, 14, 'gcv_sampling_type', 'gcvSamplingType', 'GCV Sampling Type'),
		(datatableId, 15, 'formula_cd', 'formulaCode', 'Formula Code'),
		(datatableId, 16, 'rpt_hi_rate', 'rptHIRate', 'Rpt. HI Rate (mmBtu/hr)'),
		(datatableId, 17, 'calc_hi_rate', 'calcHIRate', 'Calc. HI Rate (mmBtu/hr)'),
		(datatableId, 18, 'error_codes', 'errorCodes', 'Hourly Errors');
END $$;