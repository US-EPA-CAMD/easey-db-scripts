DO $$
DECLARE
	datasetCode text = 'NOXMASSCEMS';
	datatableId integer;
BEGIN
	INSERT INTO camdaux.dataset(dataset_cd, template_cd, display_name, sort_order, no_results_msg)
	VALUES(datasetCode, 'EMVIEW', 'Hourly NOx Mass CEMS View', 4, 'Hourly NOx Mass CEMS data does not exist for the specified monitor plan and reporting period.');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'Hourly NOx Mass CEMS', null, null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'date_hour', 'dateHour', 'Date/Hr'),
		(datatableId, 3, 'op_time', 'opTime', 'Op. Time'),
		(datatableId, 4, 'unit_load', 'unitLoad', 'Load'),
		(datatableId, 5, 'load_uom', 'loadUOM', 'Load UOM'),
		(datatableId, 6, 'unadj_nox', 'unadjustedNOX', 'Unadj. NOx (ppm)'),
		(datatableId, 7, 'calc_nox_baf', 'calcNOXBAF', 'Calc. NOx BAF'),
		(datatableId, 8, 'rpt_adj_nox', 'rptAdjustedNOX', 'Rpt. Adj. NOx (ppm)'),
		(datatableId, 9, 'adj_nox_used', 'adjustedNOXUsed', 'Adj. NOx (ppm) Used in Calc.'),
		(datatableId, 10, 'nox_modc', 'noxMODC', 'NOx MODC'),
		(datatableId, 11, 'nox_pma', 'noxPMA', 'NOX PMA'),
		(datatableId, 12, 'unadj_flow', 'unadjustedFlow', 'Unadj. Flow (scfh)'),
		(datatableId, 13, 'calc_flow_baf', 'calcFlowBAF', 'Calc. Flow BAF'),
		(datatableId, 14, 'rpt_adj_flow', 'rptAdjustedFlow', 'Rpt. Adj. Flow (scfh)'),
		(datatableId, 15, 'adj_flow_used', 'adjustedFlowUsed', 'Adj. Flow (scfh) Used in Calc.'),
		(datatableId, 16, 'flow_modc', 'flowMODC', 'Flow MODC'),
		(datatableId, 17, 'flow_pma', 'flowPMA', 'Flow PMA'),
		(datatableId, 18, 'pct_h2o_used', 'pctH2OUsed', '% H2O Used in Calc.'),
		(datatableId, 19, 'source_h2o_value', 'sourceH2OValue', 'Source of H2O Value'),
		(datatableId, 20, 'nox_mass_formula_cd', 'noxMassFormulaCode', 'NOx Mass Formula Code'),
		(datatableId, 21, 'rpt_nox_mass', 'rptNOXMass', 'Rpt. NOx Mass Rate (lbs/hr)'),
		(datatableId, 22, 'calc_nox_mass', 'calcNOXMass', 'Calc. NOx Mass Rate (lb/hr)'),
		(datatableId, 23, 'error_codes', 'errorCodes', 'Hourly Errors');
END $$;