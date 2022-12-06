DO $$
DECLARE
	datasetCode text = 'MATSSO2';
	datatableId integer;
BEGIN
	INSERT INTO camdaux.dataset(dataset_cd, template_cd, display_name, sort_order, no_results_msg)
	VALUES(datasetCode, 'EMVIEW', 'MATS SO2 View', 18, 'MATS SO2 data does not exist for the specified monitor plan and reporting period.');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'MATS SO2', null, null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'date_hour', 'dateHour', 'Date/Hr'),
		(datatableId, 2, 'op_time', 'opTime', 'Op. Time'),
		(datatableId, 3, 'mats_load', 'matsLoad', 'MATS Load'),
		(datatableId, 4, 'mats_startup_shutdown', 'matsStartupShutdown', 'MATS Startup - Shutdown'),
		(datatableId, 5, 'so2_conc_value', 'so2ConcValue', 'SO2 Conc. Value'),
		(datatableId, 6, 'so2_conc_modc_cd', 'so2ConcMODCCode', 'SO2 Conc. MODC'),
		(datatableId, 7, 'so2_conc_pma', 'so2ConcPMA', 'SO2 Conc. PMA'),
		(datatableId, 8, 'flow_rate', 'flowRate', 'Flow Rate'),
		(datatableId, 9, 'flow_modc', 'flowMODC', 'Flow MODC'),
		(datatableId, 10, 'flow_pma', 'flowPMA', 'Flow PMA'),
		(datatableId, 11, 'rpt_pct_diluent', 'rptPCTDiluent', 'Rptd. % Diluent'),
		(datatableId, 12, 'diluent_parameter', 'diluentParameter', 'Diluent Parameter'),
		(datatableId, 13, 'calc_pct_diluent', 'calcPCTDiluent', '% Diluent Used in Calc.'),
		(datatableId, 14, 'diluent_modc', 'diluentMODC', 'Diluent MODC'),
		(datatableId, 15, 'calc_pct_h2o', 'calcPCTH2O', '% H2O used in Calc.'),
		(datatableId, 16, 'h2o_source', 'h2oSource', 'Source of H2O Value'),
		(datatableId, 17, 'f_factor', 'fFactor', 'F-Factor'),
		(datatableId, 18, 'so2_formula_cd', 'so2FormulaCode', 'SO2 Formula Code'),
		(datatableId, 19, 'rpt_so2_rate', 'rptSO2Rate', 'Rpt. SO2 Rate'),
		(datatableId, 20, 'calc_so2_rate', 'calcSO2Rate', 'Calc. SO2 Rate'),
		(datatableId, 21, 'so2_uom', 'so2UOM', 'SO2 UOM'),
		(datatableId, 22, 'so2_modc_cd', 'so2MODCCode', 'MATS SO2 MODC'),
		(datatableId, 23, 'error_codes', 'errorCodes', 'Hourly Errors');
END $$;