DO $$
DECLARE
	datasetCode text := 'MATSHF';
	groupCode text := 'EMVIEW';
	datatableId integer;
BEGIN
	DELETE FROM camdaux.dataset WHERE dataset_cd = datasetCode;
	
	INSERT INTO camdaux.dataset(dataset_cd, group_cd, display_name, sort_order, no_results_msg)
	VALUES(datasetCode, groupCode, 'MATS HF View', 17, 'MATS HF data does not exist for the specified monitor plan and reporting period.');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'MATS HF', null, null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'date_hour', 'dateHour', 'Date/Hr'),
		(datatableId, 2, 'op_time', 'opTime', 'Op. Time'),
		(datatableId, 3, 'mats_load', 'matsLoad', 'MATS Load'),
		(datatableId, 4, 'mats_startup_shutdown', 'matsStartupShutdown', 'MATS Startup - Shutdown'),
		(datatableId, 5, 'hf_conc_value', 'hfConcValue', 'HF Conc. Value'),
		(datatableId, 6, 'hf_conc_modc_cd', 'hfConcMODCCode', 'HF Conc. MODC'),
		(datatableId, 7, 'hf_conc_pma', 'hfConcPMA', 'HF Conc. PMA'),
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
		(datatableId, 18, 'hf_formula_cd', 'hfFormulaCode', 'HF Formula Code'),
		(datatableId, 19, 'rpt_hf_rate', 'rptHFRate', 'Rpt. HF Rate'),
		(datatableId, 20, 'calc_hf_rate', 'calcHFRate', 'Calc. HF Rate'),
		(datatableId, 21, 'hf_uom', 'hfUOM', 'HF UOM'),
		(datatableId, 22, 'hf_modc_cd', 'hfMODCCode', 'HF MODC'),
		(datatableId, 23, 'error_codes', 'errorCodes', 'Hourly Errors');
END $$;