DO $$
DECLARE
	datasetCode text := 'NOXAPPESINGLEFUEL';
	groupCode text := 'EMVIEW';
	datatableId integer;
BEGIN
	DELETE FROM camdaux.dataset WHERE group_cd = groupCode;
	
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name, sort_order, no_results_msg)
	VALUES(datasetCode, groupCode, 'NOX Appendix E Individual Fuel Curve View', 11, 'NOX Appendix E Individual Fuel Curve data does not exist for the specified monitor plan and reporting period.');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'NOX Appendix E Individual Fuel Curve', null, null)
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
		(datatableId, 8, 'calc_hi_rate', 'calcHIRate', 'Calc. HI Rate (mmBtu/hr)'),
		(datatableId, 9, 'operating_condition_cd', 'operatingConditionCode', 'Operating Condition'),
		(datatableId, 10, 'segment_number', 'segmentNumber', 'Segment Number'),
		(datatableId, 11, 'app_e_sys_id', 'appESystemIdentifier', 'NOXE System ID'),
		(datatableId, 12, 'rpt_nox_emission_rate', 'rptNOXEmissionRate', 'Rpt. NOx Emission Rate (lb/mmBtu)'),
		(datatableId, 13, 'calc_nox_emission_rate', 'calcNOXEmissionRate', 'Calc. NOx Emission Rate (lb/mmBtu)'),
		(datatableId, 15, 'summation_formula_cd', 'summationFormulaCode', 'Summation Formula Code'),
		(datatableId, 16, 'rpt_nox_emission_rate_all_fuels', 'rptNOXEmissionRateALLFuels', 'Rpt. NOx Emission Rate for all Fuels (lb/mmBtu)'),
		(datatableId, 17, 'calc_nox_emission_rate_all_fuels', 'calcNOXEmissionRateALLFuels', 'Calc. NOx Emission Rate for all Fuels (lb/mmBtu)'),
		(datatableId, 18, 'calc_hi_rate_all_fuels', 'calcHIRateALLFuels', 'Calc. HI Rate for all Fuels (mmBtu/hr)'),
		(datatableId, 19, 'nox_mass_rate_formula_cd', 'noxMassRateFormulaCode', 'NOx Mass Rate Formula Code'),
		(datatableId, 20, 'rpt_nox_mass_all_fuels', 'rptNOXMassALLFuels', 'Rpt. NOx Mass Rate for all Fuels (lb/hr)'),
		(datatableId, 21, 'calc_nox_mass_all_fuels', 'calcNOXMassALLFuels', 'Calc. NOx Mass Rate for all Fuels (lb/hr)'),
		(datatableId, 22, 'error_codes', 'errorCodes', 'Hourly Errors');
END $$;