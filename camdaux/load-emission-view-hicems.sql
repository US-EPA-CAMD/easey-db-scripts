DO $$
DECLARE
	datasetCode text = 'HICEMS';
	datatableId integer;
BEGIN
	INSERT INTO camdaux.dataset(dataset_cd, template_cd, display_name, sort_order, no_results_msg)
	VALUES(datasetCode, 'EMVIEW', 'Hourly Heat Input CEMS View', 2, 'Hourly Heat Input CEMS data does not exist for the specified monitor plan and reporting period.');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'Hourly Heat Input CEMS', null, null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'date_hour', 'dateHour', 'Date/Hr'),
		(datatableId, 3, 'op_time', 'opTime', 'Op. Time'),
		(datatableId, 4, 'unit_load', 'unitLoad', 'Load'),
		(datatableId, 5, 'load_range', 'loadRange', 'Load Range'),
		(datatableId, 6, 'common_stack_load_range', 'commonStackLoadRange', 'Common Stack Load Range'),
		(datatableId, 7, 'load_uom', 'loadUOM', 'Load UOM'),
		(datatableId, 8, 'fuel_cd', 'fuelCode', 'Fuel Type'),
		(datatableId, 9, 'hi_modc', 'hiMODC', 'Heat  Input MODC'),
		(datatableId, 10, 'diluent_param', 'diluentParameter', 'Parameter (CO2/O2)'),
		(datatableId, 11, 'rpt_pct_diluent', 'rptPCTDiluent', 'Rpt.% CO2/O2'),
		(datatableId, 12, 'pct_diluent_used', 'pctDiluentUsed', '% CO2/O2 Used In Calc.'),
		(datatableId, 13, 'diluent_modc', 'diluentMODC', 'CO2/O2 MODC'),
		(datatableId, 14, 'diluent_pma', 'diluentPMA', 'CO2/O2 PMA'),
		(datatableId, 15, 'unadj_flow', 'unadjustedFlow', 'Unadj. Flow (scfh)'),
		(datatableId, 16, 'calc_flow_baf', 'calcFlowBAF', 'Calc. Flow BAF'),
		(datatableId, 17, 'rpt_adj_flow', 'rptAdjustedFlow', 'Rpt. Adj. Flow (scfh)'),
		(datatableId, 18, 'adj_flow_used', 'adjustedFlowUsed', 'Adj. Flow (scfh) Used in Calc.'),
		(datatableId, 19, 'flow_modc', 'flowMODC', 'Flow MODC'),
		(datatableId, 20, 'flow_pma', 'flowPMA', 'Flow PMA'),
		(datatableId, 21, 'pct_h2o_used', 'pctH2OUsed', '% H2O Used in Calc.'),
		(datatableId, 22, 'source_h2o_value', 'sourceH2OValue', 'Source of H2O Value'),
		(datatableId, 23, 'f_factor', 'fFactor', 'F-Factor'),
		(datatableId, 24, 'hi_formula_cd', 'hiFormulaCode', 'HI Formula Code'),
		(datatableId, 25, 'rpt_hi_rate', 'rptHIRate', 'Rpt. HI Rate (mmBtu/hr)'),
		(datatableId, 26, 'calc_hi_rate', 'calcHIRate', 'Calc. HI Rate (mmBtu/hr)'),
		(datatableId, 27, 'error_codes', 'errorCodes', 'Hourly Errors');
END $$;