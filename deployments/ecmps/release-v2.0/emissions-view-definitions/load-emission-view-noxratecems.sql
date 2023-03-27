DO $$
DECLARE
	datasetCode text := 'NOXRATECEMS';
	groupCode text := 'EMVIEW';
	datatableId integer;
BEGIN
	DELETE FROM camdaux.dataset WHERE dataset_cd = datasetCode;
	
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name, sort_order, no_results_msg)
	VALUES(datasetCode, groupCode, 'Hourly NOx Rate CEMS View', 5, 'Hourly NOx Rate CEMS data does not exist for the specified monitor plan and reporting period.');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'Hourly NOx Rate CEMS', null, null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'date_hour', 'dateHour', 'Date/Hr'),
		(datatableId, 2, 'op_time', 'opTime', 'Op. Time'),
		(datatableId, 3, 'unit_load', 'unitLoad', 'Load'),
		(datatableId, 4, 'load_uom', 'loadUOM', 'Load UOM'),
		(datatableId, 5, 'nox_rate_modc', 'noxRateMODC', 'NOx Rate MODC'),
		(datatableId, 6, 'nox_rate_pma', 'noxRatePMA', 'NOx Rate PMA'),
		(datatableId, 7, 'unadj_nox', 'unadjustedNOX', 'Unadj. NOx (ppm)'),
		(datatableId, 8, 'nox_modc', 'noxMODC', 'NOx MODC'),
		(datatableId, 9, 'diluent_param', 'diluentParameter', 'Diluent Parameter (CO2/O2)'),
		(datatableId, 10, 'rpt_diluent', 'rptDiluent', 'Rptd. % Diluent'),
		(datatableId, 11, 'pct_diluent_used', 'pctDiluentUsed', '% Diluent Used in Calc.'),
		(datatableId, 12, 'diluent_modc', 'diluentMODC', 'Diluent MODC'),
		(datatableId, 13, 'pct_h2o_used', 'pctH2OUsed', '% H2O Used in Calc.'),
		(datatableId, 14, 'source_h2o_value', 'sourceH2OValue', 'Source of H2O Value'),
		(datatableId, 15, 'f_factor', 'fFactor', 'F-Factor'),
		(datatableId, 16, 'nox_rate_formula_cd', 'noxFormulaCode', 'NOXR Formula Code'),
		(datatableId, 17, 'rpt_unadj_nox_rate', 'rptUnadjustedNOXRate', 'Rpt. Unadj. NOx Rate (lb/mmBtu)'),
		(datatableId, 18, 'calc_unadj_nox_rate', 'calcUnadjustedNOXRate', 'Calc. Unadj. NOx Rate (lb/mmBtu)'),
		(datatableId, 19, 'calc_nox_baf', 'calcNOXBAF', ' NOx BAF'),
		(datatableId, 20, 'rpt_adj_nox_rate', 'rptAdjustedNOXRate', 'Rpt. Adj. NOx Rate (lb/mmBtu)'),
		(datatableId, 21, 'calc_adj_nox_rate', 'calcAdjustedNOXRate', 'Calc. Adj. NOx Rate (lb/mmBtu)'),
		(datatableId, 22, 'calc_hi_rate', 'calcHIRate', 'Calc. HI Rate (mmBtu/hr)'),
		(datatableId, 23, 'nox_mass_formula_cd', 'noxFormulaCode', 'NOx Mass Formula Code'),
		(datatableId, 24, 'rpt_nox_mass', 'rptNOXMass', 'Rpt. NOx Mass Rate (lb/hr)'),
		(datatableId, 25, 'calc_nox_mass', 'calcNOXMass', 'Calc. NOx Mass Rate (lb/hr)'),
		(datatableId, 26, 'error_codes', 'errorCodes', 'Hourly Errors');
END $$;