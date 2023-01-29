DO $$
DECLARE
	datasetCode text := 'CO2APPD';
	groupCode text := 'EMVIEW';
	datatableId integer;
BEGIN
	DELETE FROM camdaux.dataset WHERE group_cd = groupCode;

	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name, sort_order, no_results_msg)
	VALUES(datasetCode, groupCode, 'Hourly CO2 Appendix D View', 10, 'Hourly CO2 Appendix D data does not exist for the specified monitor plan and reporting period.');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'Hourly CO2 Appendix D', null, null)
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
		(datatableId, 11, 'formula_cd', 'formulaCode', 'Formula Code'),
		(datatableId, 13, 'fc_factor', 'fcFactor', 'Fc Factor'),
		(datatableId, 14, 'rpt_co2_mass_rate', 'rptCO2MassRate', 'Rpt. CO2 Mass Rate (ton/hr)'),
		(datatableId, 15, 'calc_co2_mass_rate', 'calcCO2MassRate', 'Calc. CO2 Mass Rate (ton/hr)'),
		(datatableId, 17, 'summation_formula_cd', 'summationFormulaCode', 'Summation Formula Code'),
		(datatableId, 18, 'rpt_co2_mass_rate_all_fuels', 'rptCO2MassRateALLFuels', 'Rpt. CO2 Mass Rate for all Fuels (ton/hr)'),
		(datatableId, 19, 'calc_co2_mass_rate_all_fuels', 'calcCO2MassRateALLFuels', 'Calc. CO2 Mass Rate for all Fuels (ton/hr)'),
		(datatableId, 20, 'error_codes', 'errorCodes', 'Hourly Errors');
END $$;