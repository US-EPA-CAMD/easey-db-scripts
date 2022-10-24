DO $$
DECLARE
	datasetCode text = 'CO2CEMS';
	datatableId integer;
BEGIN
	INSERT INTO camdaux.dataset(dataset_cd, template_cd, display_name, sort_order, no_results_msg)
	VALUES(datasetCode, 'EMVIEW', 'Hourly CO2 CEMS View', 6, 'Hourly CO2 CEMS data does not exist for the specified monitor plan and reporting period.');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'Hourly CO2 CEMS', null, null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'date_hour', 'dateHour', 'Date/Hr'),
		(datatableId, 3, 'op_time', 'opTime', 'Op. Time'),
		(datatableId, 4, 'unit_load', 'unitLoad', 'Load'),
		(datatableId, 5, 'load_uom', 'loadUOM', 'Load UOM'),
		(datatableId, 6, 'component_type', 'componentType', 'Component Type'),
		(datatableId, 7, 'rpt_pct_co2', 'rptPCTCO2', 'Rpt. % CO2'),
		(datatableId, 8, 'pct_co2_used', 'pctCO2Used', '% CO2 Used in Calc.'),
		(datatableId, 9, 'co2_modc', 'co2MODC', 'CO2 MODC'),
		(datatableId, 10, 'co2_pma', 'co2PMA', 'CO2 PMA'),
		(datatableId, 11, 'unadj_flow', 'unadjustedFlow', 'Unadj. Flow (scfh)'),
		(datatableId, 12, 'calc_flow_baf', 'calcFlowBAF', 'Calc. Flow BAF'),
		(datatableId, 13, 'rpt_adj_flow', 'rptAdjustedFlow', 'Rpt. Adj. Flow (scfh)'),
		(datatableId, 14, 'adj_flow_used', 'adjustedFlowUsed', 'Adj. Flow (scfh) Used in Calc.'),
		(datatableId, 15, 'flow_modc', 'flowMODC', 'Flow MODC'),
		(datatableId, 16, 'flow_pma', 'flowPMA', 'Flow PMA'),
		(datatableId, 17, 'pct_h2o_used', 'pctH2OUsed', '% H2O Used in Calc.'),
		(datatableId, 18, 'source_h2o_value', 'sourceH2OValue', 'Source of H2O Value'),
		(datatableId, 19, 'co2_formula_cd', 'co2FormulaCode', 'CO2 Formula Code'),
		(datatableId, 20, 'rpt_co2_mass_rate', 'rptCO2MassRate', 'Rpt. CO2 Mass Rate (tons/hr)'),
		(datatableId, 21, 'calc_co2_mass_rate', 'calcCO2MassRate', 'Calc. CO2 Mass Rate (tons/hr)'),
		(datatableId, 22, 'error_codes', 'errorCodes', 'Hourly Errors');
END $$;