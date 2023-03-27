DO $$
DECLARE
	datasetCode text := 'SO2CEMS';
	groupCode text := 'EMVIEW';
	datatableId integer;
BEGIN
	DELETE FROM camdaux.dataset WHERE dataset_cd = datasetCode;
	
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name, sort_order, no_results_msg)
	VALUES(datasetCode, groupCode, 'Hourly SO2 CEMS View', 3, 'Hourly SO2 CEMS data does not exist for the specified monitor plan and reporting period.');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'Hourly SO2 CEMS', null, null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'date_hour', 'dateHour', 'Date/Hr'),
		(datatableId, 3, 'op_time', 'opTime', 'Op. Time'),
		(datatableId, 4, 'unit_load', 'unitLoad', 'Load'),
		(datatableId, 5, 'load_uom', 'loadUOM', 'Load UOM'),
		(datatableId, 6, 'unadj_so2', 'unadjustedSO2', 'Unadj. SO2 (ppm)'),
		(datatableId, 7, 'so2_baf', 'so2BAF', 'SO2 BAF'),
		(datatableId, 8, 'rpt_adj_so2', 'rptAdjustedSO2', 'Rpt. Adj. SO2 (ppm)'),
		(datatableId, 9, 'calc_adj_so2', 'calcAdjustedSO2', 'Adj. SO2 (ppm) Used in Calc.'),
		(datatableId, 10, 'so2_modc', 'so2MODC', 'SO2 MODC'),
		(datatableId, 11, 'so2_pma', 'so2PMA', 'SO2 PMA'),
		(datatableId, 12, 'unadj_flow', 'unadjustedFlow', 'Unadj. Flow (scfh)'),
		(datatableId, 13, 'flow_baf', 'flowBAF', 'Flow BAF'),
		(datatableId, 14, 'rpt_adj_flow', 'rptAdjustedFlow', 'Rpt. Adj. Flow (scfh)'),
		(datatableId, 15, 'adj_flow_used', 'adjustedFlowUsed', 'Adj. Flow (scfh) Used in Calc.'),
		(datatableId, 16, 'flow_modc', 'flowMODC', 'Flow MODC'),
		(datatableId, 17, 'flow_pma', 'flowPMA', 'Flow PMA'),
		(datatableId, 18, 'pct_h2o_used', 'pctH2OUsed', '% H2O used in Calc.'),
		(datatableId, 19, 'source_h2o_value', 'sourceH2OValue', 'Source of H2O Value'),
		(datatableId, 20, 'calc_hi_rate', 'calcHIRate', 'Calc. HI Rate (mmBtu/hr)'),
		(datatableId, 21, 'default_so2_emission_rate', 'defaultSO2EmissionRate', 'Default SO2 Emission Rate (lb/mmBtu)'),
		(datatableId, 22, 'so2_formula_cd', 'so2FormulaCode', 'SO2 Formula Code'),
		(datatableId, 23, 'rpt_so2_mass_rate', 'rptSO2MassRate', 'Rpt. SO2 Mass Rate (lb/hr)'),
		(datatableId, 24, 'calc_so2_mass_rate', 'calcSO2MassRate', 'Calc. SO2 Mass Rate (lb/hr)'),
		(datatableId, 25, 'error_codes', 'errorCodes', 'Hourly Errors');
END $$;