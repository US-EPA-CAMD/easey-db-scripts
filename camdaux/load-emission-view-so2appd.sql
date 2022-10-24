DO $$
DECLARE
	datasetCode text = 'SO2APPD';
	datatableId integer;
BEGIN
	INSERT INTO camdaux.dataset(dataset_cd, template_cd, display_name, sort_order, no_results_msg)
	VALUES(datasetCode, 'EMVIEW', 'Hourly SO2 Appendix D View', 9, 'Hourly SO2 Appendix D data does not exist for the specified monitor plan and reporting period.');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'Hourly SO2 Appendix D', null, null)
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
		(datatableId, 8, 'calc_fuel_flow', 'calcFuelFlow', 'Fuel Flow Used in Calc.'),
		(datatableId, 9, 'fuel_flow_uom', 'fuelFlowUOM', 'Fuel Flow Units of Measure'),
		(datatableId, 10, 'fuel_flow_sodc', 'fuelFlowSodc', 'Fuel Flow SODC'),
		(datatableId, 11, 'sulfur_content', 'sulfurContent', 'Sulfur Content'),
		(datatableId, 12, 'sulfur_uom', 'sulfurUOM', 'Sulfur Units of Measure'),
		(datatableId, 13, 'sulfur_sampling_type', 'sulfurSamplingType', 'Sulfur Sampling Type'),
		(datatableId, 14, 'default_so2_emission_rate', 'defaultSO2EmissionRate', 'Default SO2 Emission Rate (lb/mmBtu)'),
		(datatableId, 15, 'calc_hi_rate', 'calcHIRate', 'Calc. HI Rate (mmBtu/hr)'),
		(datatableId, 16, 'formula_cd', 'formulaCode', 'Formula Code'),
		(datatableId, 17, 'rpt_so2_mass_rate', 'rptSO2MassRate', 'Rpt. SO2 Mass Rate (lb/hr)'),
		(datatableId, 18, 'calc_so2_mass_rate', 'calcSO2MassRate', 'Calc. SO2 Mass Rate (lb/hr)'),
		(datatableId, 20, 'summation_formula_cd', 'summationFormulaCode', 'Summation Formula Code'),
		(datatableId, 21, 'rpt_so2_mass_rate_all_fuels', 'rptSO2MassRateALLFuels', 'Rpt. SO2 Mass Rate for all Fuels (lb/hr)'),
		(datatableId, 22, 'calc_so2_mass_rate_all_fuels', 'calcSO2MassRateALLFuels', 'Calc. SO2 Mass Rate for all Fuels (lb/hr)'),
		(datatableId, 23, 'error_codes', 'errorCodes', 'Hourly Errors');
END $$;