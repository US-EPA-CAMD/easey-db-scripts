DO $$
DECLARE
	datasetCode text := 'NOXAPPEMIXEDFUEL';
	groupCode text := 'EMVIEW';
	datatableId integer;
BEGIN
	DELETE FROM camdaux.dataset WHERE group_cd = groupCode;
	
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name, sort_order, no_results_msg)
	VALUES(datasetCode, groupCode, 'Unit Level Fuel Curve View', 12, 'Unit Level Fuel Curve data does not exist for the specified monitor plan and reporting period.');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'Unit Level Fuel Curve', null, null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'date_hour', 'dateHour', 'Date/Hr'),
		(datatableId, 3, 'system_id', 'systemIdentifier', 'System ID'),
		(datatableId, 4, 'unit_load', 'unitLoad', 'Load'),
		(datatableId, 5, 'load_uom', 'loadUOM', 'Load UOM'),
		(datatableId, 6, 'calc_hi_rate', 'calcHIRate', 'Calc. HI Rate (mmBtu/hr)'),
		(datatableId, 7, 'operating_condition_cd', 'operatingConditionCode', 'Operating Condition Code'),
		(datatableId, 8, 'segment_number', 'segmentNumber', 'Segment Number'),
		(datatableId, 9, 'rpt_nox_emission_rate', 'rptNOXEmissionRate', 'Rpt. NOx Emission Rate (lb/mmBtu)'),
		(datatableId, 10, 'calc_nox_emission_rate', 'calcNOXEmissionRate', 'Calc. NOx Emission Rate (lb/mmBtu)'),
		(datatableId, 11, 'nox_mass_rate_formula_cd', 'noxMassRateFormulaCode', 'NOx Mass Rate Formula Code'),
		(datatableId, 12, 'rpt_nox_mass_rate', 'rptNOXMassRate', 'Rpt. NOx Mass Rate (lb/hr)'),
		(datatableId, 13, 'calc_nox_mass_rate', 'calcNOXMassRate', 'Calc. NOx Mass Rate (lb/hr)'),
		(datatableId, 15, 'error_codes', 'errorCodes', 'Hourly Errors');
END $$;