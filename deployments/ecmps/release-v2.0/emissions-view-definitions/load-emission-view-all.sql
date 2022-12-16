DO $$
DECLARE
	datasetCode text = 'ALL';
	datatableId integer;
BEGIN
	INSERT INTO camdaux.dataset(dataset_cd, template_cd, display_name, sort_order, no_results_msg)
	VALUES(datasetCode, 'EMVIEW', 'Hourly Combined Parameters View', 1, 'Hourly Combined Parameters data does not exist for the specified monitor plan and reporting period.');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'Hourly Combined Parameters', null, null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'date_hour', 'dateHour', 'Date/Hr'),
		(datatableId, 2, 'op_time', 'opTime', 'Op. Time'),
		(datatableId, 3, 'unit_load', 'unitLoad', 'Load'),
		(datatableId, 4, 'load_uom', 'loadUOM', 'Load UOM'),
		(datatableId, 5, 'hi_formula_cd', 'hiFormulaCode', 'HI Formula Code'),
		(datatableId, 6, 'rpt_hi_rate', 'rptHIRate', 'Rpt. HI Rate (mmBtu/hr)'),
		(datatableId, 7, 'calc_hi_rate', 'calcHIRate', 'Calc. HI Rate (mmBtu/hr)'),
		(datatableId, 8, 'so2_formula_cd', 'so2FormulaCode', 'SO2 Formula Code'),
		(datatableId, 9, 'rpt_so2_mass_rate', 'rptSO2MassRate', 'Rpt. SO2 Mass Rate (lb/hr)'),
		(datatableId, 10, 'calc_so2_mass_rate', 'calcSO2MassRate', 'Calc. SO2 Mass Rate (lb/hr)'),
		(datatableId, 11, 'nox_rate_formula_cd', 'noxRateFormulaCode', 'NOx Rate Formula Code'),
		(datatableId, 12, 'rpt_adj_nox_rate', 'rptAdjustedNOXRate', 'Rpt. Adj. NOx Rate (lb/mmBtu)'),
		(datatableId, 13, 'calc_adj_nox_rate', 'calcAdjustedNOXRate', 'Calc. Adj. NOx Rate (lb/mmBtu)'),
		(datatableId, 14, 'nox_mass_formula_cd', 'noxMassFormulaCode', 'NOx Mass Formula Code'),
		(datatableId, 15, 'rpt_nox_mass', 'rptNOXMass', 'Rpt. NOx Mass Rate (lb/hr)'),
		(datatableId, 16, 'calc_nox_mass', 'calcNOXMass', 'Calc. NOx Mass Rate (lb/hr)'),
		(datatableId, 17, 'co2_formula_cd', 'co2FormulaCode', 'CO2 Formula Code'),
		(datatableId, 18, 'rpt_co2_mass_rate', 'rptCO2MassRate', 'Rpt. CO2 Mass Rate (tons/hr)'),
		(datatableId, 19, 'calc_co2_mass_rate', 'calcCO2MassRate', 'Calc. CO2 Mass Rate (tons/hr)'),
		(datatableId, 20, 'unadj_flow', 'unadjustedFlow', 'Unadj. Flow (scfh)'),
		(datatableId, 21, 'rpt_adj_flow', 'rptAdjustedFlow', 'Rpt. Adj. Flow (scfh)'),
		(datatableId, 22, 'adj_flow_used', 'adjustedFlowUsed', 'Adj. Flow (scfh) Used in Calc.'),
		(datatableId, 23, 'error_codes', 'errorCodes', 'Hourly Errors');
END $$;